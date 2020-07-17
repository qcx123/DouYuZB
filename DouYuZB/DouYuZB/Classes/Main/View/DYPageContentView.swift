//
//  DYPageContentView.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/9.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

protocol DYPageContentViewDelegate: class {
    func pageContentView(contentView: DYPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let contentCellId = "contentCellId"

class DYPageContentView: UIView {

    private var childVCs: [UIViewController]
    
    private weak var parentViewController: UIViewController?
    // collectionview偏移量
    private var startOffsetX: CGFloat = 0
    
    weak var delegate: DYPageContentViewDelegate?
    
    private lazy var collectionView: UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellId)
        
        return collectionView
    }()
    
    /// 便立构造器
    /// - Parameters:
    ///   - frame: frame
    ///   - childVCs: 子控制器
    ///   - parentViewController: 父控制器
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController?) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension DYPageContentView {
    private func setupUI() {
        // 1.将所有子控制器添加到父控制器当中
        for childVC in childVCs {
            parentViewController?.addChild(childVC)
        }
        
        // 2.添加UICollectionView用于在cell中存放h控制器view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


extension DYPageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
    
    
}

extension DYPageContentView: UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.定义获取需要的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        // 判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX {// 左滑
            // 1.计算progres   floor(1.2) = 1,floor就是用来取出小数前边的整数的
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            // 4.如果完全滑过去
//            print("currentOffsetX = \(currentOffsetX), startOffsetX = \(startOffsetX)")
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else {// 右滑
            // 1.计算progres
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        
        // 3.将值传递给titleView
//        print("progress \(progress), sourceIndex \(sourceIndex), targetIndex \(targetIndex)")
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

/// 对外暴露方法
extension DYPageContentView {
    func setCurrentIndex(currectIndex: Int) {
        let offset = CGFloat(currectIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
    }
}
