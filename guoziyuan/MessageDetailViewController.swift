//
//  FSScrollContentViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class MessageDetailViewController: TableViewController{
    
    var vcCanScroll:Bool = false
    var fingerIsTouch:Bool = false
    
    
    var topImage:UIImage?
    
    let identifier:String = "MessageList"
//    var dateArray = [IndexPath]()
//    private lazy var imageArr : NSArray = {
//        let list:[UIImage] = [UIImage(named:"dropdown_anim__0001")!,UIImage(named:"dropdown_anim__0002")!
//            ,UIImage(named:"dropdown_anim__0003")!]
//        
//        return list as NSArray
//    }()
    
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
        
        super.setupSubViews(rect:CGRect(x: 0, y: 0, width: view.bounds.width, height: SCREENHEIGHT),style: UITableViewStyle.plain, isShowHead: true,isShowFooter: true)
        let nib:UINib = UINib.init(nibName: identifier, bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: identifier)
     showCustomLoadAnimate(self.view)
        
    }

    override func loadNewData() {
        
        if self.isTableViewLoadData {
            GCDQueue.execute(inMainQueue: {() -> Void in
                //        // Load data.
                
                
                self.dateArray.removeAll()
                
                
                
                //                for j in 0...9 {
                //
                //                    self.indexPaths.append(IndexPath(item: j, section: 0))
                //                    if j==9{
                //                        self.tableView?.mj_header.endRefreshing()
                //                    }
                //                }
                //
                
                //                print("1234234ssss=====\(self.indexPaths)")
                
                //            while i < 17 {
                //                indexPaths.append(IndexPath(item: i, section: 0))
                //                i += 1
                //            }
                
                
                //                            self.tableView!.insertRows(at: indexPaths , with: .fade)
                
                self.isTableViewLoadData = false
                //                self.tableView!.deleteRows(at: self.indexPaths, with: UITableViewRowAnimation.fade)
                
                self.tableView!.reloadData()
                
            }, afterDelaySecs: 1.45)
            
        }
        
        
        GCDQueue.execute(inMainQueue: {() -> Void in
            //        // Load data.
            
            
            
            
            
            
            for j in 0...9 {
                
                self.dateArray.append(IndexPath(item: j, section: 0))
                if j==9{
                    self.tableView?.mj_header.endRefreshing()
                }
            }
            
            self.tableView?.mj_footer.resetNoMoreData()
            //            print("1234234=====\(self.indexPaths)")
            
            //            while i < 17 {
            //                indexPaths.append(IndexPath(item: i, section: 0))
            //                i += 1
            //            }
            self.isTableViewLoadData = true
            
            
            //            self.tableView!.insertRows(at: indexPaths , with: .fade)
            
            self.tableView!.insertRows(at: self.dateArray, with: UITableViewRowAnimation.fade)
           super.hiddenCustomView()
        }, afterDelaySecs: 1.45)
  
    }
    override func loadMoreData() {
        GCDQueue.execute(inMainQueue: {() -> Void in
            //        // Load data.
            
            
            
            
            var indexPathsMore = [IndexPath]()
            
            for j in self.dateArray.count...self.dateArray.count+9 {
                
                self.dateArray.append(IndexPath(item: j, section: 0))
                indexPathsMore.append(IndexPath(item: j, section: 0))
                //                if j==self.indexPaths.count+9{
                //                    self.tableView?.mj_footer.endRefreshing()
                ////                    print("1234234222222=====\(self.indexPaths)")
                ////                    self.tableView?.mj_footer.endRefreshingWithNoMoreData()
                //                }
            }
            
//            self.tableView?.mj_footer.endRefreshing()
            self.tableView?.mj_footer.endRefreshingWithNoMoreData()
            
            
            
            //            while i < 17 {
            //                indexPaths.append(IndexPath(item: i, section: 0))
            //                i += 1
            //            }
            //            self.isTableViewLoadData = true
            
            //            self.tableView!.insertRows(at: indexPaths , with: .fade)
            
            self.tableView!.insertRows(at: indexPathsMore, with: UITableViewRowAnimation.fade)
            
            
            
        }, afterDelaySecs: 1.45)
        

    }
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
   override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return self.isTableViewLoadData ? 10 : 0
        return self.dateArray.count
        
    }
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cellTop:MessageList! = tableView.dequeueReusableCell(withIdentifier: identifier) as? MessageList
        cellTop.setIndex(dex: indexPath.row)
        //        cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
        
        if cellTop == nil {
            cellTop = MessageList(style: .default, reuseIdentifier: identifier)
        }
        cellTop.selectionStyle = UITableViewCellSelectionStyle.none
        return cellTop!
        
        
        
    }
    
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
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
