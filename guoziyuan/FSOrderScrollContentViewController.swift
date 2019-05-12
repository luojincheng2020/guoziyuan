//
//  FSScrollContentViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class FSOrderScrollContentViewController: TableViewController{
//    var tableView:UITableView?
    var vcCanScroll:Bool = false
    var fingerIsTouch:Bool = false
//    
//    var isTableViewLoadData: Bool = false
    
    
    let identifier:String = "OrderList"
    override func viewDidLoad() {
        super.viewDidLoad()
          setupSubViews()
        // Do any additional setup after loading the view.
    }
    func setupSubViews() {
//        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: SCREENHEIGHT-64-44-50), style: .plain)
//        tableView?.delegate = self
//        tableView?.dataSource = self
//        self.view.addSubview(tableView!)
        super.setupSubViews(rect: CGRect(x: 0, y: 0, width: view.bounds.width, height: SCREENHEIGHT-64-50), style: .plain, isShowHead: true,isShowFooter: true)
        let nib:UINib = UINib.init(nibName: identifier, bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: identifier)
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView?.backgroundColor = lightColor
        
        
        
//        super.setupSubViews(rect:CGRect(x: 0, y: -64, width: view.bounds.width, height: SCREENHEIGHT-44+64),style: UITableViewStyle.plain)
//        
//        showCustomLoadAnimate(self.view)
//        
//        hiddenCustomView()
        
        
//        for i in (0...10) {
//                            print(i)
//            //               indexPaths.append(IndexPath(item: i, section: 0))
//        }
        
        
        
        GCDQueue.execute(inMainQueue: {() -> Void in
            //        // Load data.
//        var indexPaths = [IndexPath]()
            
     self.isTableViewLoadData = true
        var i = 0
//            for i in 0... < 10 {
////                print(i)
////               indexPaths.append(IndexPath(item: i, section: 0))
//            }
            
        
            while i < 17 {
                self.dateArray.append(IndexPath(item: i, section: 0))
                i += 1
            }
            
            
            self.tableView!.insertRows(at: self.dateArray , with: .fade)
        }, afterDelaySecs: 0.25)
        
        
        
//        loopViews.tapClickBlock = {(loopView)-> Void in
//            let alert = UIAlertView(title: "文字", message: "老：\(loopViews.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "cancle")
//            alert.show()
//        }
        
        
        
        
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 17
        return self.dateArray.count;
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//        if cell == nil {
//            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
//        }
//        cell?.textLabel?.text = self.title
        
        
        
                        var cellTop:OrderList! = tableView.dequeueReusableCell(withIdentifier: identifier) as? OrderList
                         cellTop.setIndex(dex: indexPath.row)
                 cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
        
                        if cellTop == nil {
                            cellTop = OrderList(style: .default, reuseIdentifier: identifier)
                        }
        cellTop.selectionStyle = UITableViewCellSelectionStyle.none
                        return cellTop!
        
        
//        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let v = GoodDetailViewController()
//        v.title = "商品详情"
        
        self.navigationController?.pushViewController(v, animated: true)
    }
    //接触屏幕
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       
        fingerIsTouch = true
    }
    
    //离开屏幕
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       
        fingerIsTouch = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if vcCanScroll {

            scrollView.contentOffset = CGPoint.zero
            
        }
        if scrollView.contentOffset.y <= 0 {
//            if fingerIsTouch {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
//                return
//            }
            vcCanScroll = false
            scrollView.contentOffset = CGPoint.zero
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leaveTop"), object: nil) //到顶通知父视图改变状态
        }
        tableView?.showsVerticalScrollIndicator = vcCanScroll ? true:false
    }
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
