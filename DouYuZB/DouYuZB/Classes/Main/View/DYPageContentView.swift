//
//  DYPageContentView.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/9.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

private let contentCellId = "contentCellId"

class DYPageContentView: UIView {

    private var childVCs: [UIViewController]
    
    private var parentViewController: UIViewController
    
    private lazy var collectionView: UICollectionView = {
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = true
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellId)
        
        return collectionView
    }()
    
    /// 便立构造器
    /// - Parameters:
    ///   - frame: frame
    ///   - childVCs: 子控制器
    ///   - parentViewController: 父控制器
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController) {
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
            parentViewController.addChild(childVC)
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
