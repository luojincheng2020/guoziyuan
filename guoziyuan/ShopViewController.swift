//
//  FSScrollContentViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class ShopViewController: TableBaseViewController {
    var vcCanScroll:Bool = false
    var fingerIsTouch:Bool = false
    
    
    let identifier:String = "IndexTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        // Do any additional setup after loading the view.
    }
    func setupSubViews() {
//        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: SCREENHEIGHT), style: .plain)
//        tableView?.delegate = self
//        tableView?.dataSource = self
//
//        self.view.addSubview(tableView!)
        
        
        super.setupSubViews(rect:CGRect(x: 0, y: 0, width: view.bounds.width, height: SCREENHEIGHT),style: UITableViewStyle.plain,isShowHead: true,isShowFooter: true)
        
        
        let nib:UINib = UINib.init(nibName: identifier, bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: identifier)

        showCustomLoadAnimate(self.view)
        
        GCDQueue.execute(inMainQueue: {() -> Void in
            //        // Load data.
            var indexPaths = [IndexPath]()
            
            
            
            for i in 0...29 {
          
            indexPaths.append(IndexPath(item: i, section: 0))
          }
            
            
//            while i < 17 {
//                indexPaths.append(IndexPath(item: i, section: 0))
//                i += 1
//            }
            self.isTableViewLoadData = true
            
//            self.tableView!.insertRows(at: indexPaths , with: .fade)
            
            self.tableView!.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
            
        }, afterDelaySecs: 0.25)
        
        
        
        //        loopViews.tapClickBlock = {(loopView)-> Void in
        //            let alert = UIAlertView(title: "文字", message: "老：\(loopViews.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "cancle")
        //            alert.show()
        //        }
        
        
        
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return 17
        return self.isTableViewLoadData ? 30 : 0;
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//                var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//                if cell == nil {
//                    cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
//                }
//                cell?.textLabel?.text = self.title
        
        
        
        var cellTop:IndexTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? IndexTableViewCell
        cellTop.setIndex(dex: indexPath.row)
        cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
        
        if cellTop == nil {
            cellTop = IndexTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cellTop.selectionStyle = UITableViewCellSelectionStyle.none
        return cellTop!
        
        
//                return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let v = ShopIndexViewController()
        
//        let navIndex = UINavigationController(rootViewController: v)
        
        
//        self.present(V,animated:true,completion:nil)
        self.navigationController?.pushViewController(v, animated: true)
    }
//    //接触屏幕
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("222")
//        fingerIsTouch = true
//    }
//    
//    //离开屏幕
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        print("111")
//        fingerIsTouch = false
//    }
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if vcCanScroll {
//            
//            scrollView.contentOffset = CGPoint.zero
//            
//        }
//        if scrollView.contentOffset.y <= 0 {
//            //            if fingerIsTouch {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
//            //                return
//            //            }
//            vcCanScroll = false
//            scrollView.contentOffset = CGPoint.zero
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leaveTop"), object: nil) //到顶通知父视图改变状态
//        }
//        tableView?.showsVerticalScrollIndicator = vcCanScroll ? true:false
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
