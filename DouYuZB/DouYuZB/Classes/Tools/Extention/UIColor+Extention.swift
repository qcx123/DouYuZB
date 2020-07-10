//
//  UIColor+Extention.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/9.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
