//
//  String.swift
//  allnight-ios
//
//  Created by Suji Kim on 9/1/19.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}
