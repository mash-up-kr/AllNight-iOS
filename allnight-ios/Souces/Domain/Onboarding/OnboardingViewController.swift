//
//  OnboardingViewController.swift
//  allnight-ios
//
//  Created by ohkanghoon on 29/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

final class OnboardingViewController: UIViewController {

    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    yesButton.setTitle("네, 받아볼래요.".localized, for: .normal)
    homeButton.setTitle("홈으로 그냥 갈래요.".localized, for: .normal)
  }
}
