//
//  HomePresenter.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI
import Combine
import Core
import Category

class HomePresenter<Request,
                    Response,
                    Interactor: UseCaseHome
>: ObservableObject where Interactor.Request == Request,
                          Interactor.Response == [Response] {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let _useCase: Interactor
    
    @Published var categories: [Response] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    public init(useCase: Interactor) {
        _useCase = useCase
    }
    
    func getCategories() {
        isLoading = true
        _useCase.getCategories()
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
            }, receiveValue: { categories in
                self.categories = categories
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for category: CategoryDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: category)) { content() }
    }
    
}
