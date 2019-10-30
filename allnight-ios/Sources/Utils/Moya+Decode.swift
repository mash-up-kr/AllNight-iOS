//
//  Moya+Decode.swift
//  allnight-ios
//
//  Created by ohkanghoon on 06/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import Moya

extension Response {
  func decodeJSON<D: Decodable>(_ type: D.Type) -> Result<D, MoyaError> {
    do {
      return .success(try self.map(D.self))
    } catch let err {
      return .failure(MoyaError.objectMapping(err, self))
    }
  }
}
