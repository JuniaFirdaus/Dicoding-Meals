//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 20/01/21.
//

import RealmSwift
import Core

public struct MealTransformer: MapperMeal {
    
    public typealias Response = MealResponse
    public typealias Entity = MealModulEntity
    public typealias Domain = MealDomainModel
    
    public init() {}
    
    public func transformMealResponsesToEntities(
        by category: String,
        input mealResponses: [MealResponse]
    ) -> [MealModulEntity] {
        return mealResponses.map { result in
            let newMeal = MealModulEntity()
            newMeal.id = result.id ?? ""
            newMeal.title = result.title ?? "Unknow"
            newMeal.image = result.image ?? "Unknow"
            newMeal.category = category
            return newMeal
        }
    }
    
    public func transformMealResponsesToDomains(
        by category: String,
        input mealResponses: [MealResponse]
    ) -> [MealDomainModel] {
        return mealResponses.map { result in
            var newMeal = MealDomainModel(
                id: result.id ?? "",
                title: result.title ?? "Unknow",
                image: result.image ?? "Unknow"
            )
            newMeal.category = category
            return newMeal
        }
    }
    
    public func transformMealResponsesToDomains(
        input mealResponses: [MealResponse]
    ) -> [MealDomainModel] {
        return mealResponses.map { result in
            let ingredients = IngredientTransFormer.transformIngredientResponseToDomains(
                by: result.id ?? "",
                input: result
            )
            return MealDomainModel(
                id: result.id ?? "",
                title: result.title ?? "Unknow",
                image: result.image ?? "Unknow",
                category: result.category ?? "Unknow",
                area: result.area ?? "Unknow",
                instructions: result.instructions ?? "Unknow",
                tag: result.tag ?? "Unknow",
                youtube: result.youtube ?? "Unknow",
                source: result.source ?? "Unknow",
                ingredients: ingredients
            )
        }
    }
    
    public func transformMealEntitiesToDomains(
        input mealEntities: [MealModulEntity]
    ) -> [MealDomainModel] {
        return mealEntities.map { result in
            let ingredients = IngredientTransFormer.transformIngredientEntitiesToDomains(
                input: Array(result.ingredients)
            )
            return MealDomainModel(
                id: result.id ,
                title: result.title,
                image: result.image,
                category: result.category,
                area: result.area,
                instructions: result.instructions,
                tag: result.tag,
                youtube: result.youtube,
                source: result.source,
                ingredients: ingredients,
                favorite: result.favorite
            )
        }
    }
    
    public func transformDetailMealEntityToDomain(
        input mealEntity: MealModulEntity
    ) -> MealDomainModel {
        let ingredients = IngredientTransFormer.transformIngredientEntitiesToDomains(
            input: Array(mealEntity.ingredients)
        )
        return MealDomainModel(
            id: mealEntity.id ,
            title: mealEntity.title,
            image: mealEntity.image,
            category: mealEntity.category,
            area: mealEntity.area,
            instructions: mealEntity.instructions,
            tag: mealEntity.tag,
            youtube: mealEntity.youtube,
            source: mealEntity.source,
            ingredients: ingredients,
            favorite: mealEntity.favorite
        )
    }
    
    public func transformDetailMealEntityToDomains(
        input mealEntities: [MealModulEntity]
    ) -> [MealDomainModel] {
        return mealEntities.map { result in
            let ingredients = IngredientTransFormer.transformIngredientEntitiesToDomains(
                input: Array(result.ingredients)
            )
            return MealDomainModel(
                id: result.id ,
                title: result.title,
                image: result.image,
                category: result.category,
                area: result.area,
                instructions: result.instructions,
                tag: result.tag,
                youtube: result.youtube,
                source: result.source,
                ingredients: ingredients,
                favorite: result.favorite
            )
        }
    }
    
    public func transformDetailMealResponseToEntity(
        by idMeal: String,
        input mealResponse: MealResponse
    ) -> MealModulEntity {
        let ingredients = IngredientTransFormer.transformIngredientResponseToEntities(
            by: idMeal,
            input: mealResponse
        )
        let mealEntity = MealModulEntity()
        mealEntity.id = mealResponse.id ?? ""
        mealEntity.title = mealResponse.title ?? "Unknow"
        mealEntity.image = mealResponse.image ?? "Unknow"
        mealEntity.category = mealResponse.category ?? "Unknow"
        mealEntity.area = mealResponse.area ?? "Unknow"
        mealEntity.instructions = mealResponse.instructions ?? "Unknow"
        mealEntity.tag = mealResponse.tag ?? "Unknow"
        mealEntity.youtube = mealResponse.youtube ?? "Unknow"
        mealEntity.source = mealResponse.source ?? "Unknow"
        mealEntity.ingredients.append(objectsIn: ingredients)
        return mealEntity
    }
    
    public func transformDetailMealResponseToEntity(
        input mealResponse: [MealResponse]
    ) -> [MealModulEntity] {
        return mealResponse.map { result in
            let ingredients = IngredientTransFormer.transformIngredientResponseToEntities(
                by: result.id ?? "",
                input: result
            )
            let mealEntity = MealModulEntity()
            mealEntity.id = result.id ?? ""
            mealEntity.title = result.title ?? "Unknow"
            mealEntity.image = result.image ?? "Unknow"
            mealEntity.category = result.category ?? "Unknow"
            mealEntity.area = result.area ?? "Unknow"
            mealEntity.instructions = result.instructions ?? "Unknow"
            mealEntity.tag = result.tag ?? "Unknow"
            mealEntity.youtube = result.youtube ?? "Unknow"
            mealEntity.source = result.source ?? "Unknow"
            mealEntity.ingredients.append(objectsIn: ingredients)
            return mealEntity
        }
    }
}
