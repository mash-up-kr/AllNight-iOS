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
    private let scrappedIconName = "icScrap24Normal-1"
    private let nonScrappedIconName = "icScrap24Normal"
    private let alcholicIconName = "icAlcholic"
    
    var isScrap = false {
        didSet {
            if isScrap {
                scrapButton.setImage(UIImage(named: scrappedIconName), for: .normal)
            } else {
                scrapButton.setImage(UIImage(named: nonScrappedIconName), for: .normal)
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
        scrapButton.setImage(UIImage(named: nonScrappedIconName), for: .normal)
    }
    
    func configure(indexPath: IndexPath, cocktailInfo: Cocktail) {
        
        //칵테일 썸네일 이미지 설정
        let thumbUrl = cocktailInfo.drinkThumb
        backgroundImgView.kf.setImage(with: thumbUrl)
        
        //칵테일 이름 설정
        cocktailNameLabel.text = cocktailInfo.enDrinkName
        
        //알코올 유무 표시 이미지 설정
        if cocktailInfo.alcoholic == "Alcoholic" {
            alcholicImgView.image = UIImage(named: alcholicIconName)
        } else {
            alcholicImgView.image = nil
        }
        
        //스크랩 유무에 따른 아이콘 설정 
        if CocktailManager.shared.scrappedCocktails.contains(cocktailInfo.id) {
            isScrap = true
        }
    }
    
    //MARK: - IBAction
    @IBAction func scrapButtonDidTap(_ sender: UIButton) {
        
        isScrap = !isScrap
        
        delegate?.handleScrapButtonDidTap(cell: self)
    }
}
