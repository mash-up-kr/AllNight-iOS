//
//  CollectionReusableView.swift
//  allnight-ios
//
//  Created by 공지원 on 15/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    //MARK: - Property
    var link: MainViewController?
    
    //MARK: - IBOutlet
    @IBOutlet var menuBarButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    //MARK: - IBAction
    @IBAction func menuBarButtonDidTap(_ sender: UIButton) {
        //FIXME
        
        print("menuBarButtonDidTap")
        
        link?.handleMenuBarButtonDidTap()
    }
}
