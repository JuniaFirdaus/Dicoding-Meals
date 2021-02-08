//
//  MealView.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/12/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI
import Core
import Meal
import SDWebImageSwiftUI

struct MealView: View {
    
    @State private var showingAlert = false
    @ObservedObject var presenter: MealPresenter<
        Any, MealDomainModel,
        InteractorMeal<
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
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageMeal
                        menuButtonMeal
                        content
                    }.padding()
                }
            }
        }.onAppear {
            self.presenter.getMeal(request: presenter.meal.id)
        }.alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Oops!"),
                message: Text("Something wrong!"),
                dismissButton: .default(Text("OK"))
            )
        }.navigationBarTitle(
            Text(presenter.meal.title),
            displayMode: .automatic
        )
    }
    
}

extension MealView {
    
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
    
    var menuButtonMeal: some View {
        HStack(alignment: .center) {
            Spacer()
            CustomIcon(
                imageName: "link.circle",
                title: "Source"
            ).onTapGesture {
                self.openUrl(self.presenter.meal.source)
            }
            Spacer()
            CustomIcon(
                imageName: "video",
                title: "Video"
            ).onTapGesture {
                self.openUrl(self.presenter.meal.youtube)
            }
            Spacer()
            if presenter.meal.favorite {
                CustomIcon(
                    imageName: "heart.fill",
                    title: "Favorited"
                ).onTapGesture { self.presenter.updateFavoriteMeal(request: presenter.meal.id) }
            } else {
                CustomIcon(
                    imageName: "heart",
                    title: "Favorite"
                ).onTapGesture { self.presenter.updateFavoriteMeal(request: presenter.meal.id) }
            }
            Spacer()
        }.padding()
    }
    
    var imageMeal: some View {
        WebImage(url: URL(string: self.presenter.meal.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width - 32, height: 250.0, alignment: .center)
            .cornerRadius(30)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !presenter.meal.ingredients.isEmpty {
                Text("Ingredient")
                    .font(.headline)
                
                ForEach(self.presenter.meal.ingredients, id: \.id) { ingredient in
                    ZStack {
                        Text(ingredient.title)
                            .font(.system(size: 16))
                    }
                }
            }
            
            Divider()
                .padding(.vertical)
            
            Text("Instructions")
                .font(.headline)
            
            Text(self.presenter.meal.instructions)
                .font(.system(size: 16))
        }.padding(.top)
    }
    
}

extension MealView {
    
    func openUrl(_ linkUrl: String) {
        if let link = URL(string: linkUrl) {
            UIApplication.shared.open(link)
        } else {
            showingAlert = true
        }
    }
    
}
