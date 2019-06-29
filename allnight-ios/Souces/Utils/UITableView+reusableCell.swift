//
//  UITableView+reusableCell.swift
//  allnight-ios
//
//  Created by ohkanghoon on 29/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

protocol TableViewCellType {
  static var identifier: String { get }
}

extension UITableViewCell: TableViewCellType{
  static var identifier: String {
    return String(describing: self.self)
  }
}

extension UITableView {
  func reusableCell<Cell>(
    _ reusableCell: Cell.Type,
    for indexPath: IndexPath
  ) -> Cell where Cell: UITableViewCell {
    guard let cell = self.dequeueReusableCell(withIdentifier: reusableCell.identifier, for: indexPath) as? Cell else {
      fatalError("Could not find \(reusableCell.identifier)")
    }
    return cell
  }
}
