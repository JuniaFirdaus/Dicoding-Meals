//
//  HomeView.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI
import Core
import Category

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter<
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
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.categories.isEmpty {
                emptyCategories
            } else {
                content
            }
        }.onAppear {
            if self.presenter.categories.count == 0 {
                self.presenter.getCategories()
            }
        }.navigationBarTitle(
            Text("Meals Apps"),
            displayMode: .automatic
        )
    }
    
}

extension HomeView {
    
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
    
    var emptyCategories: some View {
        CustomEmptyView(
            image: "ic_no_data_found",
            title: "The meal category is empty"
        ).offset(y: 80)
    }
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(
                self.presenter.categories,
                id: \.id
            ) { category in
                ZStack {
                    self.presenter.linkBuilder(for: category) {
                        CategoryRow(category: category)
                    }.buttonStyle(PlainButtonStyle())
                }.padding(8)
                                
            }
        }
    }
    
}
