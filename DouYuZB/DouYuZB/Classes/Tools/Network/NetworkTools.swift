//
//  NetworkTools.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/7/20.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type: MethodType, URLString: String, parameters: [String: NSString]? = nil, finishCallback: @escaping (_ result: AnyObject) -> ()) {
        
        // 1.获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.error ?? "")
                return
            }
            finishCallback(result as AnyObject)
        }
    }
}
