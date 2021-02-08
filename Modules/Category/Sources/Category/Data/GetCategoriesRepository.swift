//
//  File.swift
//  
//
//  Created by PT Lintas Media Danawa on 03/12/20.
//

import Core
import Combine

public struct GetCategoriesRepository<
    CategoryLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: MapperCategory>: CategoryRepository
where
    CategoryLocaleDataSource.Response == CategoryModuleEntity,
    RemoteDataSource.Response == [CategoryResponse],
    Transformer.Response == [CategoryResponse],
    Transformer.Entity == [CategoryModuleEntity],
    Transformer.Domain == [CategoryDomainModel] {
    
    public typealias Request = Any
    public typealias Response = [CategoryDomainModel]
    
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
    
    public func getCategories() -> AnyPublisher<[CategoryDomainModel], Error> {
        return _localeDataSource.getCategories()
            .flatMap { result -> AnyPublisher<[CategoryDomainModel], Error> in
                if result.isEmpty {
                    return self._remoteDataSource.getCategories()
                        .map { self._mapper.transformResponseToEntity(response: $0) }
                        .catch { _ in self._localeDataSource.getCategories() }
                        .flatMap { self._localeDataSource.add(entities: $0) }
                        .filter { $0 }
                        .flatMap { _ in self._localeDataSource.getCategories()
                            .map { self._mapper.transformEntityToDomain(entity: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self._localeDataSource.getCategories()
                        .map { self._mapper.transformEntityToDomain(entity: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
}
