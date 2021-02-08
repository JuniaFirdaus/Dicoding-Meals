//
//  File.swift
//  
//
//  Created by PT Lintas Media Danawa on 03/12/20.
//

import Combine

public protocol UseCaseHome {
    associatedtype Request
    associatedtype Response
    
    func getCategories() -> AnyPublisher<Response, Error>
}

public struct InteractorHome<Request, Response, R: CategoryRepository>: UseCaseHome
where R.Request == Request, R.Response == Response {
    
    private let _repository: R
    
    public init(repository: R) {
        _repository = repository
    }
    
    public func getCategories() -> AnyPublisher<Response, Error> {
        _repository.getCategories()
    }
    
}
