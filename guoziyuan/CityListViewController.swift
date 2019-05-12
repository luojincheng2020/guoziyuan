//
//  FSScrollContentViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class CityListViewController: BaseSubViewController ,UITableViewDelegate,UITableViewDataSource{
    var tableView:UITableView?
    var vcCanScroll:Bool = false
    var fingerIsTouch:Bool = false
    var labelTitle:UILabel?
    var isTableViewLoadData: Bool = false
    var topImage:UIImage?
    
    let identifier:String = "CityTitleCell"
    var selectIndex:NSInteger?
    //索引数组
    private lazy var titleDateSource : NSArray = {
        let list:[String] = ["上海","苏州","杭州","昆山"]
        return list as NSArray
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        selectIndex = 999
        
//        navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.setBackgroundImage(topImage, for: .default)
////        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.alpha = 1.0
        
        
        
//        let delay = DispatchTime.now() + 0.3
//        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.setupSubViews()
//        }
        
        
//
//        setLeftButtonItemBackWith(UIImage(named: "new_back")!, tintColor: darkColor)
        // Do any additional setup after loading the view.
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
            
            
            
           
                
                for j in 0..<self.titleDateSource.count {
                    
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
        
        return 30
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.isTableViewLoadData ? self.titleDateSource.count : 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        var cellTop:CityTitleCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? CityTitleCell
        cellTop.setIndex(dex: indexPath.row)
        cellTop.titleLabel?.text = self.titleDateSource[indexPath.row] as? String
        
        if cellTop == nil {
            cellTop = CityTitleCell(style: .default, reuseIdentifier: identifier)
        }
        cellTop.selectionStyle = UITableViewCellSelectionStyle.none
   
        let indexNow = UserDefaults.standard.object(forKey: "selectcity") as? String
        
      
        if indexNow != nil{
            if indexPath.row == Int(indexNow!)!  {
                 cellTop?.icon?.isHidden = false
            }else{
               cellTop?.icon?.isHidden = true 
            }
          
        }else{
           cellTop?.icon?.isHidden = true
        }
        

        return cellTop!
      
        
        
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
        
        labelTitle = UILabel(frame:CGRect(x:10,y:0,width:SCREENWIDTH-20,height:30))
//        if selectIndex != 999 {
//           labelTitle?.text = titleDateSource[selectIndex!] as? String
//        }
//        
       let indexNow = UserDefaults.standard.object(forKey: "selectcity") as? String
 
    
        if indexNow != nil {
           labelTitle?.text = "已选择城市:".appending((titleDateSource[Int(indexNow!)!] as? String)!)
        }else{
             labelTitle?.text = "请选择城市"
        }
        
        labelTitle?.textColor = darkColor
        labelTitle?.font = fontSize(size: 14)
        let backview = UIView(frame:CGRect(x:0,y:0,width:SCREENWIDTH,height:40))
        backview.addSubview(labelTitle!)
        backview.backgroundColor = lightColor
        return backview
    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectIndex = indexPath.row
        
        let userDefault = UserDefaults.standard
        userDefault.set(String(indexPath.row), forKey: "selectcity")
        userDefault.set(titleDateSource[indexPath.row], forKey: "selectcityName")
        userDefault.synchronize()
   
        tableView.reloadData()
        tableView.isUserInteractionEnabled = false
        self.view.makeToastActivityWithMessage(message: "")
        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.view.hideToastActivity()
            tableView.isUserInteractionEnabled = true
            self.navigationController?.popViewController(animated: true)
        }
        
        
        
        
//       self.navigationController?.popViewController(animated: true)
    }
    


    override func viewDidAppear(_ animated: Bool) {
       UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
//        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.subviews.first?.alpha = 1.0
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
