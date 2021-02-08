//
//  File.swift
//  
//
//  Created by PT Lintas Media Danawa on 03/12/20.
//

import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
    func get(id: String) -> AnyPublisher<Response, Error>
    func update(id: Int, entity: Response) -> AnyPublisher<Bool, Error>
    func getCategories() -> AnyPublisher<[Response], Error>
}

public protocol LocaleMealCategoryDataSource {
    associatedtype Request
    associatedtype Entity
    associatedtype Response
    
    func getMeals(by category: String) -> AnyPublisher<[Entity], Error>
    func addMeals(by category: String, from meals: [Entity]) -> AnyPublisher<Bool, Error>
}

public protocol LocaleMealDataSource {
    associatedtype Request
    associatedtype Entity
    
    func getMeal(by idMeal: String) -> AnyPublisher<Entity, Error>
    func getMealsBy(_ title: String) -> AnyPublisher<[Entity], Error>
    func addMeals(by category: String, from meals: [Entity]) -> AnyPublisher<Bool, Error>
    func addMealsBy(_ title: String, from meals: [Entity]) -> AnyPublisher<Bool, Error>
    func updateMeal(by idMeal: String, meal: Entity) -> AnyPublisher<Bool, Error>
    func getFavoriteMeals() -> AnyPublisher<[Entity], Error>
    func updateFavoriteMeal(by idMeal: String) -> AnyPublisher<Entity, Error>
    
}
