//
//  DYMainViewController.swift
//  DouYuZB
//
//  Created by 乔春晓 on 2020/3/13.
//  Copyright © 2020 春晓. All rights reserved.
//

import UIKit

class DYMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")
        
        
        // Do any additional setup after loading the view.
    }
    
    private func addChildVC(_ storyName: String) {
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChild(childVC)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
