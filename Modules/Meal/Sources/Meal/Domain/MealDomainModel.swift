//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 20/01/21.
//

import Foundation

public struct MealDomainModel: Equatable, Identifiable {
    
    public var id: String = ""
    public var title: String = ""
    public var image: String = ""
    public var category: String = ""
    public var area: String = ""
    public var instructions: String = ""
    public var tag: String = ""
    public var youtube: String = ""
    public var source: String = ""
    public var ingredients: [IngredientDomainModel] = []
    public var favorite: Bool = false
    
}
