//
//  IndexViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/20.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit


class DiscoverGoodDetailViewController: BaseSubViewController,UITableViewDelegate,UITableViewDataSource,FSSegmentTitleViewDelegate,FSPageContentViewDelegate{
    var login:UIButton?
    var img:YLImageView?
    var tableView:BaseTableView?
    var titleView:FSSegmentTitleView?
    
    var contentCell:FSBottomTableViewCell?
    var canScroll:Bool = false
    var isCityClick:Bool = false
    var isfromShop:Bool = false
    var cellTop:FSBaseTopTableViewCell?
    var drawView:DrawMarqueeView?
    let ImageHight:CGFloat = 64
    var btn:UIButton?
    var isBuy:Bool = false
    var btnRigth:UIButton?
    func addNavBtn(_ title: String) -> UIBarButtonItem {
        btn = UIButton(frame: CGRect(x: 0, y: 0, width:0, height: 44))
        btn?.setTitle(title, for: UIControlState())
        btn?.setTitleColor(blackColor, for: UIControlState())
        btn?.addTarget(self, action: #selector(IndexViewController.cityClick), for: UIControlEvents.touchUpInside)
        btn?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn?.setImage(UIImage(named:"new_arrow_down"), for: UIControlState.normal)
        btn?.titleLabel?.textAlignment = NSTextAlignment.left
        btn?.sizeToFit()
        return UIBarButtonItem(customView: btn!)
    }
    override func back() {
        //        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        self.navigationController?.navigationBar.isHidden = true
        //        navigationController?.navigationBar.subviews.first?.alpha = 0.0
        self.navigationController?.popViewController(animated: true)
    }
    func addNavRightBtn(_ title: String) -> UIBarButtonItem {
        btnRigth = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        btnRigth?.setImage(UIImage(named:"new_back"), for: UIControlState.normal)
        btnRigth?.tintColor = UIColor.white
        btnRigth?.addTarget(self, action: #selector(GoodDetailViewController.back), for: UIControlEvents.touchUpInside)
        btnRigth?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btnRigth?.sizeToFit()
        return UIBarButtonItem(customView: btnRigth!)
    }
    func cityClick() {
        isCityClick = true
        let v = CityListViewController()
        v.title = "选择城市"
        self.navigationController?.pushViewController(v, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "商品详情"
        
        
        navigationItem.leftBarButtonItem =  addNavRightBtn("")
        
        var cityNow = UserDefaults.standard.object(forKey: "selectcityName") as? String
        
        
        if cityNow == nil {
            
            cityNow  = "城市"
        }
        
        
        //        navigationItem.rightBarButtonItem = addNavBtn(cityNow!)
        
        
        //        navigationController?.navigationBar.barTintColor = UIColor.redColor()
        //背景色
        //        let image = drawImageFromColor(UIColor.redColor().colorWithAlphaComponent(1.0), size: CGSize(width: view.bounds.width, height: 64.0))
        
        //        navigationController?.navigationBar.setBackgroundImage(image, forBarMetrics: .Default)
        
        //        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        //        navigationController?.navigationBar.shadowImage = UIImage()
        ////
        //        let test = UIView(frame: CGRect(x: 0.0, y: -20.0, width: UIScreen.mainScreen().bounds.size.width, height: 64.0))
        //        test.backgroundColor = UIColor.redColor()
        //        navigationController?.navigationBar.insertSubview(test, atIndex: 0)
        
        // 使用分类
        //        navigationController?.zj_setBackgroundColor(UIColor.red, alpha: 1.0)
        
        
        
        //
        //        if (tableView == nil) {
        tableView = BaseTableView(frame: CGRect(x: 0, y: -64, width: view.bounds.width, height: SCREENHEIGHT+14), style: .plain)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        //            tableView?.bounces = false
        
        //        tableView?.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
        
        
        tableView?.backgroundColor = lightColor
        
        view.addSubview(tableView!)
        
        
        let payView = Bundle.main.loadNibNamed("SelectView", owner: self, options: nil)?[0] as? SelectView
        payView?.frame = CGRect(x:0,y:SCREENHEIGHT-50,width:SCREENWIDTH,height:50)
        
        payView?.clickAction = {()-> Void in
            let order = OrderViewController()
            order.title = "订单详情"
            self.isBuy = true
            order.isFromeShop = self.isfromShop
            self.navigationController?.pushViewController(order, animated: true)
        }
        
        view.addSubview(payView!)
        
        //        }
        
        
        
        /*
         img = YLImageView(frame:CGRect(x:10,y:100,width:200,height:200))
         //        img.image = UIImage(named:"integral")
         
         //        let url = "http://www.aibaimm.com/data/attachment/forumthumb/2017/8/9/113934mtwdty7xd33zrcry.png"
         //        let strUrl = URL(string:url)
         //        img.sd_setImage(with: strUrl, placeholderImage: UIImage(named:"integral"))
         
         
         let path = Bundle.main.url(forResource: "shuiguo", withExtension: "gif")?
         .absoluteString as String!
         img?.image = YLGIFImage(contentsOfFile: path!)
         
         
         
         
         view.addSubview(img!)
         
         
         
         
         
         
         ///GET 请求
         //        XMSessionManager.shared.request(URLString: "http://www.aibaimm.com/data/attachment/forumthumb/2017/8/9/113934mtwdty7xd33zrcry.png", parameters: nil, completed:{(json: AnyObject?,isSuccess: Bool)-> () in
         //
         //            // 请求成功
         //            if isSuccess {
         //                print(json ?? ""+"22222")
         //            } else {
         //                print("请求失败")
         //            }
         //        })
         
         
         ///POST 请求
         XMSessionManager.shared.request(Method: XMHTTPMethod.POST,URLString: "http://www.aibaimm.com/api/mobile/index.php?loginfield=auto&charset=utf-8&version=5&loginsubmit=yes&mobile=no&module=merchantlogin", parameters: ["username":"会飞的炒锅" as AnyObject,"password":"88888888" as AnyObject], completed:{(json: AnyObject?,isSuccess: Bool)-> () in
         // 请求成功
         if isSuccess {
         print(json ?? "")
         } else {
         print("请求失败")
         }
         })
         
         
         
         login = UIButton(type: UIButtonType.custom)
         login?.frame = CGRect(x:10,y:500,width:300,height:30);
         login?.setTitle("登录", for: UIControlState.normal)
         login?.setTitleColor(UIColor.red, for: UIControlState.normal)
         //        login?.addTarget(self, action:#selector(buttonClicked(_:)), forControlEvents: UIControlEvents.touchUpInside)
         login?.addTarget(self,action:#selector(buttonClick(buttonss:)),for:.touchUpInside)
         
         //        login?.addTarget(self,action:Selector("buttonClick"),for:UIControlEvents.touchUpInside)
         
         
         view.addSubview(login!)
         //
         
         
         */
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeScrollStatus), name: NSNotification.Name(rawValue: "leaveTop"), object: nil)
        
        canScroll = true
        
        // Do any additional setup after loading the view.
    }
    
    
    func changeScrollStatus() {
        canScroll = true
        contentCell?.isCellCanScroll = false
    }
    
    //    var tableView:BaseTableView {
    //        if tableView {
    //            tableView = BaseTableView()
    //        }
    //        return tableView
    //    }
    //    func getTableView() -> BaseTableView {
    //
    //      return tableView!
    //    }
    //    func setTableView() {
    //        if (tableView == nil) {
    //            tableView = BaseTableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .plain)
    //
    //            tableView?.delegate = self
    //            tableView?.dataSource = self
    //            tableView?.bounces = false
    //            tableView?.backgroundColor = greenColor
    //            view.addSubview(tableView!)
    //        }
    //    }
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 200
        }
        
        
        let labelTitle = UILabel(frame:CGRect(x:10,y:5,width:SCREENWIDTH-20,height:30))
        labelTitle.text = "商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍123"
        labelTitle.textColor = darkColor
        labelTitle.numberOfLines = 0
        labelTitle.font = fontSize(size: 14)
        labelTitle.sizeToFit()
        return labelTitle.frame.size.height + 10
        //            return 50
        
        
    }
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //
    //
    //        if section == 0 {
    //            return 0
    //        }
    //        return 50
    //    }
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //
    //
    //        let labelTitle = UILabel(frame:CGRect(x:10,y:5,width:SCREENWIDTH-20,height:30))
    //        labelTitle.text = "商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍"
    //        labelTitle.textColor = darkColor
    //        labelTitle.font = fontSize(size: 14)
    //        labelTitle.sizeToFit()
    //        let backview = UIView(frame:CGRect(x:0,y:0,width:SCREENWIDTH,height:labelTitle.frame.size.height+15+50))
    //        backview.addSubview(labelTitle)
    //        backview.backgroundColor = lightColor
    //
    //
    //        titleView = FSSegmentTitleView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50), titles: ["全部", "葡萄", "猕猴桃", "苹果", "香蕉", "西瓜", "芒果","梨"], delegate: self, indicatorType: FSIndicatorTypeEqualTitle)
    //        titleView?.backgroundColor = lightColor
    //        return titleView
    //    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let FSBaseTopTableViewCellIdentifier: String = "FSBaseTopTableViewCell"
        //        let FSBaselineTableViewCellIdentifier: String = "FSBaselineTableViewCell"
        
        var cell:UITableViewCell?
        cell = UITableViewCell()
        
        
        if indexPath.row == 0 {
            cellTop = tableView.dequeueReusableCell(withIdentifier: FSBaseTopTableViewCellIdentifier) as? FSBaseTopTableViewCell
            if cellTop == nil {
                cellTop = FSBaseTopTableViewCell(style: .default, reuseIdentifier: FSBaseTopTableViewCellIdentifier)
            }
            
            //                if drawView == nil {
            
            
            
            
            return cellTop!
        }
            //            else if indexPath.row == 1{
            //                var cellLine:FSBaselineTableViewCell! = tableView.dequeueReusableCell(withIdentifier: FSBaselineTableViewCellIdentifier) as? FSBaselineTableViewCell
            //                if cellLine == nil {
            //                    cellLine = FSBaselineTableViewCell(style: .default, reuseIdentifier: FSBaselineTableViewCellIdentifier)
            //                }
            //
            //
            //
            //
            //                return cellLine!
            //            }
        else{
            let labelTitle = UILabel(frame:CGRect(x:10,y:5,width:SCREENWIDTH-20,height:30))
            labelTitle.text = "商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍商家介绍123"
            labelTitle.textColor = darkColor
            labelTitle.numberOfLines = 0
            labelTitle.font = fontSize(size: 14)
            labelTitle.sizeToFit()
            let backview = UIView(frame:CGRect(x:0,y:0,width:SCREENWIDTH,height:labelTitle.frame.size.height+10))
            backview.addSubview(labelTitle)
            backview.backgroundColor = UIColor.white
            cell?.contentView.addSubview(backview)
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            return cell!
        }
        
        
        //        else if indexPath.section == 1 {
        //            contentCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FSBottomTableViewCell
        //            if contentCell == nil {
        //                contentCell = FSBottomTableViewCell(style: .default, reuseIdentifier: "cell")
        //                let titleArr:NSArray = ["全部", "葡萄", "猕猴桃", "苹果", "香蕉", "西瓜", "芒果","梨"]
        //                let contentVCs:NSMutableArray = NSMutableArray()
        //                for title:String in (titleArr as? [String])! {
        //                    let fs:FSScrollContentViewController = FSScrollContentViewController()
        //                    fs.title = title
        //                    contentVCs.add(fs)
        //
        //                }
        //
        //                //                contentCell?.viewControllers = contentVCs as! [FSScrollContentViewController]
        //                contentCell?.setViewControllers(viewController: contentVCs as! [FSScrollContentViewController])
        //                contentCell?.pageContentView = FSPageContentView.init(frame: CGRect(x:0, y:0, width:SCREENWIDTH, height:100*17), childVCs: contentVCs as! [Any], parentVC: self, delegate: self)
        //                contentCell?.contentView.addSubview((contentCell?.pageContentView)!)
        //            }
        //            return contentCell!
        //        }
        //        return cell!
    }
    
    
    func buttonClick(buttonss:UIButton) {
        //        print("12344345==="+(buttonss.titleLabel?.text)!)
        
        
        
        
        //        if (img?.isAnimating)! {
        //            login?.setTitle("播放", for: UIControlState.normal)
        //            img?.stopAnimating()
        //        } else {
        //            login?.setTitle("暂停", for: UIControlState.normal)
        //            img?.startAnimating()
        //        }
        //
        
        
        let v = LoginViewController()
        
        let navIndex = UINavigationController(rootViewController: v)
        
        
        self.present(navIndex,animated:true,completion:nil)
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
        
        //        let bottomCellOffset:CGFloat =  (tableView?.rect(forSection: 1).origin.y)! - 64*2 - 44
        //        if scrollView.contentOffset.y >= bottomCellOffset{
        //            scrollView.contentOffset = CGPoint(x:0,y:bottomCellOffset)
        //            if canScroll {
        //                canScroll = false
        //                contentCell?.isCellCanScroll = true
        //            }
        //        }else{
        //            if !canScroll {
        //                scrollView.contentOffset = CGPoint(x: 0, y: bottomCellOffset)
        //            }
        //        }
        //        tableView?.showsVerticalScrollIndicator = canScroll ? true:false
        
        
        
        let offsetY = scrollView.contentOffset.y
        //        print("1111====\(offsetY)")
        if offsetY <= 0 {
            setNavAlpha(0.0)
            //            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            btnRigth?.tintColor = UIColor.white
            btn?.setTitleColor(UIColor.white, for: UIControlState.normal)
            btn?.setImage(UIImage(named:"new_arrow_down"), for: UIControlState.normal)
            btn?.sizeToFit()
            btnRigth?.sizeToFit()
        } else {
            let alpha = -offsetY / -64.0
            setNavAlpha(alpha)
            //            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            btnRigth?.tintColor = darkColor
            btn?.setTitleColor(darkColor, for: UIControlState.normal)
            btn?.setImage(UIImage(named:"new_arrow_graydown"), for: UIControlState.normal)
            btn?.sizeToFit()
            btnRigth?.sizeToFit()
        }
        
        
        //        print(offsetY)
        
        if offsetY < -64 {
            self.navigationController?.isNavigationBarHidden = true;
            
        }else{
            self.navigationController?.isNavigationBarHidden = false;
            
        }
        
        //        if(offsetY < -ImageHight)
        //        {
        //            var frame:CGRect = cellTop!.frame;
        ////            frame.origin.y = offsetY;
        //            frame.size.height = -offsetY;
        //            cellTop!.frame = frame;
        //
        //            print( frame.origin.y)
        //        }
        
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
    
    
    //    extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //            return 100
    //        }
    //
    //        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    //            cell.textLabel?.text = "ceshi \(indexPath.row)"
    //            return cell
    //        }
    //    }
    
    //    extension ViewController: UIScrollViewDelegate {
    //        func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //            let offsetY = scrollView.contentOffset.y
    //
    //            if offsetY <= 0 {
    //                let alpha = offsetY / -64.0
    //                setNavAlpha(alpha)
    //            } else {
    //                setNavAlpha(0.0)
    //            }
    //        }
    
    func setNavAlpha(_ alpha: CGFloat) {
        //1.没有效果
        //            navigationController?.navigationBar.alpha = alpha
        //2. 没有效果
        //        navigationController?.navigationBar.barTintColor = UIColor(red: 223.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: alpha)
        //3. 动态更改背景图片的alpha
        //        let image = drawImageFromColor(UIColor.redColor().colorWithAlphaComponent(alpha), size: CGSize(width: view.bounds.width, height: 64.0))
        //        navigationController?.navigationBar.setBackgroundImage(image, forBarMetrics: .Default)
        
        //4.改变添加的view的alpha
        
        //        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.subviews.first?.alpha = alpha
        
        
        
        //            print("=====\(alpha)")
        
        //            navigationController?.zj_setBackgroundColor(blueColor, alpha: alpha)
    }
    
    func drawImageFromColor(_ color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.set()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.navigationController?.navigationBar.isHidden = false
        if !isBuy {
            setNavAlpha(0.0)
            
        }else{
            isBuy = false
        }
        
    }
    //    override func viewWillDisappear(_ animated: Bool) {
    //        //      UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    //    }
    //
    override func viewWillDisappear(_ animated: Bool) {
        //      UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        navigationController?.navigationBar.subviews.first?.alpha = 1.0
        self.navigationController?.navigationBar.isHidden = false;
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //        self.navigationController?.navigationBar.isHidden = true;
        if !isCityClick {
            setNavAlpha(0.0)
        }
        isCityClick = false
        
        //        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        
        if btn != nil {
            var cityNow = UserDefaults.standard.object(forKey: "selectcityName") as? String
            
            
            if cityNow == nil {
                
                cityNow  = "城市"
            }
            
            btn?.setTitle(cityNow, for: UIControlState())
            btn?.sizeToFit()
        }
        if drawView == nil {
            
            
            drawView = DrawMarqueeView(frame: CGRect(x:10,y:100,width:SCREENWIDTH-20,height:20))
            //        drawView?.setLayerCornerRadius(2, withWidth: 1, color: lightColor)
            drawView?.speed = 0.5
            if isfromShop {
                drawView?.arr = ["门店商品支持快递送货和上门取货","快递送货请选择购买数量和送货时间","上门取货请选择购买数量和取货时间","购买时请注意是否已售完"];
            }else{
                drawView?.arr = ["线上商品仅支持快递送货","购买时请选择购买数量和送货时间"];
            }
            //                drawView.delegate = self
            drawView?.marqueeDirection = kDrawMarqueeLeft
            tableView?.addSubview(drawView!)
            //        drawView?.center = (cellTop?.center)!
            //
            //        let arr:NSArray = ["马陆葡萄园7月10正式上市了非你；奥拉夫那妇女萨拉放哪里巨峰；那三份；案发饭","猕猴桃8月20开始订购了","更多水果敬请期待"]
            //        let arrColor:NSArray = [UIColor.red,UIColor.green,UIColor.blue]
            //        let label:UILabel = UILabel()
            //        //宽度应该根据text的长度计算
            //
            //        label.numberOfLines = 1
            //        label.textAlignment = NSTextAlignment.center
            //        let num:NSInteger = NSInteger(arc4random()) % 2
            //        let num2:NSInteger = NSInteger(arc4random()) % 2
            //
            //        label.text = arr[num] as? String
            //        label.frame = CGRect(x: 0, y: 20, width: 18 * (label.text?.characters.count)!, height: 20)
            //        label.textColor = arrColor[num2] as! UIColor
            //
            //
            //
            //
            //
            //        drawView?.addContentView(label)
            //        print("2222222222222222222222")
            
        }
        drawView?.startAnimation()
        
        
        
        
        
        
        //        第一步：在Info.plist中设置UIViewControllerBasedStatusBarAppearance 为NO
        //
        //        第二步：在viewDidLoad中加一句
        //
        //        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent;
        
        
        
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
