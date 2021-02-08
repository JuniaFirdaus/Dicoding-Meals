//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 03/02/21.
//

import Combine

public protocol UseCaseFavorite {
    associatedtype Request
    associatedtype Response
    
    func getFavoriteMeals() -> AnyPublisher<[Response], Error>
}

public struct InteractorFavorite<Request, Response, R: MealRepository>: UseCaseFavorite
where R.Request == Request, R.Response == Response {
    
    private let _repository: R
    
    public init(repository: R) {
        _repository = repository
    }
    
    public func getFavoriteMeals() -> AnyPublisher<[Response], Error> {
        _repository.getFavoriteMeals()
    }
    
}
