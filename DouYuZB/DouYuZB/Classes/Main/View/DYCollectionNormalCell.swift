//
//  DYCollectionNormalCell.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/20.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

class DYCollectionNormalCell: DYCollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
    
    override var anchor: DYAnchorModel? {
        didSet {
            // 1.将属性传递给d父类
            super.anchor = anchor
            
            roomNameLabel.text = anchor?.room_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
