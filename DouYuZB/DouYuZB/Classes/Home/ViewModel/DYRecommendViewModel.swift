//
//  DYRecommendViewModel.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/20.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

class DYRecommendViewModel {
    
    lazy var anchorGroups: [DYAnchorGroup] = [DYAnchorGroup]()
    
    private lazy var bigDataGroup: DYAnchorGroup = DYAnchorGroup()
    
    private lazy var prettyGroup: DYAnchorGroup = DYAnchorGroup()
}

extension DYRecommendViewModel {
    func requestData(finishCallback: @escaping ()->()) {
        // 0.准备数据
        let interval = NSDate.getCurrentTime() as NSString
        let parameters = ["limit":"4","offset":"0","time":interval]
        
        let disGroup = DispatchGroup()
        
        
        // 1.请求推荐数据
        disGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters) { (result) in
            // 1.将result转成字典 数组
            guard let resultDict = result as? [String: AnyObject],
                let dataArray = resultDict["data"] as? [[String: NSObject]]
                else {
                    return
            }
        
            // 2.遍历
            self.bigDataGroup.tag_name = "热门"
            for dict in dataArray {
                let anchor = DYAnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            // 3.离开组
            disGroup.leave()
        }
            
        // 2.请求颜值数据
        disGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1.将result转成字典 数组
            guard let resultDict = result as? [String: AnyObject],
                let dataArray = resultDict["data"] as? [[String: NSObject]]
            else {
                return
            }
            
            // 2.遍历
            self.prettyGroup.tag_name = "颜值"
            for dict in dataArray {
                let anchor = DYAnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            disGroup.leave()
        }
        print("http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=\(interval)")
        /// 3.请求2-12部分游戏数据
        disGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
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
                print(group.tag_name)
            }
            disGroup.leave()
        }
        
        disGroup.notify(queue: DispatchQueue.main) {
            print("首页所有的数据都请求下来")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
}
