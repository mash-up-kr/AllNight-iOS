//
//  RadioButton.swift
//  allnight-ios
//
//  Created by 다람쥐 on 21/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class RadioButton: UIButton {
  var alternateButton:Array<RadioButton>?
  
  override func awakeFromNib() {
    layer.cornerRadius = 5
    layer.borderWidth = 2.0
    layer.masksToBounds = true
    
    layer.borderColor = UIColor.init(named: "anBrown")?.cgColor
    layer.backgroundColor = UIColor.white.cgColor
    titleLabel?.textColor = UIColor.black
  }
  
  func unselectAlternateButtons(){
    if alternateButton != nil {
      isSelected = true
      
      for aButton:RadioButton in alternateButton! {
        aButton.isSelected = false
      }
    }else{
      toggleButton()
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    unselectAlternateButtons()
    super.touchesBegan(touches, with: event)
  }
  
  func toggleButton(){
    isSelected = !isSelected
  }
  
  override var isSelected: Bool {
    didSet {
      if isSelected {
        layer.backgroundColor = UIColor.init(named: "anBrown")?.cgColor
        titleLabel?.textColor = UIColor.white
      } else {
        layer.backgroundColor = UIColor.white.cgColor
        titleLabel?.textColor = UIColor.black
      }
    }
  }
}
