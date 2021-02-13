//
//  DetailPresenter.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/12/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI
import Combine
import Meal
import Core
import Category

class DetailPresenter<Request,
                      Response,
                      Interactor: UseCaseDetail
>: ObservableObject where Interactor.Request == Request,
                          Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = DetailRouter()
    private let _useCase: Interactor
    
    var title = ""
    @Published var meals: [Response] = []
    @Published var category: CategoryDomainModel
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    public init(useCase: Interactor, response: CategoryDomainModel) {
        _useCase = useCase
        category = response
    }
    
    func getMeals(title: Request) {
        isLoading = true
        _useCase.getMeals(request: title)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
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
