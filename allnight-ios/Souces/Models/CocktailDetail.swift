//
//  CocktailDetail.swift
//  allnight-ios
//
//  Created by ohkanghoon on 20/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import Foundation

struct CocktailDetail: Decodable {
    let glass: String //ok
    let alcoholic: String //ok
    let enDrinkName: String //ok
    let drinkName: String //ok
    let instructions: String //ok
    let drinkThumb: String //ok
    let category: String //ok
    let enInstructions: String //ok
    let enCategory: String //ok
    let enFullIngredients: [String]
    let enGlass: String //ok
    let enIngredientArray: [String] //ok
    let ingredientArray: [String] //ok
    let measureArray: [String] //ok
    let enMeasureArray: [String] //ok
    let imMatches: [Int] //ok
    let koFullIngredients: [String] //ok

/*
  let enIngredient01: String
  let enIngredient02: String
  let enIngredient03: String
  let enIngredient04: String
  let enIngredient05: String
  let enIngredient06: String

  let ingredients: String
  let ingredient01: String
  let ingredient02: String
  let ingredient03: String
  let ingredient04: String
  let ingredient05: String
  let ingredient06: String

  let measure01: String
  let measure02: String
  let measure03: String
  let measure04: String
  let measure05: String
  let measure06: String
*/

  enum CodingKeys: String, CodingKey {
    case glass
    case alcoholic
    case enDrinkName// = "EnDrinkName"
    case drinkName
    case instructions
    case drinkThumb
    case category
    case enInstructions
    case enCategory
    case enFullIngredients
    case enGlass
    case enIngredientArray
    case ingredientArray
    case measureArray
    case enMeasureArray
    case imMatches
    case koFullIngredients

    /*
    case enIngredient01 = "EnIngredient01"
    case enIngredient02 = "EnIngredient02"
    case enIngredient03 = "EnIngredient03"
    case enIngredient04 = "EnIngredient04"
    case enIngredient05 = "EnIngredient05"
    case enIngredient06 = "EnIngredient06"

    case ingredients
    case ingredient01
    case ingredient02
    case ingredient03
    case ingredient04
    case ingredient05
    case ingredient06

    case measure01
    case measure02
    case measure03
    case measure04
    case measure05
    case measure06
 */
  }
}
