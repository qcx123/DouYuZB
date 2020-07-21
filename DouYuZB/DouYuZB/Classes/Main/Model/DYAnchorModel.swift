//
//  DYAnchorModel.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/21.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

class DYAnchorModel: NSObject {
    /// 房间Id
    @objc var room_id: Int = 0
    /// 房间图片
    @objc var vertical_src: String?
    /// 判断是手机直播还是电脑直播 0:电脑 1:手机
    @objc var isVertical: Int = 0
    /// 房间名称
    @objc var room_name: String = ""
    /// 主播昵称
    @objc var nickname: String = ""
    /// 在线人数
    @objc var online: Int = 0
    /// 所在城市
    @objc var anchor_city: String = ""
    
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
