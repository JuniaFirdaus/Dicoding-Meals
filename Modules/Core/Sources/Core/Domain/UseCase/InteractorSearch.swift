//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 03/02/21.
//

import Combine

public protocol UseCaseSearch {
    associatedtype Request
    associatedtype Response
    
    func searchMeal(by title: Request?) -> AnyPublisher<[Response], Error>
}

public struct InteractorSearch<Request, Response, R: MealRepository>: UseCaseSearch
where R.Request == Request, R.Response == Response {
    
    private let _repository: R
    
    public init(repository: R) {
        _repository = repository
    }
    
    public func searchMeal(by title: Request?) -> AnyPublisher<[Response], Error> {
        _repository.searchMeal(by: title)
    }
    
}
