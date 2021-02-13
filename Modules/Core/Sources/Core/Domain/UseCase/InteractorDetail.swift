//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 03/02/21.
//

import Combine

public protocol UseCaseDetail {
    associatedtype Request
    associatedtype Response
    
    func getMeals(request: Request) -> AnyPublisher<[Response], Error>
    
}

public struct InteractorDetail<Request, Response, R: MealCategoryRepository>: UseCaseDetail
where R.Request == Request, R.Response == Response {
    
    private let _repository: R
    
    public init(repository: R) {
        _repository = repository
    }
    
    public func getMeals(request: Request) -> AnyPublisher<[Response], Error> {
        _repository.getMeals(by: request)
    }
}
