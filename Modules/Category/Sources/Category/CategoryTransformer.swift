//
//  File.swift
//  
//
//  Created by PT Lintas Media Danawa on 03/12/20.
//

import Foundation
import Core

public struct CategoryTransformer: MapperCategory {
    
    public typealias Response = [CategoryResponse]
    public typealias Entity = [CategoryModuleEntity]
    public typealias Domain = [CategoryDomainModel]
    
    public init() {}
    
    public func transformResponseToEntity(response: [CategoryResponse]) -> [CategoryModuleEntity] {
        return response.map { result in
            let newCategory = CategoryModuleEntity()
            newCategory.id = result.id ?? ""
            newCategory.title = result.title ?? "Unknow"
            newCategory.image = result.image ?? "Unknow"
            newCategory.desc = result.description ?? "Unknow"
            return newCategory
        }
    }
    
    public func transformEntityToDomain(entity: [CategoryModuleEntity]) -> [CategoryDomainModel] {
        return entity.map { result in
            return CategoryDomainModel(
                id: result.id,
                title: result.title,
                image: result.image,
                description: result.desc
            )
        }
    }
    
    public func transformResponsesToEntities(input categoryResponses: [CategoryResponse]) -> [CategoryModuleEntity] {
        return categoryResponses.map { result in
            let newCategory = CategoryModuleEntity()
            newCategory.id = result.id ?? ""
            newCategory.title = result.title ?? "Unknow"
            newCategory.image = result.image ?? "Unknow"
            newCategory.desc = result.description ?? "Unknow"
            return newCategory
        }
    }
    
    public func transformEntitiesToDomains(input categoryEntities: [CategoryModuleEntity]) -> [CategoryDomainModel] {
        return categoryEntities.map { result in
            return CategoryDomainModel(
                id: result.id,
                title: result.title,
                image: result.image,
                description: result.desc
            )
        }
    }
    
    public func transformResponsesToDomains(input categoryResponses: [CategoryResponse]) -> [CategoryDomainModel] {
        return categoryResponses.map { result in
            return CategoryDomainModel(
                id: result.id ?? "",
                title: result.title ?? "Unknow",
                image: result.image ?? "Unknow",
                description: result.description ?? "Unknow"
            )
        }
    }
    
}
