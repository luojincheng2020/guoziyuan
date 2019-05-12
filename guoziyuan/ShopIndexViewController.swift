//
//  MainVC.swift
//  仿网易scrollView
//
//  Created by 张海峰 on 2017/8/10.
//  Copyright © 2017年 张海峰. All rights reserved.
//

import UIKit

class ShopIndexViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //3.添加所有子控制器
        setupAllChildViewController()
    }
    func setupAllChildViewController(){
        //头条
//        let topLineVC :TopLineVC  = TopLineVC()
//        topLineVC.title = "头条"
//        topLineVC.view.backgroundColor = UIColor.orange
//        addChildViewController(topLineVC)
//        //热点
//        let hotVC :HotVC  = HotVC()
//        hotVC.title = "热点"
//        hotVC.view.backgroundColor = UIColor.red
//        addChildViewController(hotVC)
//        //视频
//        let videoVC :VideoVC  = VideoVC()
//        videoVC.title = "视频"
//        videoVC.view.backgroundColor = UIColor.cyan
//        addChildViewController(videoVC)
//        //社会
//        let scoletyVC :ScoletyVC  = ScoletyVC()
//        scoletyVC.title = "社会"
//        scoletyVC.view.backgroundColor = UIColor.gray
//        addChildViewController(scoletyVC)
//        //订阅
//        let readerVC :ReaderVC  = ReaderVC()
//        readerVC.title = "订阅"
//        readerVC.view.backgroundColor = UIColor.green
//        addChildViewController(readerVC)
//        //科技
//        let scienceVC :ScienceVC  = ScienceVC()
//        scienceVC.title = "科技"
//        scienceVC.view.backgroundColor = UIColor.yellow
//        addChildViewController(scienceVC)
        
        
        let arr:NSArray = ["当季鲜果","进口水果","鲜切果","美味坚果","鲜果沙拉","果汁"];
        
        
        for title:String in (arr as? [String])! {
//            let fs:FSScrollContentViewController = FSScrollContentViewController()
//            fs.title = title
////            contentVCs.add(fs)
//            addChildViewController(fs)
            
            
                    let topLineVC :ShopTableViewController  = ShopTableViewController()
                    topLineVC.title = title
                    topLineVC.view.backgroundColor = lightColor
                    addChildViewController(topLineVC)
            
            
            
        }
        
        
        
        
    }
   
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
