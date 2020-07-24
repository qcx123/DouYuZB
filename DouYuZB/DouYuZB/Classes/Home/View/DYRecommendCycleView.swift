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

    var cycleTimer: Timer?
    
    
    var cycleModels: [DYCycleModel]? {
        didSet {
            guard let cycleModels = cycleModels else {
                return
            }
            collectionView.reloadData()
            
            pageControl.numberOfPages = cycleModels.count
            
            // 默认滚动到中间的位置
            let indextPath = IndexPath(item: cycleModels.count * 100, section: 0)
            collectionView.scrollToItem(at: indextPath, at: .left, animated: false)
            
            
            removeTimer()
            addCycleTimer()
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
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as! DYCollectionCycleCell
        let cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        cell.cycleModel = cycleModel
        return cell
    }
}

extension DYRecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    // 开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    // 结束拖拽
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// 对定时器的操作方法
extension DYRecommendCycleView {
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    
    private func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
