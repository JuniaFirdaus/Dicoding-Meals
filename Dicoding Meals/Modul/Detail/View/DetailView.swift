//
//  DetailView.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/12/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Meal
import Category

struct DetailView: View {
    
    @ObservedObject var presenter: DetailPresenter<
        Any,
        MealDomainModel,
        InteractorDetail<
            Any, MealDomainModel,
            GetMealCategoriesRepository<
                GetMealCategoriesLocaleDataSource,
                GetMealCategoriesRemoteDataSource,
                MealTransformer
            >
        >
    >
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isLoading {
                errorIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageCategory
                        spacer
                        content
                        spacer
                    }.padding()
                }
            }
        }.onAppear {
            if self.presenter.meals.count == 0 {
                self.presenter.getMeals(title: presenter.category.title)
            }
        }.navigationBarTitle(Text(self.presenter.category.title), displayMode: .large)
    }
}

extension DetailView {
    var spacer: some View {
        Spacer()
    }
    
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
    
    var imageCategory: some View {
        WebImage(url: URL(string: self.presenter.category.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 250.0, height: 250.0, alignment: .center)
    }
    
    var mealsHorizontal: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(self.presenter.meals, id: \.id) { meal in
                    ZStack {
                        self.presenter.linkBuilder(for: meal) {
                            MealRow(meal: meal)
                                .frame(width: 150, height: 150)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
    
    var description: some View {
        Text(self.presenter.category.description)
            .font(.system(size: 15))
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !presenter.meals.isEmpty {
                headerTitle("Meals from \(self.presenter.category.title)")
                    .padding(.bottom)
                mealsHorizontal
            }
            spacer
            headerTitle("Description")
                .padding([.top, .bottom])
            description
        }
    }
}
