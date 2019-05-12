//
//  FSScrollContentViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class ShopTableViewController: TableViewController {
    var vcCanScroll:Bool = false
    var fingerIsTouch:Bool = false

    
    
    let identifier:String = "ShopTableViewCell"
    
    //索引数组
    private lazy var cityDataSource : NSArray = {
        let list:[String] = [
            "长宁区", "嘉定区", "黄浦区", "静安区", "青浦区", "闸北区", "杨浦区",
            "卢湾区"]
        
        return list as NSArray
    }()
    
    private lazy var cityDataSourcetwo : NSArray = {
        let list:[String] = [
            "长宁", "嘉定", "黄浦", "静安", "青浦", "闸北", "杨浦",
            "卢湾"]
        
        return list as NSArray
    }()
    
    
    
    //索引数组
    private lazy var characterDataSource : NSArray = {
        let list:[String] = [
            "A", "B", "C", "D", "E", "F", "G",
            "H", "I", "J", "K", "L", "M", "N",
            "O", "P", "Q", "R", "S", "T",
            "U", "V", "W", "X", "Y", "Z"]
        
        return list as NSArray
    }()
    
    
    var shadowImage:UIImage?
 

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowImage = self.navigationController?.navigationBar.shadowImage
        setupSubViews()
        // Do any additional setup after loading the view.
    }
    func setupSubViews() {
//        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: SCREENHEIGHT-44-64), style: .plain)
//        tableView?.delegate = self
//        tableView?.dataSource = self
        //        tableView?.bounces = false
        //        view.addSubview(tableView!)
//        self.view.addSubview(tableView!)
        
        
        
        super.setupSubViews(rect: CGRect(x: 0, y: 0, width: view.bounds.width, height: SCREENHEIGHT-44-64),style: UITableViewStyle.plain, isShowHead: true,isShowFooter: false)
        
        showCustomLoadAnimate(self.view)
        
        
        
        
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
        tableView?.addIndexTip()
        

        
        
        //        loopViews.tapClickBlock = {(loopView)-> Void in
        //            let alert = UIAlertView(title: "文字", message: "老：\(loopViews.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "cancle")
        //            alert.show()
        //        }
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    
    override func loadNewData() {
        
        
        
        
        if self.isTableViewLoadData {
            GCDQueue.execute(inMainQueue: {() -> Void in
        
                
                self.dateArray.removeAll()
                

                
                self.isTableViewLoadData = false
  
                
                self.tableView!.reloadData()
                
            }, afterDelaySecs: 1.45)
            
        }
        
        
        GCDQueue.execute(inMainQueue: {() -> Void in
            //        // Load data.
//            var indexPaths = [IndexPath]()
            
            
            
            for i in 0...7 {
                
                for j in 0...9 {
                    
                    self.dateArray.append(IndexPath(item: j, section: i))
                }
                
                if i == 7 {
                    super.hiddenCustomView()
                    self.tableView?.mj_header.endRefreshing()
                }
            }
 
            self.isTableViewLoadData = true
            
            
            //            self.tableView!.insertRows(at: indexPaths , with: .fade)
//            print("33333333=====\(self.dateArray)")
            self.tableView!.insertRows(at: self.dateArray, with: UITableViewRowAnimation.fade)
            
        }, afterDelaySecs: 0.25)
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if  section == 0 {
//            let titleView = UIView(frame: CGRect(x:0,y:0,width:SCREENWIDTH,height:50))
//            //                = FSSegmentTitleView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50), titles: ["全部", "葡萄", "猕猴桃", "苹果", "香蕉", "西瓜", "芒果","梨"], delegate: self as! FSSegmentTitleViewDelegate, indicatorType: FSIndicatorTypeEqualTitle)
//            titleView.backgroundColor = lightColor
//            return titleView
//        }else{
//            let titleView = UIView(frame: CGRect(x:0,y:0,width:SCREENWIDTH,height:50))
////                = FSSegmentTitleView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50), titles: ["全部", "葡萄", "猕猴桃", "苹果", "香蕉", "西瓜", "芒果","梨"], delegate: self as! FSSegmentTitleViewDelegate, indicatorType: FSIndicatorTypeEqualTitle)
//            titleView.backgroundColor = lightColor
//            return titleView
//        }
      
        let labelTitle = UILabel(frame:CGRect(x:10,y:0,width:SCREENWIDTH-20,height:30))
        labelTitle.text = cityDataSource[section] as? String
        labelTitle.textColor = darkColor
        labelTitle.font = fontSize(size: 14)
        let backview = UIView(frame:CGRect(x:0,y:0,width:SCREENWIDTH,height:40))
        backview.addSubview(labelTitle)
        backview.backgroundColor = lightColor
        return backview
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return self.dateArray.count/8
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.section == 0{
//         var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//           if cell == nil {
//             cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
//                        }
//          cell?.textLabel?.text = self.title
//            return cell!
//        
//        }else{
        
        var cellTop:ShopTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? ShopTableViewCell
        cellTop.setIndex(dex: indexPath.row)
        cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
        
        if cellTop == nil {
            cellTop = ShopTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cellTop.selectionStyle = UITableViewCellSelectionStyle.none
        return cellTop!
//        }
        
    
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        let vs = ShopDetailViewController()
//         vs.title = "商家详情"
//       v.topImage = shadowImage
        self.navigationController?.pushViewController(vs, animated: true)
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
    
    
    func fsContenViewDidEndDecelerating(_ contentView: FSPageContentView!, start startIndex: Int, end endIndex: Int) {
//        titleView?.selectIndex = endIndex
//        tableView?.isScrollEnabled = true
    }
    
    func fsContentViewDidScroll(_ contentView: FSPageContentView!, start startIndex: Int, end endIndex: Int, progress: CGFloat) {
//        tableView?.isScrollEnabled = false
    }
    func fsSegmentTitleView(_ titleView: FSSegmentTitleView!, start startIndex: Int, end endIndex: Int) {
//        contentCell?.pageContentView?.contentViewCurrentIndex = endIndex
    }
    
    
    
    
    //实现索引数据源代理方法
//    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//        return characterDataSource as? [String]
//    }


    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return cityDataSourcetwo as? [String]
    }
    
    
   //手势计算:
    @objc fileprivate func indexTitlesPan(_ rgz: UIPanGestureRecognizer) {
        
        // 计算点击到哪个索引
//        let count = (cityDataSourcetwo?.count ?? 0)+1
//        let indexHeight = CGFloat(count)*IndexTitlesViewHeight
//        let tableViewHeight = kAppHeight-NavigationH-50
//        let startY = (tableViewHeight-indexHeight)/2
//        
//        let offsetY = rgz.location(in: rgz.view).y
//        var selectIndex = Int((offsetY - startY)/IndexTitlesViewHeight)
//        
//        if selectIndex < 0 {
//            selectIndex = 0
//        } else if selectIndex > count-2 {
//            selectIndex = count-2
//        }
//        
//        // 结束隐藏悬浮View
//        if rgz.state == .ended {
//            alertLabel.isHidden = true
//        } else {
//            alertLabel.text = addressBooksByLetter?[selectIndex].name
//            alertLabel.isHidden = false
//        }
        
        // 因为pan手势会吸收索引原本点击事件,需要自行实现tableView跳转
//        tableView.scrollToRow(at: IndexPath(row: 0, section: selectIndex), at: .top, animated: false)
    }
    

    
    
    
    //点击索引，移动TableView的组位置
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
//        
//        for view in tableView.subviews {
//         
//            if  Int(view.frame.width) == 26 {
//            
////                view.gestureRecognizers = nil
//                view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(indexTitlesPan(_:))))
//            }
////            if view.frame.width == 26.484 {
////                view.gestureRecognizers = nil
////                view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(indexTitlesPan(_:))))
////            }
//        }
        //
        
        
        
        var tpIndex:Int = 0
        //遍历索引值
        for character in cityDataSourcetwo{
            //判断索引值和组名称相等，返回组坐标
            if character as! String == title{
                return tpIndex
            }
            tpIndex += 1
        }
        return 0
  
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cityDataSourcetwo[section] as? String;
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
