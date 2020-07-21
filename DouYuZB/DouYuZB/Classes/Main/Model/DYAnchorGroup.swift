//  主播模型
//  DYAnchorGroup.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/21.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

class DYAnchorGroup: NSObject {
    // 该组中对应的房间信息
    @objc var room_list: [[String: NSObject]]? {
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(DYAnchorModel(dict: dict))
            }
            
        }
    }
    // 组显示的标题
    @objc var tag_name: String = ""
    // 组显示的图标
    @objc var icon_name: String = "home_header_phone"
    // 定义主播模型数组
    private lazy var anchors: [DYAnchorModel] = [DYAnchorModel]()
    
    
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String: NSObject]] {
                for dict in dataArray {
                    anchors.append(DYAnchorModel(dict: dict))
                }
            }
        }
    }
    
}
