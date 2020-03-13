//
//  UIBarButton+Extention.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/3/13.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func creatItem(imgName : String, highImgName : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imgName), for: .normal)
        btn.setImage(UIImage(named: highImgName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        let item = UIBarButtonItem(customView: btn)
        return item
    }
    
    
    // 便利构造函数 1.convenience 开头；2.在构造函数中必须调用一个设计的构造函数（self）
    convenience init(imgName : String, highImgName : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imgName), for: .normal)
        if highImgName != "" {
            btn.setImage(UIImage(named: highImgName), for: .highlighted)
        }
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}
