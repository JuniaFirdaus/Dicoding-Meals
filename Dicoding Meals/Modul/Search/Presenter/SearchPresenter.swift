//
//  SearchPresenter.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/12/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI
import Combine
import Core
import Meal

class SearchPresenter<Request,
                      Response,
                      Interactor: UseCaseSearch
>: ObservableObject where Interactor.Request == Request,
                          Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = SearchRouter()
    private let _useCase: Interactor
    
    @Published var meals: [Response] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    var title = ""
    
    public init(useCase: Interactor) {
        _useCase = useCase
    }
    
    func searchMeal() {
        isLoading = true
        _useCase.searchMeal(by: title as? Request)
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
