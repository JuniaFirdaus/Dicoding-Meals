//
//  File.swift
//  
//
//  Created by PT Lintas Media Danawa on 03/12/20.
//

import Combine

public protocol MealRepository {
    associatedtype Request
    associatedtype Response
    
    func getMeal(by idMeal: Request?) -> AnyPublisher<Response, Error>
    
    func searchMeal(by title: Request?) -> AnyPublisher<[Response], Error>
    
    func getFavoriteMeals() -> AnyPublisher<[Response], Error>
    
    func updateFavoriteMeal(by idMeal: Request?) -> AnyPublisher<Response, Error>
}


public protocol CategoryRepository {
    associatedtype Request
    associatedtype Response
    
    func getCategories() -> AnyPublisher<Response, Error>
    
}

public protocol MealCategoryRepository {
    associatedtype Request
    associatedtype Response
    
    func getMeals(by category: Request?) -> AnyPublisher<[Response], Error>
}
