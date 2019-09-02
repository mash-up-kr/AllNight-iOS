//
//  FilterView.swift
//  allnight-ios
//
//  Created by 다람쥐 on 21/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

protocol FilterPopupDelegate: class {
  func tapBackground()
  func tapApply(alcoholIndex: Int, ingredientIndex: Int)
}

class FilterPopupView: UIView {
  
  weak var filterPopupDelegate: FilterPopupDelegate?
  
  private var didUpdateConstraints = false
  
  private let filterView: UIView = {
    let view = UIView()
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.backgroundColor = UIColor.white
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: 25, y: 0))
    path.addLine(to: CGPoint(x: 0, y: 25))
    path.addLine(to: CGPoint(x: 0, y: 0))
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.strokeColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
    shapeLayer.lineWidth = 1.0
    shapeLayer.fillColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
    
    view.layer.addSublayer(shapeLayer)
    
    return view
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    
    label.text = "FILTER"
    label.textColor = UIColor.init(named: "anGray2")
    label.textAlignment = NSTextAlignment.center
    label.font = UIFont(name: "NanumBarunGothicOTF", size: 14.0)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  private var alcoholRadioButtonList: [RadioButton] = []
  private var alcoholRadioButtonTitleList: [String] = ["ALL", "Non-Alcohol", "Alchol"]
  
  private var ingredientRadioButtonList: [RadioButton] = []
  private var ingredientRadioButtonTitleList: [String] = ["3", "4", "5+"]
  
  private var lineView: UIView = {
    let view = UIView()
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.7294117647, blue: 0.568627451, alpha: 1)
    
    return view
  }()
  
  private var ingredientLabel: UIView = {
    let label = UILabel()
    
    label.text = "재료 수".localized
    label.font = UIFont(name: "NanumBarunGothicOTF", size: 16.0)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  private var buttonApply: UIButton = {
    let button = UIButton()
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.7294117647, blue: 0.568627451, alpha: 1)
    button.setTitle("적용하기".localized, for: .normal)
    button.titleLabel?.font = UIFont(name: "NanumBarunGothicOTF", size: 16.0)
    
    button.addTarget(self, action: #selector(tapApply), for: .touchDown)
    
    return button
  }()
  
  @objc func tapBackground(_ sender: UITapGestureRecognizer) {
    filterPopupDelegate?.tapBackground()
  }
  
  @objc func tapApply(_ sender: UIButton) {
    var alcoholIndex = 0
    var ingredientIndex = 0
    
    for (index, radio) in alcoholRadioButtonList.enumerated() {
      if radio.isSelected {
        alcoholIndex = index
        break
      }
    }
    
    for (index, radio) in ingredientRadioButtonList.enumerated() {
      if radio.isSelected {
        ingredientIndex = index
        break
      }
    }
    
    filterPopupDelegate?.tapApply(alcoholIndex: alcoholIndex, ingredientIndex: ingredientIndex)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    translatesAutoresizingMaskIntoConstraints = false
    
    backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground(_:)))
    addGestureRecognizer(gesture)
    
    filterView.addSubview(titleLabel)
    filterView.addSubview(buttonApply)
    
    for title in alcoholRadioButtonTitleList {
      let radio = RadioButton()
      
      radio.setTitle(title, for: .normal)
      radio.translatesAutoresizingMaskIntoConstraints = false
      
      alcoholRadioButtonList.append(radio)
      filterView.addSubview(radio)
    }
    
    filterView.addSubview(lineView)
    
    filterView.addSubview(ingredientLabel)
    
    for title in ingredientRadioButtonTitleList {
      let radio = RadioButton()
      
      radio.setTitle(title, for: .normal)
      radio.translatesAutoresizingMaskIntoConstraints = false
      
      ingredientRadioButtonList.append(radio)
      filterView.addSubview(radio)
    }
    
    for radio in alcoholRadioButtonList {
      radio.groupButton = alcoholRadioButtonList
    }
    
    for radio in ingredientRadioButtonList {
      radio.groupButton = ingredientRadioButtonList
    }
    
    alcoholRadioButtonList[0].isSelected = true
    ingredientRadioButtonList[0].isSelected = true
    
    addSubview(filterView)
    
    updateConstraintsIfNeeded()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder: ) not been implemented")
  }
  
  override func updateConstraints() {
    if !didUpdateConstraints {
      
      NSLayoutConstraint.activate([
        filterView.leftAnchor.constraint(equalTo: self.leftAnchor),
        filterView.rightAnchor.constraint(equalTo: self.rightAnchor),
        filterView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        filterView.heightAnchor.constraint(equalToConstant: 260.0)
      ])
      
      NSLayoutConstraint.activate([
        titleLabel.leftAnchor.constraint(equalTo: filterView.leftAnchor, constant: 16.0),
        titleLabel.rightAnchor.constraint(equalTo: filterView.rightAnchor, constant: -16.0),
        titleLabel.topAnchor.constraint(equalTo: filterView.topAnchor, constant: 16.0)
      ])
      
      NSLayoutConstraint.activate([
        buttonApply.leftAnchor.constraint(equalTo: filterView.leftAnchor),
        buttonApply.rightAnchor.constraint(equalTo: filterView.rightAnchor),
        buttonApply.bottomAnchor.constraint(equalTo: filterView.bottomAnchor),
        buttonApply.heightAnchor.constraint(equalToConstant: 54.0)
      ])
      
      NSLayoutConstraint.activate([
        alcoholRadioButtonList[1].topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.0),
        alcoholRadioButtonList[1].widthAnchor.constraint(equalToConstant: 92.0),
        alcoholRadioButtonList[1].heightAnchor.constraint(equalToConstant: 40.0),
        alcoholRadioButtonList[1].centerXAnchor.constraint(equalTo: filterView.centerXAnchor)
      ])
      
      NSLayoutConstraint.activate([
        alcoholRadioButtonList[0].trailingAnchor.constraint(equalTo: alcoholRadioButtonList[1].leadingAnchor, constant: -10.0),
        alcoholRadioButtonList[0].widthAnchor.constraint(equalToConstant: 92.0),
        alcoholRadioButtonList[0].heightAnchor.constraint(equalToConstant: 40.0),
        alcoholRadioButtonList[0].centerYAnchor.constraint(equalTo: alcoholRadioButtonList[1].centerYAnchor)
        ])
      
      NSLayoutConstraint.activate([
        alcoholRadioButtonList[2].leadingAnchor.constraint(equalTo: alcoholRadioButtonList[1].trailingAnchor, constant: 10.0),
        alcoholRadioButtonList[2].widthAnchor.constraint(equalToConstant: 92.0),
        alcoholRadioButtonList[2].heightAnchor.constraint(equalToConstant: 40.0),
        alcoholRadioButtonList[2].centerYAnchor.constraint(equalTo: alcoholRadioButtonList[1].centerYAnchor)
      ])
      
      NSLayoutConstraint.activate([
        lineView.topAnchor.constraint(equalTo: alcoholRadioButtonList[1].bottomAnchor, constant: 24.0),
        lineView.widthAnchor.constraint(equalToConstant: 295.0),
        lineView.heightAnchor.constraint(equalToConstant: 1.0),
        lineView.centerXAnchor.constraint(equalTo: filterView.centerXAnchor)
      ])
      
      NSLayoutConstraint.activate([
        ingredientLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 24.0),
        ingredientLabel.leadingAnchor.constraint(equalTo: lineView.leadingAnchor)
      ])
      
      NSLayoutConstraint.activate([
        ingredientRadioButtonList[0].leadingAnchor.constraint(equalTo: ingredientLabel.trailingAnchor, constant: 44.0),
        ingredientRadioButtonList[0].widthAnchor.constraint(equalToConstant: 40.0),
        ingredientRadioButtonList[0].heightAnchor.constraint(equalToConstant: 40.0),
        ingredientRadioButtonList[0].centerYAnchor.constraint(equalTo: ingredientLabel.centerYAnchor),
      ])
      
      NSLayoutConstraint.activate([
        ingredientRadioButtonList[1].leadingAnchor.constraint(equalTo: ingredientRadioButtonList[0].trailingAnchor, constant: 34.0),
        ingredientRadioButtonList[1].widthAnchor.constraint(equalToConstant: 40.0),
        ingredientRadioButtonList[1].heightAnchor.constraint(equalToConstant: 40.0),
        ingredientRadioButtonList[1].centerYAnchor.constraint(equalTo: ingredientLabel.centerYAnchor),
        ])
      
      NSLayoutConstraint.activate([
        ingredientRadioButtonList[2].leadingAnchor.constraint(equalTo: ingredientRadioButtonList[1].trailingAnchor, constant: 34.0),
        ingredientRadioButtonList[2].widthAnchor.constraint(equalToConstant: 60.0),
        ingredientRadioButtonList[2].heightAnchor.constraint(equalToConstant: 40.0),
        ingredientRadioButtonList[2].centerYAnchor.constraint(equalTo: ingredientLabel.centerYAnchor),
        ])
      
      didUpdateConstraints.toggle()
    }
    
    super.updateConstraints()
  }
  
}
