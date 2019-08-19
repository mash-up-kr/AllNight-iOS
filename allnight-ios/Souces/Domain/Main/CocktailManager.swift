//
//  BucketManager.swift
//  allnight-ios
//
//  Created by 공지원 on 19/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import Foundation

class CocktailManager {
    static let shared = CocktailManager()
    
    //장바구니에 담긴 술/재료들
    var ingredientsInBucket: Set<String> = [] {
        didSet {
            print("ingredientsInBucket: \(ingredientsInBucket)")
        }
    }
    
    //스크랩한 칵테일 id들
    var scrappedCocktails: Set<String> = [] {
        didSet {
            print("scrappedCocktails: \(scrappedCocktails)")
        }
    }
}
