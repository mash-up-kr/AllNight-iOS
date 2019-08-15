//
//  SideMenuTableViewCell.swift
//  allnight-ios
//
//  Created by 공지원 on 12/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    //MARK: - Property

    //MARK: - IBOutlet
    @IBOutlet var iconImgView: UIImageView!
    @IBOutlet var menuNameLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        //재사용되기 전에 값 초기화
        iconImgView.image = nil
        menuNameLabel.text = nil
    }

    func configure(indexPath: IndexPath) {
        if indexPath.row == 0 {
            iconImgView.image = UIImage(named: "icScrap24Normal-1")
            menuNameLabel.text = "스크랩 레시피"
        }
        else if indexPath.row == 1 {
            iconImgView.image = UIImage(named: "icHistory24Normal")
            menuNameLabel.text = "최근에 본 레시피"
        }
    }
}
