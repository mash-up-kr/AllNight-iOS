//
//  FilterView.swift
//  allnight-ios
//
//  Created by 다람쥐 on 21/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class FilterPopupView: UIView {

  let filterView: UIView = {
    let view = UIView()
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    
    label.text = "FILTER"
    label.textColor = UIColor.init(named: "anGray2")
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  var alcoholRadioButtonList: [RadioButton] = []
  
  var ingredientRadioButtonList: [RadioButton] = []
  
  override func awakeFromNib() {
    
  }
  
}
