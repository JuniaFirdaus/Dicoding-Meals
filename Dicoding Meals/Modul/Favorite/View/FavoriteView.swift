//
//  FavoriteView.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 03/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI
import Meal
import Core

struct FavoriteView: View {
    
    @ObservedObject var presenter: FavoritePresenter<
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
    
    var body: some View {
        ZStack {
            
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.meals.count == 0 {
                emptyFavorites
            } else {
                content
            }
        }.onAppear {
            self.presenter.getFavoriteMeals()
        }.navigationBarTitle(
            Text("Favorite Meals"),
            displayMode: .automatic
        )
    }
    
}

extension FavoriteView {
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyFavorites: some View {
        CustomEmptyView(
            image: "assetNoFavorite",
            title: "Your favorite is empty"
        ).offset(y: 80)
    }
    
    var content: some View {
        ScrollView(
            .vertical,
            showsIndicators: false
        ) {
            ForEach(
                self.presenter.meals,
                id: \.id
            ) { meal in
                ZStack {
                    self.presenter.linkBuilder(for: meal) {
                        FavoriteRow(meal: meal)
                    }.buttonStyle(PlainButtonStyle())
                }
                
            }
        }
    }
}
