//
//  DYCollectionHeaderView.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/20.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

class DYCollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var group: DYAnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImgView.image = UIImage(named: group?.icon_name ?? "home_header_phone")
        }
    }
    
    
}
