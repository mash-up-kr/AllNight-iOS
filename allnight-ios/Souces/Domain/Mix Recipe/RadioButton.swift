//
//  RadioButton.swift
//  allnight-ios
//
//  Created by 다람쥐 on 21/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class RadioButton: UIButton {
  var groupButton:Array<RadioButton>?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layer.cornerRadius = 20.0
    layer.borderWidth = 1.0
    layer.masksToBounds = true
    
    layer.borderColor = UIColor.init(named: "anBrown")?.cgColor
    layer.backgroundColor = UIColor.white.cgColor
    
    setTitleColor(UIColor.black, for: .normal)
    titleLabel?.font = UIFont(name: "NanumBarunGothicOTF", size: 12.0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder: ) not been implemented")
  }
  
  func unselectAlternateButtons(){
    if groupButton != nil {
      isSelected = true
      
      for aButton:RadioButton in groupButton! {
        if aButton !== self {
          aButton.isSelected = false
        }
      }
    } else {
      isSelected.toggle()
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    unselectAlternateButtons()
    super.touchesBegan(touches, with: event)
  }
  
  override var isSelected: Bool {
    didSet {
      if isSelected {
        layer.backgroundColor = UIColor.init(named: "anBrown")?.cgColor
        setTitleColor(UIColor.white, for: .normal)
      } else {
        layer.backgroundColor = UIColor.white.cgColor
        setTitleColor(UIColor.black, for: .normal)
      }
    }
  }
}
