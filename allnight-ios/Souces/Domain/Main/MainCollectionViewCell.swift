//
//  MainCollectionViewCell.swift
//  allnight-ios
//
//  Created by 공지원 on 08/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Property
    private var isScrap = false {
        didSet {
            if isScrap {
                scrapButton.setImage(UIImage(named: "icScrap24Normal-1"), for: .normal)
            } else {
                scrapButton.setImage(UIImage(named: "icScrap24Normal"), for: .normal)
            }
        }
    }
    
    //MARK: - IBOutlet
    @IBOutlet var backgroundImgView: UIImageView!
    @IBOutlet var scrapButton: UIButton!
    @IBOutlet var alcholicImgView: UIImageView!
    @IBOutlet var cocktailNameLabel: UILabel!
    
    //MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        print("MainCollectionViewCell Init")
    }
    
    //MARK: - Method
    override func prepareForReuse() {
        backgroundImgView.image = nil
        cocktailNameLabel.text = ""
        //alcholicImgView.image = nil
        scrapButton.setImage(UIImage(named: "icScrap24Normal"), for: .normal)
    }
    
    func configure(indexPath: IndexPath) {
        backgroundImgView.image = UIImage(named: "imgCocktailTest")
        cocktailNameLabel.text = "칵테일\(indexPath.row)"
    }
    
    //MARK: - IBAction
    @IBAction func scrapButtonDidTap(_ sender: UIButton) {
        print("scrapButtonDidTap")
        
        sender.isSelected = !sender.isSelected
        isScrap = sender.isSelected
    }
}
