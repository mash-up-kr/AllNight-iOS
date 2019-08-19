//
//  MainCollectionViewCell.swift
//  allnight-ios
//
//  Created by 공지원 on 08/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Property
    var isScrap = false {
        didSet {
            if isScrap {
                scrapButton.setImage(UIImage(named: "icScrap24Normal-1"), for: .normal)
            } else {
                scrapButton.setImage(UIImage(named: "icScrap24Normal"), for: .normal)
            }
        }
    }
    
    var delegate: MainViewController?
    
    //MARK: - IBOutlet
    @IBOutlet var backgroundImgView: UIImageView!
    @IBOutlet var scrapButton: UIButton!
    @IBOutlet var alcholicImgView: UIImageView!
    @IBOutlet var cocktailNameLabel: UILabel!
    
    //MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Method
    override func prepareForReuse() {
        backgroundImgView.image = nil
        cocktailNameLabel.text = ""
        //alcholicImgView.image = nil
        scrapButton.setImage(UIImage(named: "icScrap24Normal"), for: .normal)
    }
    
    func configure(indexPath: IndexPath, cocktailInfo: Cocktail) {
        
        //칵테일 썸네일 이미지 설정
        let thumbUrl = cocktailInfo.drinkThumb
        backgroundImgView.kf.setImage(with: thumbUrl)
        
        //칵테일 이름 설정
        cocktailNameLabel.text = cocktailInfo.drinkName
        
        //알코올 유무 표시 이미지 설정
        if cocktailInfo.alcoholic == "Alcoholic" {
            alcholicImgView.image = UIImage(named: "icAlcholic")
        } else {
            alcholicImgView.image = nil
        }
        
        //스크랩 유무 설정
        
    }
    
    //MARK: - IBAction
    @IBAction func scrapButtonDidTap(_ sender: UIButton) {
        print("scrapButtonDidTap")
        
        delegate?.handleScrapButtonDidTap(cell: self)
        
        sender.isSelected = !sender.isSelected
        isScrap = sender.isSelected
    }
}
