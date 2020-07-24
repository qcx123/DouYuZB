//
//  DYCycleModel.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/24.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

class DYCycleModel: NSObject {

    @objc var title: String = ""
    
    @objc var pic_url: String = ""
    
    // 主播信息
    @objc var room: [String: NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            
            anchor = DYAnchorModel(dict: room)
        }
    }
    
    var anchor: DYAnchorModel?
    
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
