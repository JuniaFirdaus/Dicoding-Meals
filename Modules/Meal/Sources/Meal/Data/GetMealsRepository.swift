//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 08/02/21.
//

import Core
import Combine

// 1
public struct GetMealsRepository<
    MealLocaleDataSource: LocaleMealDataSource,
    RemoteDataSource: MealDataSource,
    Transformer: MapperMeal>: MealRepository
where
    // 2
    MealLocaleDataSource.Entity == MealModulEntity,
    RemoteDataSource.Response == MealResponse,
    Transformer.Response == MealResponse,
    Transformer.Entity == MealModulEntity,
    Transformer.Domain == MealDomainModel {
    
    // 3
    public typealias Request = Any
    public typealias Response = MealDomainModel
    
    private let _localeDataSource: MealLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: MealLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func getMeal(by idMeal: Any?) -> AnyPublisher<MealDomainModel, Error> {
        return _localeDataSource.getMeal(by: idMeal as! String )
            .flatMap { result -> AnyPublisher<MealDomainModel, Error> in
                if result.ingredients.isEmpty {
                    return self._remoteDataSource.getMeal(by: idMeal as! String )
                        .map { self._mapper.transformDetailMealResponseToEntity(by: idMeal as! String , input: $0) }
                        .catch { _ in self._localeDataSource.getMeal(by: idMeal as! String ) }
                        .flatMap { self._localeDataSource.updateMeal(by: idMeal as! String , meal: $0) }
                        .filter { $0 }
                        .flatMap { _ in self._localeDataSource.getMeal(by: idMeal as! String )
                            .map { _mapper.transformDetailMealEntityToDomain(input: $0)}
                        }.eraseToAnyPublisher()
                } else {
                    return self._localeDataSource.getMeal(by: idMeal as! String )
                        .map { _mapper.transformDetailMealEntityToDomain(input: $0)}
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    public func searchMeal(
        by title: Any?
    ) -> AnyPublisher<[MealDomainModel], Error> {
        return self._remoteDataSource.searchMeal(by: title as! String)
            .map { self._mapper.transformDetailMealResponseToEntity(input: $0)}
            .catch { _ in self._localeDataSource.getMealsBy(title as! String) }
            .flatMap { responses  in
                self._localeDataSource.getMealsBy(title as! String)
                    .flatMap { locale -> AnyPublisher<[MealDomainModel], Error> in
                        if responses.count > locale.count {
                            return self._localeDataSource.addMealsBy(title as! String, from: responses)
                                .filter { $0 }
                                .flatMap { _ in self._localeDataSource.getMealsBy(title as! String)
                                    .map { _mapper.transformDetailMealEntityToDomains(input: $0)}
                                }.eraseToAnyPublisher()
                        } else {
                            return self._localeDataSource.getMealsBy(title as! String)
                                .map { _mapper.transformDetailMealEntityToDomains(input: $0) }
                                .eraseToAnyPublisher()
                        }
                    }
            }.eraseToAnyPublisher()
    }
    
    public func getFavoriteMeals() -> AnyPublisher<[MealDomainModel], Error> {
        return _localeDataSource.getFavoriteMeals()
            .map { self._mapper.transformMealEntitiesToDomains(input: $0)}
            .eraseToAnyPublisher()
    }
    
    public func updateFavoriteMeal(
        by idMeal: Any?
    ) -> AnyPublisher<MealDomainModel, Error> {
        return self._localeDataSource.updateFavoriteMeal(by: idMeal as! String)
            .map { self._mapper.transformDetailMealEntityToDomain(input: $0)}
            .eraseToAnyPublisher()
    }

}
