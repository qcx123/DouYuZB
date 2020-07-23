//
//  DYCollectionPrettyCell.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/20.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit
import Kingfisher
class DYCollectionPrettyCell: DYCollectionBaseCell {
    
    
    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor: DYAnchorModel? {
        didSet {
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    

}
