//
//  FilterView.swift
//  allnight-ios
//
//  Created by 다람쥐 on 21/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class FilterPopupView: UIView {
  
  private var didUpdateConstraints = false
  
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
  var alcoholRadioButtonTitleList: [String] = ["ALL", "Non-Alcohol", "Alchol"]
  
  var ingredientRadioButtonList: [RadioButton] = []
  var ingredientRadioButtonTitleList: [String] = ["3", "4", "5+"]
  
  var alcoholRadioButton1: RadioButton = {
    let radio = RadioButton()
    radio.setTitle("ALL", for: .normal)
    radio.translatesAutoresizingMaskIntoConstraints = false
    return radio
  }();
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    translatesAutoresizingMaskIntoConstraints = false
    
    filterView.addSubview(titleLabel)
    filterView.addSubview(titleLabel)
    
    addSubview(filterView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder: ) not been implemented")
  }
  
  override func updateConstraints() {
    if !didUpdateConstraints {
      
//      NSLayoutConstraint.activate([
//        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 184.0),
//        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//        imageView.widthAnchor.constraint(equalToConstant: 113.0),
//        imageView.heightAnchor.constraint(equalToConstant: 95.0)
//        ])
//
//      NSLayoutConstraint.activate([
//        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 42.0),
//        label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
//        ])
      
      didUpdateConstraints.toggle()
    }
    
    super.updateConstraints()
  }
  
}
