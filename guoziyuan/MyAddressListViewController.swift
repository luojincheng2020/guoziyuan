//
//  FSScrollContentViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class MyAddressListViewController: TableViewController{
    var vcCanScroll:Bool = false
    var fingerIsTouch:Bool = false

    var topImage:UIImage?
    
    let identifier:String = "AddressList"
    var nothingButton:UIButton?
    var nothingLabel:UILabel?
//    private lazy var hud:MBProgressHUD? = {
//      return MBProgressHUD.defaultMBProgress(nil)
//    }()
    var hud:MBProgressHUD?
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
        setupSubViews()
//        navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(topImage, for: .default)
//        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.alpha = 1.0
        
       
       
//        showLoadView()
        super.showCustomLoadAnimate(view)
        
        
//        setLeftButtonItemBackWith(UIImage(named: "new_back")!, tintColor: darkColor)
        // Do any additional setup after loading the view.
    }
    
    
    
//    func showLoadView() {
//        //显示菊花:
//        hud? = MBProgressHUD.defaultMBProgress(nil)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
//            self.hud?.hide(true)
//        })
//
//    }
    
    func showNothing() {
        
        
        
        if nothingLabel == nil && nothingButton == nil {
      
        nothingLabel = UILabel(frame:CGRect(x:10,y:200-40,width:SCREENWIDTH-20,height:30))
        
        nothingLabel?.textAlignment = NSTextAlignment.center
        nothingLabel?.text = "您还没有添加过收货地址哦"
        nothingLabel?.textColor = darkColor
        nothingLabel?.font = fontSize(size: 14)
        tableView?.addSubview(nothingLabel!)
        
        
        nothingButton = UIButton(type: UIButtonType.custom)
        nothingButton?.frame = CGRect(x:SCREENWIDTH/2.0-50,y:200,width:100,height:30);
        nothingButton?.setTitle("+添加地址", for: UIControlState.normal)
        nothingButton?.titleLabel?.textAlignment = NSTextAlignment.center
        nothingButton?.setTitleColor(UIColor.white, for: UIControlState.normal)
        nothingButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        nothingButton?.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        nothingButton?.backgroundColor =  UIColor.red
        nothingButton?.setLayerCornerRadius(15, withWidth: 1, color: UIColor.red)
        nothingButton?.addTarget(self,action:#selector(buttonClick(go:)),for:.touchUpInside)
        tableView?.addSubview(nothingButton!)
        }
        
        
       nothingLabel?.alpha = 1.0
       nothingButton?.alpha = 1.0
    }
    func hiddenNothing() {
       nothingLabel?.alpha = 0.0
       nothingButton?.alpha = 0.0
    }
    func buttonClick(go:UIButton) {
        let editAddress = EditeAddressViewController()
        editAddress.title = "添加地址"
        self.navigationController?.pushViewController(editAddress, animated: true)
    }
    
    func setupSubViews() {
       super.setupSubViews(rect:CGRect(x: 0, y: 0, width: view.bounds.width, height: SCREENHEIGHT),style: UITableViewStyle.plain, isShowHead: true,isShowFooter: true)
        let nib:UINib = UINib.init(nibName: identifier, bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: identifier)
//        tableView?.backgroundColor = lightColor
//        
//        
//        tableView?.sectionIndexColor = greenColor;
//        
//        tableView?.sectionIndexBackgroundColor = UIColor.clear;
//        tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
//        tableView?.backgroundColor = lightColor
        //        sectionIndexMinimumDisplayRowCount: 个数大于该值才会显示索引,默认为0。
        //        触摸时索引条背景的颜色:
        //        tableView?.sectionIndexTrackingBackgroundColor =  darkColor
//        tableView?.addIndexTip()
        

        
        
        
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
            
            
            
            
            
            
            for j in 0...10 {
                
                self.dateArray.append(IndexPath(item: j, section: 0))
                if j==self.dateArray.count{
//                    self.tableView?.mj_header.endRefreshing()
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
            self.tableView?.mj_header.endRefreshing()
            super.hiddenCustomView()
            if(self.dateArray.count > 0){
               self.hiddenNothing()
            }else{
              self.showNothing()
            }
            
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
            
            
            if self.dateArray.count > 0{
                self.hiddenNothing()
            }
        }, afterDelaySecs: 1.45)
        
        
    }

    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  self.dateArray.count
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        var cellTop:AddressList! = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddressList
        cellTop.setIndex(dex: indexPath.row)
//        cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
        
        if cellTop == nil {
            cellTop = AddressList(style: .default, reuseIdentifier: identifier)
        }
        cellTop.selectionStyle = UITableViewCellSelectionStyle.none
     
        
        cellTop.deletePressedBlock = {(delivery)-> Void in
            let alert = UIAlertView(title: "是否删除该地址", message: "选择了\(delivery)", delegate: self as? UIAlertViewDelegate, cancelButtonTitle: "否", otherButtonTitles: "是")
            alert.show()
        }
        cellTop.editePressedBlock = {(delivery)-> Void in
            let editAddress = EditeAddressViewController()
            editAddress.title = "修改地址"
            self.navigationController?.pushViewController(editAddress, animated: true)
        }
        
        
        return cellTop!
      
        
        
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int){
        
        print("=====\(buttonIndex)")
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    


    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        //        self.navigationController?.navigationBar.isHidden = false
        //        navigationController?.navigationBar.subviews.first?.alpha = 1.0
        navigationController?.setNavigationBarHidden(false, animated: true)
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
