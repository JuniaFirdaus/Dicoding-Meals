//
//  MealPresenter.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/12/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import Foundation
import Combine
import Core
import Meal

class MealPresenter<Request, Response, Interactor: UseCaseMeal>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []
    private let _useCase: Interactor
    
    @Published var meal: Response!
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    public init(useCase: Interactor, response: Response) {
        _useCase = useCase
        meal = response
    }
    
    func getMeal(request: Request) {
        isLoading = true
        _useCase.getMeal(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { meal in
                self.meal = meal
            })
            .store(in: &cancellables)
    }
    
    func updateFavoriteMeal(request: Request) {
        _useCase.updateFavoriteMeal(by: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { meal in
                self.meal = meal
            })
            .store(in: &cancellables)
    }
    
}
