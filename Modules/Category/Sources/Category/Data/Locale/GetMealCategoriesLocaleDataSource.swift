//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 05/02/21.
//
import Foundation
import Core
import Meal
import Combine
import RealmSwift

import Foundation

public struct GetMealCategoriesLocaleDataSource: LocaleMealCategoryDataSource {
    
    public typealias Request = Any
    public typealias Response = CategoryModuleEntity
    public typealias Entity = MealModulEntity
    
    private let _realm: Realm!
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func getMeals(
        by category: String
    ) -> AnyPublisher<[MealModulEntity], Error> {
        return Future<[MealModulEntity], Error> { completion in
            if let realm = self._realm {
                let meals: Results<MealModulEntity> = {
                    realm.objects(MealModulEntity.self)
                        .filter("category = '\(category)'")
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(meals.toArray(ofType: MealModulEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func addMeals(
        by category: String,
        from meals: [MealModulEntity]
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self._realm {
                do {
                    try realm.write {
                        for meal in meals {
                            realm.add(meal, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}
