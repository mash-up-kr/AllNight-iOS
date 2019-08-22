//
//  AllNightProvider.swift
//  allnight-ios
//
//  Created by 공지원 on 16/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import Foundation
import Moya

class AllNightProvider {
    static let provider = AllNightNetworking()
    
    class func search(ingredient: String, completion: @escaping ((Response) -> Void), error: @escaping ((MoyaError) -> Void)) {
        provider.request(.search(ingredient: ingredient), completionHandler: completion, errorHandler: error)
    }

    class func searchCocktails(ingredients: [String], offset: Int?, isAlcohol: Bool, ingredientCount: Int, completion: @escaping ((Response) -> Void), error: @escaping ((MoyaError) -> Void)) {
        provider.request(.searchCocktails(ingredients: ingredients, offset: offset, isAlcohol: isAlcohol, ingredientCount: ingredientCount), completionHandler: completion, errorHandler: error)
    }
    
    class func searchStaticCocktails(completion: @escaping ((Response) -> Void), error: @escaping ((MoyaError) -> Void)) {
        provider.request(.searchStaticCocktails, completionHandler: completion, errorHandler: error)
    }
    
    class func searchCocktailDetail(id: String, completion: @escaping ((Response) -> Void), error: @escaping ((MoyaError) -> Void)) {
        provider.request(.searchCocktailDetail(id: id), completionHandler: completion, errorHandler: error)
    }
}
