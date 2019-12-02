//
//  CollectionReusableView.swift
//  allnight-ios
//
//  Created by 공지원 on 15/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class MainCollectionReusableHeaderView: UICollectionReusableView {
    //MARK: - IBOutlet
    @IBOutlet var menuBarButton: UIButton!
    
    //MARK: - Property
    var delegate: MainViewController?
    
    //MARK: - IBAction
    @IBAction func menuBarButtonDidTap(_ sender: UIButton) {
        delegate?.handleMenuBarButtonDidTap()
    }
}
