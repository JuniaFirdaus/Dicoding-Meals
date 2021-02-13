//
//  FavoriteRouter.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 03/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI
import Meal
import Core

class FavoriteRouter {
    
    func makeMealView(for meal: MealDomainModel) -> some View {
        let mealUseCase: InteractorMeal<
            Any,
            MealDomainModel,
            GetMealsRepository<
                GetMealsLocaleDataSource,
                GetMealsRemoteDataSource,
                MealTransformer>
        > = Injection.init().provideMeal()
        let presenter = MealPresenter(useCase: mealUseCase, response: meal)
        return MealView(presenter: presenter)
    }
    
}
