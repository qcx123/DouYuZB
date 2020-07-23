//
//  DYRecommendCycleView.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/22.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

private let kCycleCellId = "kCycleCellId"

class DYRecommendCycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        autoresizingMask = .flexibleLeftMargin
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellId)
        
        
    }

    override func layoutSubviews() {
        // 设置布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.isPagingEnabled = true
        
    }
    
}

extension DYRecommendCycleView {
    class func recommendCycleView() -> DYRecommendCycleView {
        return Bundle.main.loadNibNamed("DYRecommendCycleView", owner: nil, options: nil)?.first as! DYRecommendCycleView
    }
}

extension DYRecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath)
        cell.contentView.backgroundColor = UIColor.yellow
        return cell
    }
}