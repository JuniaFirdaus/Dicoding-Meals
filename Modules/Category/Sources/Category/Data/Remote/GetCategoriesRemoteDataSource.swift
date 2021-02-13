//
//  File.swift
//  
//
//  Created by PT Lintas Media Danawa on 03/12/20.
//

import Core
import Meal
import Combine
import Alamofire
import Foundation

public struct GetCategoriesRemoteDataSource: DataSource {
    
    public typealias Request = Any
    
    public typealias Response = [CategoryResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func getCategories() -> AnyPublisher<[CategoryResponse], Error> {
        return Future<[CategoryResponse], Error> { completion in
            if let url = URL(string: self._endpoint) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: CategoriesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.categories))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
