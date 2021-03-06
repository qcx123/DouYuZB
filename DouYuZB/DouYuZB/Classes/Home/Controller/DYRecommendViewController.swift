//
//  DYRecommendViewController.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/17.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2.0
private let kNormalItemH = kItemW / 4 * 3
private let kPrettyItemH = kItemW / 3 * 4
private let kHeaderViewH: CGFloat = 50

private let kCycleViewH: CGFloat = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90

private let kNormalCellId = "kNormalCellId"
private let kPrettyCellId = "kPrettyCellId"
private let kHeaderViewId = "kHeaderViewId"

class DYRecommendViewController: UIViewController {

    private lazy var recommendVM : DYRecommendViewModel = DYRecommendViewModel()
    
    private lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth] // 随着父控件拉伸
        collectionView.register(UINib.init(nibName: "DYCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UINib.init(nibName: "DYCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellId)
        collectionView.register(UINib.init(nibName: "DYCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewId)
        
        return collectionView
    }()
    
    private lazy var recommendCycleView: DYRecommendCycleView = {
        let cycleView = DYRecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var gameView: DYRecommendGameView = {
        let gameView = DYRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()
    }
    
}

extension DYRecommendViewController {
    private func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.addSubview(recommendCycleView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        collectionView.addSubview(gameView)
    }
}

extension DYRecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        let cell: DYCollectionBaseCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId, for: indexPath) as! DYCollectionPrettyCell
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! DYCollectionNormalCell
        }
        cell.anchor = anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 取出header
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewId, for: indexPath) as! DYCollectionHeaderView
        
        let group = recommendVM.anchorGroups[indexPath.section]
        headerView.group = group
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
}

extension DYRecommendViewController {
    private func loadData() {
        // 请求推荐数据
        recommendVM.requestData {
            self.collectionView.reloadData()
            self.gameView.groups = self.recommendVM.anchorGroups
        }
        // 请求轮播数据
        recommendVM.requestCycleData {
            self.recommendCycleView.cycleModels = self.recommendVM.cycleArray
        }
    }
}
