//
//  Injection.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import Foundation
import RealmSwift
import Core
import Category
import Meal
import UIKit

final class Injection: NSObject {
    
    func provideCategory<U: UseCaseHome>() -> U where U.Request == Any, U.Response == [CategoryDomainModel] {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let locale = GetCategoriesLocaleDataSource(realm: (appDelegate?.realm)!)
        
        let remote = GetCategoriesRemoteDataSource(endpoint: Endpoints.Gets.categories.url)
        
        let mapper = CategoryTransformer()
        
        let repository = GetCategoriesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return (InteractorHome(repository: repository) as? U)!
    }
    
    func provideMeal<U: UseCaseMeal>() -> U where U.Request == Any, U.Response == MealDomainModel {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let locale = GetMealsLocaleDataSource(realm: (appDelegate?.realm)!)
        
        let remote = GetMealsRemoteDataSource(endpoint: Endpoints.Gets.meal.url)
        
        let mapper = MealTransformer()
        
        let repository = GetMealsRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return (InteractorMeal(repository: repository) as? U)!
    }
    
    func provideFavorite<U: UseCaseFavorite>() -> U where U.Request == Any, U.Response == MealDomainModel {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let locale = GetMealsLocaleDataSource(realm: (appDelegate?.realm)!)
        
        let remote = GetMealsRemoteDataSource(endpoint: Endpoints.Gets.meals.url)
        
        let mapper = MealTransformer()
        
        let repository = GetMealsRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return (InteractorFavorite(repository: repository) as? U)!
    }
    
    func provideSearch<U: UseCaseSearch>() -> U where U.Request == Any, U.Response == MealDomainModel {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let locale = GetMealsLocaleDataSource(realm: (appDelegate?.realm)!)
        
        let remote = GetMealsRemoteDataSource(endpoint: Endpoints.Gets.search.url)
        
        let mapper = MealTransformer()
        
        let repository = GetMealsRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return (InteractorSearch(repository: repository) as? U)!
    }
    
    func provideDetail<U: UseCaseDetail>() -> U where U.Request == Any, U.Response == MealDomainModel {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let locale = GetMealCategoriesLocaleDataSource(realm: (appDelegate?.realm)!)
        
        let remote = GetMealCategoriesRemoteDataSource(endpoint: Endpoints.Gets.meals.url)
        
        let mapper = MealTransformer()
        
        let repository = GetMealCategoriesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return (InteractorDetail(repository: repository) as? U)!
    }
}
