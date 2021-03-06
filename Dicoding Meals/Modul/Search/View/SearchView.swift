//
//  SearchView.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/12/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import Core
import Meal
import SwiftUI

struct SearchView: View {
    
    @ObservedObject var presenter: SearchPresenter<
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
        VStack {
            SearchBar(
                text: $presenter.title,
                onSearchButtonClicked: presenter.searchMeal
            )
            
            ZStack {
                if presenter.isLoading {
                    loadingIndicator
                } else if presenter.title.isEmpty {
                    emptyTitle
                } else if presenter.meals.isEmpty {
                    emptyMeals
                } else if presenter.isError {
                    errorIndicator
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(
                            self.presenter.meals,
                            id: \.id
                        ) { meal in
                            ZStack {
                                self.presenter.linkBuilder(for: meal) {
                                    SearchRow(meal: meal)
                                }.buttonStyle(PlainButtonStyle())
                            }.padding(8)
                        }
                    }
                }
            }
            Spacer()
        }.navigationBarTitle(
            Text("Search Meals"),
            displayMode: .automatic
        )
    }
}

extension SearchView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "ic_no_data_found",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyTitle: some View {
        CustomEmptyView(
            image: "ic_no_data_found",
            title: "Come on, find your favorite food!"
        ).offset(y: 50)
    }
    var emptyMeals: some View {
        CustomEmptyView(
            image: "ic_no_data_found",
            title: "Data not found"
        ).offset(y: 80)
    }
    
}
