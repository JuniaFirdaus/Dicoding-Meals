//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 20/01/21.
//

import Foundation
import RealmSwift

public class MealModulEntity: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var image = ""
    @objc dynamic var category = ""
    @objc dynamic var area = ""
    @objc dynamic var instructions = ""
    @objc dynamic var tag = ""
    @objc dynamic var youtube = ""
    @objc dynamic var source = ""
    @objc dynamic var favorite = false
    
    var ingredients = List<IngredientModulEntity>()
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
