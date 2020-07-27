//
//  DYCollectionGameCell.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/27.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit
import Kingfisher

class DYCollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImgView: UIImageView!
    
    var group: DYAnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name ?? ""
            iconImgView.kf.setImage(with: URL(string: group?.icon_url ?? ""), placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImgView.layer.masksToBounds = true
        iconImgView.layer.cornerRadius = 27
    }

}
