//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 20/01/21.
//

import Foundation
import Core
import Combine
import RealmSwift
import Foundation

public struct GetMealsLocaleDataSource: LocaleMealDataSource {
    
    public typealias Request = Any
    public typealias Response = MealModulEntity
    private let _realm: Realm!
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func getMeal(
        by idMeal: String
    ) -> AnyPublisher<MealModulEntity, Error> {
        return Future<MealModulEntity, Error> { completion in
            if let realm = self._realm {
                let meals: Results<MealModulEntity> = {
                    realm.objects(MealModulEntity.self)
                        .filter("id = '\(idMeal)'")
                }()
                
                guard let meal = meals.first else {
                    completion(.failure(DatabaseError.requestFailed))
                    return
                }
                
                completion(.success(meal))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
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
    
    public func getMealsBy(
        _ title: String
    ) -> AnyPublisher<[MealModulEntity], Error> {
        return Future<[MealModulEntity], Error> { completion in
            if let realm = self._realm {
                let meals: Results<MealModulEntity> = {
                    realm.objects(MealModulEntity.self)
                        .filter("title contains[c] %@", title)
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
    
    public func addMealsBy(
        _ title: String,
        from meals: [MealModulEntity]
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self._realm {
                do {
                    try realm.write {
                        for meal in meals {
                            if let mealEntity = realm.object(ofType: MealModulEntity.self, forPrimaryKey: meal.id) {
                                if mealEntity.title == meal.title {
                                    meal.favorite = mealEntity.favorite
                                    realm.add(meal, update: .all)
                                } else {
                                    realm.add(meal)
                                }
                            } else {
                                realm.add(meal)
                            }
                        }
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func updateMeal(
        by idMeal: String,
        meal: MealModulEntity
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self._realm, let mealEntity = {
                realm.objects(MealModulEntity.self).filter("id = '\(idMeal)'")
            }().first {
                do {
                    try realm.write {
                        mealEntity.setValue(meal.area, forKey: "area")
                        mealEntity.setValue(meal.instructions, forKey: "instructions")
                        mealEntity.setValue(meal.tag, forKey: "tag")
                        mealEntity.setValue(meal.youtube, forKey: "youtube")
                        mealEntity.setValue(meal.source, forKey: "source")
                        mealEntity.setValue(meal.favorite, forKey: "favorite")
                        mealEntity.setValue(meal.ingredients, forKey: "ingredients")
                    }
                    completion(.success(true))
                    
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func addIngredients(
        ingredients: [MealModulEntity]
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self._realm {
                do {
                    try realm.write {
                        for ingredient in ingredients {
                            realm.add(ingredient)
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
    
    public func getFavoriteMeals() -> AnyPublisher<[MealModulEntity], Error> {
        return Future<[MealModulEntity], Error> { completion in
            if let realm = self._realm {
                let mealEntities = {
                    realm.objects(MealModulEntity.self)
                        .filter("favorite = \(true)")
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(mealEntities.toArray(ofType: MealModulEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func updateFavoriteMeal(
        by idMeal: String
    ) -> AnyPublisher<MealModulEntity, Error> {
        return Future<MealModulEntity, Error> { completion in
            if let realm = self._realm, let mealEntity = {
                realm.objects(MealModulEntity.self).filter("id = '\(idMeal)'")
            }().first {
                do {
                    try realm.write {
                        mealEntity.setValue(!mealEntity.favorite, forKey: "favorite")
                    }
                    completion(.success(mealEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}
