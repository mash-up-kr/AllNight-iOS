//
//  AllNightAPI.swift
//  allnight-ios
//
//  Created by ohkanghoon on 06/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import Moya

enum AllNightAPI {
  case search(ingredient: String)
  case searchCocktails(ingredients: [String], offset: Int?, isAlcohol: Bool, ingredientCount: Int)
  case searchStaticCocktails
  case searchCocktailDetail(id: String)

  case scrapRecipe(id: String)
  case scrappedRecipes
}

extension AllNightAPI: TargetType {
  var baseURL: URL {
    guard let url = URL(string: "http://15.164.22.30:8080")
      else { fatalError() }
    return url
  }

  var path: String {
    switch self {
    case .search:
      return "/api/v1/search"
    case .searchCocktails:
      return "/api/v1/search/cocktail"
    case .searchStaticCocktails:
      return "/api/v1/search/cocktail/static"
    case let .searchCocktailDetail(id):
      return "/api/v1/search/cocktail/\(id)"

    case let .scrapRecipe(id):
      return "/api/v1/user/scrap/\(id)"
    case .scrappedRecipes:
      return "/api/v1/user/scrap"
    }
  }

  var method: Method {
    switch self {
    case .search:
      return .get
    case .searchCocktails:
      return .get
    case .searchStaticCocktails:
      return .get
    case .searchCocktailDetail:
      return .get

    case .scrapRecipe:
      return .post
    case .scrappedRecipes:
      return .get
    }
  }

  var sampleData: Data {
    return .init()
  }

  var params: [String: Any] {
    var defaultParams: [String: Any] = [:]

    switch self {
    case let .search(ingredient):
      defaultParams["ingredient"] = ingredient

    case let .searchCocktails(ingredients, offset,isAlcohol, ingredientCount):
      defaultParams["ingredients"] = ingredients
      defaultParams["offset"] = offset
      defaultParams["isAlcohol"] = isAlcohol
      defaultParams["ingredientCount"] = ingredientCount

    default:
      break
    }
    return defaultParams
  }

  var task: Task {
    switch self {
    case .search, .searchCocktails:
      return .requestParameters(parameters: params,
                                encoding: URLEncoding(arrayEncoding: .noBrackets))
    default:
      return .requestPlain
    }
  }

  var headers: [String : String]? {
    return ["Accept": "application/json"]
  }
}
