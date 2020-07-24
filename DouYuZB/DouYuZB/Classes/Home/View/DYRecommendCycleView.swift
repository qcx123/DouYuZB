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

    var cycleModels: [DYCycleModel]? {
        didSet {
            guard let cycleModels = cycleModels else {
                return
            }
            collectionView.reloadData()
            
            pageControl.numberOfPages = cycleModels.count
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        autoresizingMask = .flexibleLeftMargin
        
        collectionView.register(UINib(nibName: "DYCollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellId)
        
        
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
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as! DYCollectionCycleCell
        let cycleModel = cycleModels![indexPath.item]
        
        cell.cycleModel = cycleModel
        return cell
    }
}

extension DYRecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
    }
}
