//
//  DetailFavoriteInteractor.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 03/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import Foundation

protocol DetailFavoriteUseCase {
  
  func getFavorite() -> CategoryEntity
  
}

class DetailFavoriteInteractor: DetailFavoriteUseCase {
  
  private let repository: MealRepositoryProtocol
  private let favorite: CategoryEntity
  
  required init(
    repository: MealRepositoryProtocol,
    favorite: CategoryEntity
  ) {
    self.repository = repository
    self.favorite = favorite
  }
  
  func getFavorite() -> CategoryEntity {
    return favorite
  }
  
}
