//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 27/01/21.
//

import RealmSwift
import Core

public struct IngredientTransFormer: IngredientMapper {
    
    public typealias Entity = IngredientModulEntity
    public typealias Domain = IngredientDomainModel
    
    public init() {}
    
    public static func transformIngredientEntitiesToDomains(input ingredientEntities: [IngredientModulEntity]) -> [IngredientDomainModel] {
        return ingredientEntities.map { result in
            return IngredientDomainModel(
                id: result.id,
                title: result.title,
                idMeal: result.idMeal
            )
        }
    }
    
    public static func transformIngredientResponseToEntities(by idMeal: String, input mealResponse: MealResponse) -> [IngredientModulEntity] {
        var ingredientEntities = [IngredientModulEntity]()
        var ingredients = [
            mealResponse.ingredient1, mealResponse.ingredient2,
            mealResponse.ingredient3, mealResponse.ingredient4,
            mealResponse.ingredient5, mealResponse.ingredient6,
            mealResponse.ingredient7, mealResponse.ingredient8,
            mealResponse.ingredient9, mealResponse.ingredient10,
            mealResponse.ingredient11, mealResponse.ingredient12,
            mealResponse.ingredient13, mealResponse.ingredient14,
            mealResponse.ingredient15, mealResponse.ingredient16,
            mealResponse.ingredient17, mealResponse.ingredient18,
            mealResponse.ingredient19, mealResponse.ingredient20
        ].compactMap { $0 }
        ingredients = ingredients.filter({ $0 != ""})
        
        var measures = [
            mealResponse.measure1, mealResponse.measure2,
            mealResponse.measure3, mealResponse.measure4,
            mealResponse.measure5, mealResponse.measure6,
            mealResponse.measure7, mealResponse.measure8,
            mealResponse.measure9, mealResponse.measure10,
            mealResponse.measure11, mealResponse.measure12,
            mealResponse.measure13, mealResponse.measure14,
            mealResponse.measure15, mealResponse.measure16,
            mealResponse.measure17, mealResponse.measure18,
            mealResponse.measure19, mealResponse.measure20
        ].compactMap { $0 }
        measures = measures.filter({ $0 != ""})
        
        let ingredientStrings = zip(ingredients, measures)
            .map { "\($0) \($1)" }
        
        for (index, ingredient) in ingredientStrings.enumerated() {
            let ingredientEntity = IngredientModulEntity()
            ingredientEntity.id = "\(index+1)"
            ingredientEntity.title = "\(index+1). \(ingredient)"
            ingredientEntity.idMeal = idMeal
            ingredientEntities.append(ingredientEntity)
        }
        
        return ingredientEntities
    }
    
    public static func transformIngredientResponseToDomains(by idMeal: String, input mealResponse: MealResponse) -> [IngredientDomainModel] {
        var ingredientDomains: [IngredientDomainModel] = []
        var ingredients = [
            mealResponse.ingredient1, mealResponse.ingredient2,
            mealResponse.ingredient3, mealResponse.ingredient4,
            mealResponse.ingredient5, mealResponse.ingredient6,
            mealResponse.ingredient7, mealResponse.ingredient8,
            mealResponse.ingredient9, mealResponse.ingredient10,
            mealResponse.ingredient11, mealResponse.ingredient12,
            mealResponse.ingredient13, mealResponse.ingredient14,
            mealResponse.ingredient15, mealResponse.ingredient16,
            mealResponse.ingredient17, mealResponse.ingredient18,
            mealResponse.ingredient19, mealResponse.ingredient20
        ].compactMap { $0 }
        ingredients = ingredients.filter({ $0 != ""})
        
        var measures = [
            mealResponse.measure1, mealResponse.measure2,
            mealResponse.measure3, mealResponse.measure4,
            mealResponse.measure5, mealResponse.measure6,
            mealResponse.measure7, mealResponse.measure8,
            mealResponse.measure9, mealResponse.measure10,
            mealResponse.measure11, mealResponse.measure12,
            mealResponse.measure13, mealResponse.measure14,
            mealResponse.measure15, mealResponse.measure16,
            mealResponse.measure17, mealResponse.measure18,
            mealResponse.measure19, mealResponse.measure20
        ].compactMap { $0 }
        measures = measures.filter({ $0 != ""})
        
        let ingredientStrings = zip(ingredients, measures)
            .map { "\($0) \($1)" }
        
        for (index, ingredient) in ingredientStrings.enumerated() {
            let ingredientDomain = IngredientDomainModel(
                id: "\(index+1)",
                title: "\(index+1). \(ingredient)",
                idMeal: idMeal
            )
            ingredientDomains.append(ingredientDomain)
        }
        return ingredientDomains
    }
    
}
