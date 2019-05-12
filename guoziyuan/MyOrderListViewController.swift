//
//  FSScrollContentViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class MyOrderListViewController: TableViewController,FSSegmentTitleViewDelegate,FSPageContentViewDelegate{
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
    
    
//    var vcCanScroll:Bool = false
//    var fingerIsTouch:Bool = false
//
//    //    var isTableViewLoadData: Bool = false
//    var topImage:UIImage?
    
//    let identifier:String = "OrderList"
    var titleView:FSSegmentTitleView?
    var canScroll:Bool = false
    var contentCell:FSBottomTableViewCell?
//    var canScroll:Bool = false
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
        
        titleView = FSSegmentTitleView(frame: CGRect(x: 0, y: 64, width: view.bounds.width, height: 50), titles: ["全部","待付款","待发货","待收货","已完成"], delegate: self, indicatorType: FSIndicatorTypeEqualTitle)
        titleView?.backgroundColor = lightColor
        self.view.addSubview(titleView!)

        
        setupSubViews()
        //        navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(topImage, for: .default)
        //        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.alpha = 1.0
        
        
        
        //        showLoadView()
        super.showCustomLoadAnimate(view)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeScrollStatus), name: NSNotification.Name(rawValue: "leaveTop"), object: nil)

        canScroll = true
        //        setLeftButtonItemBackWith(UIImage(named: "new_back")!, tintColor: darkColor)
        // Do any additional setup after loading the view.
    }
    
    func changeScrollStatus() {
        canScroll = true
        contentCell?.isCellCanScroll = false
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
        super.setupSubViews(rect:CGRect(x: 0, y: 64+50, width: view.bounds.width, height: SCREENHEIGHT-64-50),style: UITableViewStyle.plain, isShowHead: true,isShowFooter: true)
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
        
//        self.tableView?.mj_header.endRefreshing()
//          super.hiddenCustomView()
        
        
        if self.isTableViewLoadData {
            print("234532345")
            self.tableView?.reloadData()
        }else{
            self.isTableViewLoadData = true
        }
        hiddenCustomView()
        self.tableView?.mj_header.endRefreshing()
        
        
//        if self.isTableViewLoadData {
//            GCDQueue.execute(inMainQueue: {() -> Void in
//                //        // Load data.
//                
//                
//                self.dateArray.removeAll()
//                
//                
//                
//                //                for j in 0...9 {
//                //
//                //                    self.indexPaths.append(IndexPath(item: j, section: 0))
//                //                    if j==9{
//                //                        self.tableView?.mj_header.endRefreshing()
//                //                    }
//                //                }
//                //
//                
//                //                print("1234234ssss=====\(self.indexPaths)")
//                
//                //            while i < 17 {
//                //                indexPaths.append(IndexPath(item: i, section: 0))
//                //                i += 1
//                //            }
//                
//                
//                //                            self.tableView!.insertRows(at: indexPaths , with: .fade)
//                
//                self.isTableViewLoadData = false
//                //                self.tableView!.deleteRows(at: self.indexPaths, with: UITableViewRowAnimation.fade)
//                
//                self.tableView!.reloadData()
//                
//            }, afterDelaySecs: 1.45)
//            
//        }
//        
//        
//        GCDQueue.execute(inMainQueue: {() -> Void in
//            //        // Load data.
//            
//            
//            
//            
//            
//            
//            for j in 0...10 {
//                
//                self.dateArray.append(IndexPath(item: j, section: 0))
//                if j==self.dateArray.count{
//                    //                    self.tableView?.mj_header.endRefreshing()
//                }
//            }
//            
//            self.tableView?.mj_footer.resetNoMoreData()
//            //            print("1234234=====\(self.indexPaths)")
//            
//            //            while i < 17 {
//            //                indexPaths.append(IndexPath(item: i, section: 0))
//            //                i += 1
//            //            }
//            self.isTableViewLoadData = true
//            
//            
//            //            self.tableView!.insertRows(at: indexPaths , with: .fade)
//            
//            self.tableView!.insertRows(at: self.dateArray, with: UITableViewRowAnimation.fade)
//            self.tableView?.mj_header.endRefreshing()
//            super.hiddenCustomView()
//            if(self.dateArray.count > 0){
//                self.hiddenNothing()
//            }else{
//                self.showNothing()
//            }
//            
//        }, afterDelaySecs: 1.45)
        
    }
    override func loadMoreData() {
//        GCDQueue.execute(inMainQueue: {() -> Void in
//            //        // Load data.
//
//
//
//
//            var indexPathsMore = [IndexPath]()
//
//            for j in self.dateArray.count...self.dateArray.count+9 {
//
//                self.dateArray.append(IndexPath(item: j, section: 0))
//                indexPathsMore.append(IndexPath(item: j, section: 0))
//                //                if j==self.indexPaths.count+9{
//                //                    self.tableView?.mj_footer.endRefreshing()
//                ////                    print("1234234222222=====\(self.indexPaths)")
//                ////                    self.tableView?.mj_footer.endRefreshingWithNoMoreData()
//                //                }
//            }
//
//            //            self.tableView?.mj_footer.endRefreshing()
//            self.tableView?.mj_footer.endRefreshingWithNoMoreData()
//
//
//
//            //            while i < 17 {
//            //                indexPaths.append(IndexPath(item: i, section: 0))
//            //                i += 1
//            //            }
//            //            self.isTableViewLoadData = true
//
//            //            self.tableView!.insertRows(at: indexPaths , with: .fade)
//
//            self.tableView!.insertRows(at: indexPathsMore, with: UITableViewRowAnimation.fade)
//
//
//            if self.dateArray.count > 0{
//                self.hiddenNothing()
//            }
//        }, afterDelaySecs: 1.45)
//
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  1
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREENHEIGHT-64
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let FSBaseTopTableViewCellIdentifier: String = "FSBaseTopTableViewCell"
        let FSBaselineTableViewCellIdentifier: String = "FSBaselineTableViewCell"
        
        var cell:UITableViewCell?
        cell = UITableViewCell()
        
        if indexPath.section == 0 {
            contentCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FSBottomTableViewCell
            if contentCell == nil {
                contentCell = FSBottomTableViewCell(style: .default, reuseIdentifier: "cell")
                let titleArr:NSArray = ["全部","待付款","待发货","待收货","已完成"]
                let contentVCs:NSMutableArray = NSMutableArray()
                for title:String in (titleArr as? [String])! {
                    let fs:FSOrderScrollContentViewController = FSOrderScrollContentViewController()
                    fs.title = title
                    contentVCs.add(fs)
                    
                }
                
                //                            contentCell?.viewControllers = contentVCs as! [FSScrollContentViewController]
                //            contentCell?.setViewControllers(viewController: contentVCs as! [FSOrderScrollContentViewController])
                contentCell?.pageContentView = FSPageContentView.init(frame: CGRect(x:0, y:0, width:SCREENWIDTH, height:SCREENHEIGHT-64), childVCs: contentVCs as! [Any], parentVC: self, delegate: self)
                contentCell?.contentView.addSubview((contentCell?.pageContentView)!)
            }
            return contentCell!
            
        }
        return cell!

        
        
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
    
    
    
    func fsContenViewDidEndDecelerating(_ contentView: FSPageContentView!, start startIndex: Int, end endIndex: Int) {
        titleView?.selectIndex = endIndex
        tableView?.isScrollEnabled = true
    }
    
    func fsContentViewDidScroll(_ contentView: FSPageContentView!, start startIndex: Int, end endIndex: Int, progress: CGFloat) {
        tableView?.isScrollEnabled = false
    }
    func fsSegmentTitleView(_ titleView: FSSegmentTitleView!, start startIndex: Int, end endIndex: Int) {
        contentCell?.pageContentView?.contentViewCurrentIndex = endIndex
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
        

        let bottomCellOffset:CGFloat =  (tableView?.rect(forSection: 0).origin.y)!
        if scrollView.contentOffset.y >= bottomCellOffset {
            scrollView.contentOffset = CGPoint(x:0,y:bottomCellOffset)
            if canScroll {
                canScroll = false
                contentCell?.isCellCanScroll = true
            }
        }else{
            if !canScroll {
                scrollView.contentOffset = CGPoint(x: 0, y: bottomCellOffset)
            }
        }
        tableView?.showsVerticalScrollIndicator = canScroll ? true:false

        
        
        let offsetY = scrollView.contentOffset.y
        
        
        var alpha = -offsetY / -44.0
        alpha = alpha > 1 ? 1 : alpha;
        //            setNavAlpha(alpha)
//        navigationBar!.setupBgImageAlpha(alpha, animation: 0.4, compeleteBlock: nil)
        
        
        if offsetY <= 0 {
            //           setNavAlpha(0.0)
            //            navigationBar!.setupBgImageAlpha(0.0, animation: 0.4, compeleteBlock: nil)
            
//            isCityClick = false
//            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
//            btnRigth?.setTitleColor(UIColor.white, for: UIControlState.normal)
//            btn?.setTitleColor(UIColor.white, for: UIControlState.normal)
//            btn?.setImage(UIImage(named:"new_arrow_down"), for: UIControlState.normal)
//            btnRigth?.setImage(UIImage(named:"new_arrow_down"), for: UIControlState.normal)
//            btn?.sizeToFit()
//            btnRigth?.sizeToFit()
        } else {
            //            let alpha = -offsetY / -64.0
            //            setNavAlpha(alpha)
            //            navigationBar!.setupBgImageAlpha(alpha, animation: 0.4, compeleteBlock: nil)
            
//            isCityClick = true
//            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
//            btnRigth?.setTitleColor(darkColor, for: UIControlState.normal)
//            btn?.setTitleColor(darkColor, for: UIControlState.normal)
//            btn?.setImage(UIImage(named:"new_arrow_graydown"), for: UIControlState.normal)
//            btnRigth?.setImage(UIImage(named:"new_arrow_graydown"), for: UIControlState.normal)
//            btn?.sizeToFit()
//            btnRigth?.sizeToFit()
        }
        
        
        print(offsetY)
        
//        if offsetY < -64 {
//            self.navigationController?.navigationBar.isHidden = true;
//
//        }else{
//            self.navigationController?.navigationBar.isHidden = false;
//
//        }
        
//        if(offsetY < -ImageHight)
//        {
//            var frame:CGRect = cellTop!.frame;
//            //            frame.origin.y = offsetY;
//            frame.size.height = -offsetY;
//            cellTop!.frame = frame;
//
//            print( frame.origin.y)
//        }
        
        
        
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

