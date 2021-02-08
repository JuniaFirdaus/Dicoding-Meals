//
//  DetailInteractor.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import Foundation
import RxSwift

protocol DetailCategoryUseCase {
  
  func getCategory() -> CategoryModel
  
  func addFavoriteCategory(id: String, favorite: Bool) -> Observable<CategoryEntity>
  
}

class DetailCategoryInteractor: DetailCategoryUseCase {
  
  private let repository: MealRepositoryProtocol
  private let category: CategoryModel
  
  required init(
    repository: MealRepositoryProtocol,
    category: CategoryModel
  ) {
    self.repository = repository
    self.category = category
  }
  
  func getCategory() -> CategoryModel {
    return category
  }
  
  func addFavoriteCategory(id: String, favorite: Bool) -> Observable<CategoryEntity> {
    return repository.addFavorite(id: id, favorite: favorite)
  }
}
