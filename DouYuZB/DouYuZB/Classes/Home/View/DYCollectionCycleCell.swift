//
//  DYCollectionCycleCell.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/24.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit
import Kingfisher

class DYCollectionCycleCell: UICollectionViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel: DYCycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            imgView.kf.setImage(with: URL(string: cycleModel?.pic_url ?? ""), placeholder: UIImage(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
