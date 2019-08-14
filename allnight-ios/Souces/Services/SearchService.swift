//
//  SearchService.swift
//  allnight-ios
//
//  Created by ohkanghoon on 06/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import Moya

protocol SearchServiceType {
  func search(ingredient: String, completion: @escaping (Result<[String], MoyaError>) -> ())
  func searchCocktails(ingredients: [String], offset: Int?, isAlcohol: Bool, ingredientCount: Int, completion: @escaping (Result<[Cocktail], MoyaError>) -> ())
  func searchStaticCocktails(completion: @escaping (Result<[Cocktail], MoyaError>) -> ())
  func searchCocktailDetail(id: String, completion: @escaping (Result<CocktailDetail, MoyaError>) -> ())
}

final class SearchService: SearchServiceType {
  private let networking: AllNightNetworking

  init(networking: AllNightNetworking) {
    self.networking = networking
  }

  func search(
    ingredient: String,
    completion: @escaping (Result<[String], MoyaError>) -> ()
  ) {
    self.networking.request(
      .search(ingredient: ingredient),
      completionHandler: { response in
        completion(response.decodeJSON([String].self))
      },
      errorHandler: { error in
        completion(.failure(error))
      })
  }

  func searchCocktails(
    ingredients: [String],
    offset: Int? = 0,
    isAlcohol: Bool = true,
    ingredientCount: Int = 0,
    completion: @escaping (Result<[Cocktail], MoyaError>) -> ()
  ) {
    self.networking.request(
      .searchCocktails(ingredients: ingredients, offset: offset, isAlcohol: isAlcohol, ingredientCount: ingredientCount),
      completionHandler: { response in
        completion(response.decodeJSON([Cocktail].self))
      }, errorHandler: { error in
        completion(.failure(error))
      })
  }

  func searchStaticCocktails(completion: @escaping (Result<[Cocktail], MoyaError>) -> ()) {
    self.networking.request(
      .searchStaticCocktails,
      completionHandler: { response in
        completion(response.decodeJSON([Cocktail].self))
      }, errorHandler: { error in
        completion(.failure(error))
      })
  }

  func searchCocktailDetail(id: String, completion: @escaping (Result<CocktailDetail, MoyaError>) -> ()) {
    self.networking.request(
      .searchCocktaikDetail(id: id),
      completionHandler: { response in
        completion(response.decodeJSON(CocktailDetail.self))
      }, errorHandler: { error in
        completion(.failure(error))
      })
  }
}
