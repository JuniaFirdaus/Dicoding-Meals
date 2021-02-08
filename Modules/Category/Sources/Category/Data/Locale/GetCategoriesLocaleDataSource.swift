//
//  File.swift
//  
//
//  Created by PT Lintas Media Danawa on 03/12/20.
//

import Foundation
import Core
import Meal
import Combine
import RealmSwift

public struct GetCategoriesLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    public typealias Response = CategoryModuleEntity
    public typealias Entity = MealModulEntity
    
    private let _realm: Realm!
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func add(entities: [CategoryModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try self._realm.write {
                    for category in entities {
                        self._realm.add(category, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
    
    public func getCategories() -> AnyPublisher<[CategoryModuleEntity], Error> {
        return Future<[CategoryModuleEntity], Error> { completion in
            if let realm = self._realm {
                let categories: Results<CategoryModuleEntity> = {
                    realm.objects(CategoryModuleEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(categories.toArray(ofType: CategoryModuleEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    
    public func get(id: String) -> AnyPublisher<CategoryModuleEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int, entity: CategoryModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
