//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 05/02/21.
//

import Core
import Meal
import Combine

public struct GetMealCategoriesRepository<
    CategoryLocaleDataSource: LocaleMealCategoryDataSource,
    RemoteDataSource: CategoryMealSource,
    Transformer: MapperMeal>: MealCategoryRepository
where
    CategoryLocaleDataSource.Entity == MealModulEntity,
    RemoteDataSource.Response == MealResponse,
    Transformer.Response == MealResponse,
    Transformer.Entity == MealModulEntity,
    Transformer.Domain == MealDomainModel {
    
    public typealias Request = Any
    public typealias Response = MealDomainModel
    
    private let _localeDataSource: CategoryLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: CategoryLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func getMeals(
        by category: Any?
    ) -> AnyPublisher<[MealDomainModel], Error> {
        return self._localeDataSource.getMeals(by: category as! String)
            .flatMap { result -> AnyPublisher<[MealDomainModel], Error> in
                if result.isEmpty {
                    return self._remoteDataSource.getMeals(by: category as! String)
                        .map { self._mapper.transformMealResponsesToEntities(by: category as! String, input: $0)}
                        .catch { _ in self._localeDataSource.getMeals(by: category as! String)}
                        .flatMap { self._localeDataSource.addMeals(by: category as! String, from: $0)}
                        .filter { $0 }
                        .flatMap { _ in self._localeDataSource.getMeals(by: category as! String)
                            .map {  _mapper.transformMealEntitiesToDomains(input: $0)}
                        }.eraseToAnyPublisher()
                } else {
                    return self._localeDataSource.getMeals(by: category as! String)
                        .map { _mapper.transformMealEntitiesToDomains(input: $0)}
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
}
