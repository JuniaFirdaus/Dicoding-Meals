//
//  HomeRouter.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI
import Category
import Meal
import Core

class HomeRouter {
    
    func makeDetailView(for category: CategoryDomainModel) -> some View {
        let detailUseCase: InteractorDetail<
            Any,
            MealDomainModel,
            GetMealCategoriesRepository<
                GetMealCategoriesLocaleDataSource,
                GetMealCategoriesRemoteDataSource,
                MealTransformer
            >
        > = Injection.init().provideDetail()
        
        let presenter = DetailPresenter(useCase: detailUseCase, response: category)
        
        return DetailView(presenter: presenter)
    }
    
}

