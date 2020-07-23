//
//  DYCollectionBaseCell.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/22.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

class DYCollectionBaseCell: UICollectionViewCell {
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor: DYAnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            var onlineStr: String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万人在线"
            }else {
                onlineStr = "\(anchor.online)人在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            nickNameLabel.text = anchor.nickname
            
            iconImgView.kf.setImage(with: URL(string: anchor.vertical_src ?? ""))
            
        }
    }
    
}
