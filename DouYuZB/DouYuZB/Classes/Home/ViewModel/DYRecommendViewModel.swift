//
//  DYRecommendViewModel.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/20.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

class DYRecommendViewModel {
    private lazy var anchorGroups: [DYAnchorGroup] = [DYAnchorGroup]()
}

extension DYRecommendViewModel {
    func requestData() {
        let interval = NSDate.getCurrentTime() as NSString
//        print("http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=\(interval)")
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset":"0","time":interval]) { (result) in
//            print(result)
            // 1.将result转成字典 数组
            guard let resultDict = result as? [String: AnyObject],
                let dataArray = resultDict["data"] as? [[String: NSObject]]
                
            else {
                return
            }
            
            // 2.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray {
                let group = DYAnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
        }
        
    }
}
