//
//  DYPageTitleView.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/8.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

protocol DYPageTitleViewDelegate: class {
    func pageTitleView(titleView: DYPageTitleView, selectedIndex index: Int)
}

private let kScrollLineH : CGFloat = 2

class DYPageTitleView: UIView {

    private var currectIndex: Int = 0
    private var titles: [String]
    
    weak var delegate: DYPageTitleViewDelegate?
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    private lazy var titleLabels = [UILabel]()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    
    // MARK: 自定义一个构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
        // 1.获取当前的label
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        
        // 2.获取之前的label
        let oldLabel = titleLabels[currectIndex]
        
        // 3.修改颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.gray
        
        // 4.保存最新label的下标
        currectIndex = currentLabel.tag
        
        // 5.滚动条位置改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6.代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currectIndex)
    }
    
}

/// 设置UI界面
extension DYPageTitleView {
    private func setupUI() {
        // 1.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title对应的label
        setupTitleLabels()
        
        // 3.设置底线和滚动滑块
        setupBottonMenuAndScrollLine()
    }
    
    private func setupTitleLabels () {
        
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            // 创建UILabel
            let label = UILabel()
            label.text = title
            label.tag = index
            label.textColor = UIColor.gray
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            addSubview(label)
            titleLabels.append(label)
            
            // 给label添加收拾
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottonMenuAndScrollLine() {
        // 创建底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
}


