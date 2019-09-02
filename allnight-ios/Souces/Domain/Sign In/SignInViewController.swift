//
//  SignInViewController.swift
//  allnight-ios
//
//  Created by ohkanghoon on 29/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.setTitle("시작하기".localized, for: .normal)
    }
}
