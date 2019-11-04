//
//  CollectionReusableView.swift
//  allnight-ios
//
//  Created by 공지원 on 15/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class MainCollectionReusableHeaderView: UICollectionReusableView {
    //MARK: - Property
    var delegate: MainViewController?
    
    //MARK: - IBOutlet
    @IBOutlet var menuBarButton: UIButton!
    
    //MARK: - IBAction
    @IBAction func menuBarButtonDidTap(_ sender: UIButton) {
        delegate?.handleMenuBarButtonDidTap()
    }
}
