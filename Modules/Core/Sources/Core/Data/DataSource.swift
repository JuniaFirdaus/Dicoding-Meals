//
//  File.swift
//  
//
//  Created by PT Lintas Media Danawa on 03/12/20.
//

import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func getCategories() -> AnyPublisher<Response, Error>
    
}

public protocol CategoryMealSource {
    associatedtype Request
    associatedtype Response
    associatedtype ResponseCategory
    
    func getMeals(by category: String) -> AnyPublisher<[Response], Error>
}

public protocol MealDataSource {
    associatedtype Request
    associatedtype Response
    
    func getMeal(
        by id: String
    ) -> AnyPublisher<Response, Error>
    
    func searchMeal(
        by title: String
    ) -> AnyPublisher<[Response], Error>
}
