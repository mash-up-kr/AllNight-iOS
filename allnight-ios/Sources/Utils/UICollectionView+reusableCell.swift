//
//  UICollectionView+reusableCell.swift
//  allnight-ios
//
//  Created by ohkanghoon on 29/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

protocol CollectionViewCellType {
  static var identifier: String { get }
}

extension UICollectionViewCell: CollectionViewCellType{
  static var identifier: String {
    return String(describing: self.self)
  }
}

extension UICollectionView {
  func reusableCell<Cell>(
    _ reusableCell: Cell.Type,
    for indexPath: IndexPath
    ) -> Cell where Cell: UICollectionViewCell {
    guard let cell = self.dequeueReusableCell(withReuseIdentifier: reusableCell.identifier, for: indexPath) as? Cell else {
      fatalError("Could not find \(reusableCell.identifier)")
    }
    return cell
  }
}
