//
//  File.swift
//  
//
//  Created by PT LINTAS MEDIA DANAWA on 05/02/21.
//

import Core
import Meal
import Combine
import Alamofire
import Foundation

public struct GetMealCategoriesRemoteDataSource : CategoryMealSource {
    
    public typealias Request = Any
    
    public typealias Response = MealResponse
    
    public typealias ResponseCategory = [CategoryResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func getMeals(
        by category: String
    ) -> AnyPublisher<[MealResponse], Error> {
        return Future<[MealResponse], Error> { completion in
            if let url = URL(string: self._endpoint + category) {
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
