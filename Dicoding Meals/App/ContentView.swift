//
//  ContentView.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

//
//  ContentView.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI
import Core
import Meal
import Category

struct ContentView: View {
    
    @EnvironmentObject var homePresenter: HomePresenter<
        Any,
        CategoryDomainModel,
        InteractorHome<
            Any,
            [CategoryDomainModel],
            GetCategoriesRepository<
                GetCategoriesLocaleDataSource,
                GetCategoriesRemoteDataSource,
                CategoryTransformer
            >
        >
    >
    
    @EnvironmentObject var favoritePresenter: FavoritePresenter<
        Any,
        MealDomainModel,
        InteractorFavorite<
            Any, MealDomainModel,
            GetMealsRepository<
                GetMealsLocaleDataSource,
                GetMealsRemoteDataSource,
                MealTransformer
            >
        >
    >
    
    @EnvironmentObject var searchPresenter: SearchPresenter<
        Any,
        MealDomainModel,
        InteractorSearch<
            Any, MealDomainModel,
            GetMealsRepository<
                GetMealsLocaleDataSource,
                GetMealsRemoteDataSource,
                MealTransformer
            >
        >
    >
        
    var body: some View {
        TabView {
            NavigationView {
                HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }
            
            NavigationView {
                SearchView(presenter: searchPresenter)
            }.tabItem {
                TabItem(imageName: "magnifyingglass", title: "Search")
            }
            
            NavigationView {
                FavoriteView(presenter: favoritePresenter)
            }.tabItem {
                TabItem(imageName: "heart", title: "Favorite")
            }
            
            NavigationView {
                AboutView()
            }.tabItem {
                TabItem(imageName: "person", title: "About")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
