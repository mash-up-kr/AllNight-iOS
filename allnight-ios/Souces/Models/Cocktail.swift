//
//  Cocktail.swift
//  allnight-ios
//
//  Created by ohkanghoon on 06/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import Foundation

struct Cocktail: Equatable {
  let id: String
  let drinkName: String
  let enDrinkName: String
  let alcoholic: String
  let drinkThumb: URL
}

extension Cocktail: Decodable {
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case drinkName
    case enDrinkName
    case alcoholic
    case drinkThumb
  }
}
