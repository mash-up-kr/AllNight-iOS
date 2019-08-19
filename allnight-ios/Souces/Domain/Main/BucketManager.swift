//
//  BucketManager.swift
//  allnight-ios
//
//  Created by 공지원 on 19/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import Foundation

class BucketManager {
    static let shared = BucketManager()
    
    var ingredientsInBucket: Set<String> = [] {
        didSet {
            print(ingredientsInBucket)
        }
    }
}
