//
//  FavoritePresenter.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 03/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI
import Combine
import Core
import Meal

class FavoritePresenter<Request, Response, Interactor: UseCaseFavorite>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = FavoriteRouter()
    private let _useCase: Interactor
    
    @Published var meals: [Response] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    public init(useCase: Interactor) {
        _useCase = useCase
    }
    
    func getFavoriteMeals() {
        isLoading = true
        _useCase.getFavoriteMeals()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { meals in
                self.meals = meals
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for meal: MealDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeMealView(for: meal)) { content() }
    }
    
}
