//
//  SceneDelegate.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import UIKit
import SwiftUI
import RealmSwift
import Core
import Meal
import Category

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        
        let favoriteUseCase: InteractorFavorite<
            Any, MealDomainModel,
            GetMealsRepository<
                GetMealsLocaleDataSource,
                GetMealsRemoteDataSource,
                MealTransformer>
        > = Injection.init().provideFavorite()
        
        let searchUseCase: InteractorSearch<
            Any, MealDomainModel,
            GetMealsRepository<
                GetMealsLocaleDataSource,
                GetMealsRemoteDataSource,
                MealTransformer
            >
        > = Injection.init().provideSearch()
        
        let categoryUseCase: InteractorHome<
            Any,
            [CategoryDomainModel],
            GetCategoriesRepository<
                GetCategoriesLocaleDataSource,
                GetCategoriesRemoteDataSource,
                CategoryTransformer>
        > = Injection.init().provideCategory()
        
        let homePresenter = HomePresenter(useCase: categoryUseCase)
        let favoritePresenter = FavoritePresenter(useCase: favoriteUseCase)
        let searchPresenter = SearchPresenter(useCase: searchUseCase)
        
        let contentView = ContentView()
            .environmentObject(homePresenter)
            .environmentObject(favoritePresenter)
            .environmentObject(searchPresenter)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
}
