//
//  DYRecommendGameView.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/24.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

private let kGameViewCell = "kGameViewCell"

class DYRecommendGameView: UIView {

    var groups: [DYAnchorGroup]? {
        didSet{
            // 移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            let moreGroup = DYAnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib.init(nibName: "DYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCell)
    }

}

extension DYRecommendGameView {
    class func recommendGameView() -> DYRecommendGameView {
        return Bundle.main.loadNibNamed("DYRecommendGameView", owner: nil, options: nil)?.first as! DYRecommendGameView
    }
}

extension DYRecommendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCell, for: indexPath) as! DYCollectionGameCell
        let group = groups?[indexPath.item]
        cell.group = group
        return cell
    }
    
    
}
