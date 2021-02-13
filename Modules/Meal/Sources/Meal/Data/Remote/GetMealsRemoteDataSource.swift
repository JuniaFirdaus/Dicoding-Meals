//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 20/01/21.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetMealsRemoteDataSource: MealDataSource {
    
    public typealias Request = Any
    
    public typealias Response = MealResponse
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func getMeal(
        by id: String
    ) -> AnyPublisher<MealResponse, Error> {
        return Future<MealResponse, Error> { completion in
            if let url = URL(string: self._endpoint + id) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MealsResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.meals[0]))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    public func searchMeal(
        by title: String
    ) -> AnyPublisher<[MealResponse], Error> {
        return Future<[MealResponse], Error> { completion in
            if let url = URL(string: self._endpoint + title) {
                print("GET", url)
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MealsResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.meals))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
