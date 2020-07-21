//
//  NSDate+Extention.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/21.
//  Copyright © 2020 春晓. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        
        return "\(interval)"
    }
}
