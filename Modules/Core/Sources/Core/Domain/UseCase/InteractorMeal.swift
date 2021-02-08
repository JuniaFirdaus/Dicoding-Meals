//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 28/01/21.
//

import Foundation
import Combine

public protocol UseCaseMeal {
    
    associatedtype Request
    associatedtype Response
    
    func getMeal(request: Request) -> AnyPublisher<Response, Error>
    
    func updateFavoriteMeal(by idMeal: Request?) -> AnyPublisher<Response, Error>
    
}

public struct InteractorMeal<Request, Response, R: MealRepository>: UseCaseMeal
where R.Request == Request, R.Response == Response {
    
    private let _repository: R
    
    public init(repository: R) {
        _repository = repository
    }
    
    public func getMeal(request: Request) -> AnyPublisher<Response, Error> {
        _repository.getMeal(by: request)
    }
    
    public func updateFavoriteMeal(by idMeal: Request?) -> AnyPublisher<Response, Error> {
        _repository.updateFavoriteMeal(by: idMeal)
    }
}
