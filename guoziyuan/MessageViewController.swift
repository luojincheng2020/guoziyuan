//
//  FSScrollContentViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit
import WebKit

class MessageViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
  

    var tableView:UITableView?
    var vcCanScroll:Bool = false
    var fingerIsTouch:Bool = false
    
    var isTableViewLoadData: Bool = false
    var topImage:UIImage?
    
    let identifier:String = "MessageList"
    
    //    //索引数组
    //    private lazy var cityDataSource : NSArray = {
    //        let list:[String] = [
    //            "长宁区", "嘉定区", "黄浦区", "静安区", "青浦区", "闸北区", "杨浦区",
    //            "卢湾区"]
    //
    //        return list as NSArray
    //    }()
    //
    //    private lazy var cityDataSourcetwo : NSArray = {
    //        let list:[String] = [
    //            "长宁", "嘉定", "黄浦", "静安", "青浦", "闸北", "杨浦",
    //            "卢湾"]
    //
    //        return list as NSArray
    //    }()
    //
    
    
    //    //索引数组
    //    private lazy var characterDataSource : NSArray = {
    //        let list:[String] = [
    //            "A", "B", "C", "D", "E", "F", "G",
    //            "H", "I", "J", "K", "L", "M", "N",
    //            "O", "P", "Q", "R", "S", "T",
    //            "U", "V", "W", "X", "Y", "Z"]
    //
    //        return list as NSArray
    //    }()
    //
    
    
    //    func setLeftButtonItemBackWith(_ image: UIImage, tintColor: UIColor) {
    //
    //
    //
    //        let btn = UIButton(type: UIButtonType.custom)
    //        btn.setImage(image, for: UIControlState.normal)
    //        btn.addTarget(self, action: #selector(MyOrderListViewController.back), for: UIControlEvents.touchUpInside)
    //
    //
    //
    ////        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(back))
    ////        item.tintColor = tintColor
    ////        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain , target: self, action: #selector(back))
    ////        print("22222222222")
    //    }
    ////    func back(){
    ////        print("23454345")
    ////        self.navigationController?.popViewController(animated: true)
    ////    }
    
    
    
    
    
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        navigationController?.isNavigationBarHidden = false
        //        self.navigationController?.navigationBar.setBackgroundImage(topImage, for: .default)
        ////        self.navigationController?.navigationBar.isHidden = false
        //        self.navigationController?.navigationBar.alpha = 1.0
        
        
        
        //        let delay = DispatchTime.now() + 0.3
        //        DispatchQueue.main.asyncAfter(deadline: delay) {
        self.setupSubViews()
        
        
        
        
        
  
    }
    func setupSubViews() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: SCREENHEIGHT), style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        //        tableView?.bounces = false
        //        view.addSubview(tableView!)
        self.view.addSubview(tableView!)
        let nib:UINib = UINib.init(nibName: identifier, bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: identifier)
        tableView?.backgroundColor = lightColor
        
        
        tableView?.sectionIndexColor = greenColor;
        
        tableView?.sectionIndexBackgroundColor = UIColor.clear;
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView?.backgroundColor = lightColor
        //        sectionIndexMinimumDisplayRowCount: 个数大于该值才会显示索引,默认为0。
        //        触摸时索引条背景的颜色:
        //        tableView?.sectionIndexTrackingBackgroundColor =  darkColor
        //        tableView?.addIndexTip()
        
        GCDQueue.execute(inMainQueue: {() -> Void in
            //        // Load data.
            var indexPaths = [IndexPath]()
            
            
            
            
            
            for j in 0...9 {
                
                indexPaths.append(IndexPath(item: j, section: 0))
            }
            
            
            
            
            //            while i < 17 {
            //                indexPaths.append(IndexPath(item: i, section: 0))
            //                i += 1
            //            }
            self.isTableViewLoadData = true
            
            //            self.tableView!.insertRows(at: indexPaths , with: .fade)
            
            self.tableView!.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
            
        }, afterDelaySecs: 0.15)
        
        
        
        //        loopViews.tapClickBlock = {(loopView)-> Void in
        //            let alert = UIAlertView(title: "文字", message: "老：\(loopViews.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "cancle")
        //            alert.show()
        //        }
        
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.isTableViewLoadData ? 10 : 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cellTop:MessageList! = tableView.dequeueReusableCell(withIdentifier: identifier) as? MessageList
        cellTop.setIndex(dex: indexPath.row)
        //        cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
        
        if cellTop == nil {
            cellTop = MessageList(style: .default, reuseIdentifier: identifier)
        }
        cellTop.selectionStyle = UITableViewCellSelectionStyle.none
        return cellTop!
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let detail = MessageWebViewController()
            self.navigationController?.pushViewController(detail, animated: true)
        }else if indexPath.row == 1{
        
        let detail = MessageWebSecondViewController()
        self.navigationController?.pushViewController(detail, animated: true)
        }else if indexPath.row == 2{
            
            let detail = MessageWebThreeViewController()
            self.navigationController?.pushViewController(detail, animated: true)
        }else {
            
            let detail = MessageDetailViewController()
            detail.title = "今日资讯"
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
//        self.navigationController?.navigationBar.setBackgroundImage(topImage, for: .default)
//        //        self.navigationController?.navigationBar.isHidden = false
//        navigationController?.navigationBar.subviews.first?.alpha = 1.0
//        
//    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
