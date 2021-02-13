//
//  File.swift
//  
//
//  Created by PT Lintas Media Danawa on 03/12/20.
//

import RealmSwift

public protocol MapperCategory {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToEntity(
        response: Response
    ) -> Entity
    
    func transformEntityToDomain(
        entity: Entity
    ) -> Domain
    
    func transformResponsesToEntities(
        input categoryResponses: Response
    ) -> Entity
    
    func transformEntitiesToDomains(
        input categoryEntities: Entity
    ) -> Domain
    
    func transformResponsesToDomains(
        input categoryResponses: Response
    ) -> Domain
    
}

public protocol MapperMeal {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformMealResponsesToEntities(
        by category: String,
        input mealResponses: [Response]
    ) -> [Entity]
        
    func transformMealResponsesToDomains(
        by category: String,
        input mealResponses: [Response]
    ) -> [Domain]
    
    func transformMealResponsesToDomains(
        input mealResponses: [Response]
    ) -> [Domain]
    
    func transformMealEntitiesToDomains(
        input mealEntities: [Entity]
    ) -> [Domain]
    
    func transformDetailMealEntityToDomain(
        input mealEntity: Entity
    ) -> Domain
    
    func transformDetailMealEntityToDomains(
        input mealEntities: [Entity]
    ) -> [Domain]
    
    func transformDetailMealResponseToEntity(
        by idMeal: String,
        input mealResponse: Response
    ) -> Entity
    
    func transformDetailMealResponseToEntity(
        input mealResponse: [Response]
    ) -> [Entity]
    
}

public protocol IngredientMapper {
    
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    static func transformIngredientEntitiesToDomains(
        input ingredientEntities: [Entity]
    ) -> [Domain]
    
    static func transformIngredientResponseToEntities(
        by idMeal: String,
        input mealResponse: Response
    ) -> [Entity]
    
    static func transformIngredientResponseToDomains(
        by idMeal: String,
        input mealResponse: Response
    ) -> [Domain]
    
}
