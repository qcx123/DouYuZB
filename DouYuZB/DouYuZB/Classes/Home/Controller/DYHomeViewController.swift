//
//  DYHomeViewController.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/3/13.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class DYHomeViewController: UIViewController {

    // 懒加载属性
    private lazy var pageTitleView : DYPageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = DYPageTitleView(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.white
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView: DYPageContentView = {[weak self] in
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH)
        
        // 循环创建子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let pageContentView = DYPageContentView(frame: contentFrame, childVCs: childVcs, parentViewController: self)
        return pageContentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
}

/// MARK:- 设置UI
extension DYHomeViewController {
    
    private func setupUI() {
        // 0.不需要调整UIScrollView内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavigationBar()
        // 2.添加titleView
        view.addSubview(pageTitleView)
        
        // 3.添加contentView
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar() {
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imgName: "image_my_history", highImgName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imgName: "btn_search", highImgName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imgName: "Image_scan", highImgName: "Image_scan_click", size: size)
//        let historyItem = UIBarButtonItem.creatItem(imgName: "image_my_history", highImgName: "Image_my_history_click", size: size)
//        let searchItem = UIBarButtonItem.creatItem(imgName: "btn_search", highImgName: "btn_search_clicked", size: size)
//        let qrcodeItem = UIBarButtonItem.creatItem(imgName: "Image_scan", highImgName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
    
}

extension DYHomeViewController: DYPageTitleViewDelegate {
    func pageTitleView(titleView: DYPageTitleView, selectedIndex index: Int) {
        print(index)
        pageContentView.setCurrentIndex(currectIndex: index)
    }
}
