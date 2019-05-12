//
//  MySelfViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/20.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class MySelfViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    var headerImageViewNew:NNPersonalHomePageHeaderImageView?
    var dynamicTableView:NNContentTableView?
    var scrollViewNew:NNContentScrollView?

    var tableView:UITableView?
    var backView: UIImageView?
    var backColor: UIColor?
    var headerHeight: CGFloat = 0.0
    var headerContentView: UIView?
    var headerImageView: UIImageView?
    var icon: UIImageView?
    var label: UILabel?
    var scale: CGFloat = 0.0
    var scaleNew: CGFloat = 0.0
    var iconNew:UIImageView?
    let  kNavigationBarHeight:CGFloat = 0
    let  kStatusBarHeight:CGFloat = 20
    var headerImgHeight:CGFloat = 200
    var iconHeight:CGFloat = 60
    var backViews:UIImageView?
    let identifier:String = "TitleCell"
    var isTableViewLoadData: Bool = false
    var shadowImage:UIImage?
    //原始尺寸
    static var oldframe:CGRect?
    
    //索引数组
    private lazy var titleDateSource : NSArray = {
        let list:[String] = ["我的订单","收货地址","优惠券","关于我们"]
        return list as NSArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowImage = self.navigationController?.navigationBar.shadowImage
        
        
        view.backgroundColor = UIColor.gray
        
        
        setupSubViews()
        
        headerHeight = 260
        
        
        creatNav()
        
        
        
        
//        //去掉背景图片
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        //去掉底部线条
//        navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "nav"), for: .default)
        
        //添加背景view
//        let backView_frame = CGRect(x: 0, y: -kStatusBarHeight, width: SCREENWIDTH, height: kNavigationBarHeight + kStatusBarHeight)
//        backViews = UIImageView(frame: backView_frame)
//        
//        let backColors = lightColor
//        backViews?.backgroundColor = backColor?.withAlphaComponent(0.3)
//        navigationController?.navigationBar.addSubview(backViews!)
//        backView = backViews
//        backColor = backColors
        
        
        
        
//        setupContentView()
        setupHeaderImageView()
        
        
        
        //标题
//        navigationItem.title = "个人信息"
//        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //header
        let bounds = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: headerHeight)
        let contentView = UIView(frame: bounds)
        contentView.backgroundColor = UIColor.black
        
        //背景
        let headerImageView = UIImageView()
        headerImageView.bounds = bounds
        headerImageView.center = contentView.center
        headerImageView.image = UIImage(named: "backImage")
        contentView.layer.masksToBounds = true
        self.headerImageView = headerImageView
        headerContentView = contentView
        headerContentView?.addSubview(self.headerImageView!)
        headerContentView?.layer.masksToBounds = true
        self.scale =  headerImageView.frame.size.width / headerImageView.frame.size.height;
        
       
        
//        [headerImageView setImageToBlur:headerImageView.image blurRadius:21 completionBlock:nil];
        
//        模糊背景效果
//       headerImageView.setImageToBlur(headerImageView.image, blurRadius: 21, completionBlock: nil)

        
        
        
        iconNew = UIImageView(frame: CGRect(x: (SCREENWIDTH - iconHeight) / 2, y: (headerImgHeight - iconHeight) / 2, width: iconHeight, height: iconHeight))
        iconNew?.backgroundColor = UIColor.yellow
        
        iconNew?.image = UIImage(named: "icon")
        iconNew?.layer.cornerRadius = iconHeight * 0.5
        iconNew?.clipsToBounds = true

        headerContentView?.addSubview(iconNew!)
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showImageView(withTap:)))
        iconNew?.isMultipleTouchEnabled = true
        iconNew?.isUserInteractionEnabled = true
        iconNew?.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        
        
        //信息内容
//        let icon_frame = CGRect(x: 12, y: (headerContentView?.bounds.size.height)! - 80 - 12, width: 80, height: 80)
//        let icon = UIImageView(frame: icon_frame)
//        icon.backgroundColor = UIColor.clear
//        icon.image = UIImage(named: "icon")
//        icon.layer.cornerRadius = 80 / 2.0
//        icon.layer.masksToBounds = true
//        icon.layer.borderWidth = 1.0
//        icon.layer.borderColor = UIColor.lightGray.cgColor
//        headerContentView?.addSubview(icon)
//        self.icon = icon
        
        label = UILabel(frame: CGRect(x: 10, y: (headerImgHeight - iconHeight) / 2 + iconHeight, width: SCREENWIDTH - 20, height: 30))
        label?.text = "会飞的砂锅"
        label?.textColor = UIColor.white
        label?.textAlignment = NSTextAlignment.center
        label?.font = UIFont.systemFont(ofSize: 15)
        label?.numberOfLines = 0
        headerContentView?.addSubview(label!)
        let headerView = UIView(frame: bounds)
        headerView.addSubview(headerContentView!)
        self.tableView?.tableHeaderView = headerView
        

        
    }
    
    
    func setupContentView() {
        let scrollView = NNContentScrollView()
        scrollView.delaysContentTouches = false
        backViews?.addSubview(scrollView)
        self.scrollViewNew = scrollView
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: SCREENWIDTH * 3, height: 0)
        let headView = UIView()
        headView.frame = CGRect(x: 0, y: 0, width: 0, height: Int(NNHeadViewHeight + NNTitleHeight))
        
        
        let dynamicTableView = NNContentTableView()
        dynamicTableView.delegate = self
        dynamicTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.dynamicTableView = dynamicTableView
        dynamicTableView.tableHeaderView = headView
        scrollView.addSubview(dynamicTableView)
        //        dynamicTableView.mas_makeConstraints({(make: MASConstraintMaker) -> Void in
        //            make.left.equalTo(scrollView)
        //            make.width.mas_equalTo(NNScreenWidth)
        //            make.top.equalTo(view)
        //            make.bottom.equalTo(view)
        //        })
        
        
        
    }
    



    
    func setupHeaderImageView() {
        headerImageViewNew = NNPersonalHomePageHeaderImageView(image: UIImage(named: "icon"))
        headerImageViewNew?.reloadSize(withScroll: dynamicTableView)
        
        headerImageViewNew?.alpha = 0.0
        headerImageViewNew?.frame = CGRect(x: self.view.frame.size.width/2.0-30, y:20, width: 20, height: 20)
        
        
       navigationBar?.addSubview(headerImageViewNew!)
//        headerImageView?.center = (navigationController?.navigationBar.center)!

       
    
        
        
//        let titleView = UIView(frame: CGRect(x:0, y:8, width:SCREENWIDTH-20, height:60))
//
//        headerImageViewNew!.center = titleView.center
//        titleView.addSubview(headerImageViewNew!)
//        navigationItem.titleView = titleView
        
        
        headerImageViewNew?.handleClickAction({() -> Void in
            //            print("你点击了头像按钮")
            
//                        self.goToast()
//            self.goToastActivity()
//            self.showView()
            
        })
    }
    
    
    
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            
            
//            
//            
//            let bottomCellOffset:CGFloat =  (tableView?.rect(forSection: 1).origin.y)! - 64*2
//            if scrollView.contentOffset.y >= bottomCellOffset {
//                scrollView.contentOffset = CGPoint(x:0,y:bottomCellOffset)
//                if canScroll {
//                    canScroll = false
//                    contentCell?.isCellCanScroll = true
//                }
//            }else{
//                if !canScroll {
//                    scrollView.contentOffset = CGPoint(x: 0, y: bottomCellOffset)
//                }
//            }
//            tableView?.showsVerticalScrollIndicator = canScroll ? true:false
//            
//            
//                    //        if(offsetY < -ImageHight)
//            //        {
//            //            var frame:CGRect = cellTop!.frame;
//            ////            frame.origin.y = offsetY;
//            //            frame.size.height = -offsetY;
//            //            cellTop!.frame = frame;
//            //            
//            //            print( frame.origin.y)
//            //        }
//            
//
//            
//            
            
            
            
            
//            let offset_Y: CGFloat = scrollView.contentOffset.y
//            let alpha: CGFloat = (offset_Y + 40) / 100.0
            
//            print("2345===\(offset_Y)")
            
            
            
            
            let offsetY = scrollView.contentOffset.y
            
            
            var alpha = -offsetY / -44.0
            alpha = alpha > 1 ? 1 : alpha;
            //            setNavAlpha(alpha)
            navigationBar!.setupBgImageAlpha(alpha, animation: 0.4, compeleteBlock: nil)
            headerImageViewNew?.alpha = alpha;
            
            
//            if offsetY <= 0 {
//                setNavAlpha(0.0)
//
//            } else {
//                let alpha = -offsetY / -64.0
//                setNavAlpha(alpha)
//
//            }
//

            
//            if offsetY < -44 {
////                self.navigationController?.navigationBar.isHidden = true
//
//            }else if offsetY == -44{
//
//                headerImageViewNew?.isHidden = true
//
//
//            }else{
////                self.navigationController?.navigationBar.isHidden = false
//                headerImageViewNew?.isHidden = false
//            }
//
            
            
//            iconNew?.center = (headerImageView?.center)!
            if alpha >= 0.5 {
             UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
                
            }else{
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
                
            }
           
//            backView?.backgroundColor = backColor?.withAlphaComponent(alpha)
            
         
            if offsetY < -44 {
                //放大比例
                let add_topHeight: CGFloat = -(offsetY + kNavigationBarHeight + kStatusBarHeight)
                scale = (headerHeight + add_topHeight) / headerHeight
                //改变 frame
                let contentView_frame = CGRect(x: 0, y: -add_topHeight, width: SCREENWIDTH, height: headerHeight + add_topHeight)
                headerContentView?.frame = contentView_frame
                let imageView_frame = CGRect(x: -(SCREENWIDTH * scale - SCREENWIDTH) / 2.0, y: 0, width: SCREENWIDTH * scale, height: headerHeight + add_topHeight)
                
                headerImageView?.frame = imageView_frame
//                let icon_frame = CGRect(x: 12, y: (headerContentView?.bounds.size.height)! - 80 - 12, width: 80, height: 80)
//                icon?.frame = icon_frame
//                label?.frame = CGRect(x: 10, y: (headerContentView?.bounds.size.height)! - 30, width: SCREENWIDTH - 20, height: 30)
                
            }
            
            
            
            if scrollView.contentOffset.y < 0 {
                // 高度宽度同时拉伸 从中心放大
//                let imgH: CGFloat = headerImgHeight - scrollView.contentOffset.y * 2
//                let imgW: CGFloat = imgH * scaleNew
//                headerImageView?.frame = CGRect(x: scrollView.contentOffset.y * scale, y: 0, width: imgW, height: imgH)
                let iconOriginalX: CGFloat = (SCREENWIDTH - iconHeight) / 2
                let iconOriginalY: CGFloat = (headerImgHeight - iconHeight) / 2
                iconNew?.frame = CGRect(x: iconOriginalX + offsetY * changeRate, y: iconOriginalY + offsetY * changeRate * 2, width: iconHeight - changeRate * offsetY * 2, height: iconHeight - changeRate * offsetY * 2)
                
                
                
                
                
                
                
                iconNew?.center = (headerImageView?.center)!
                iconNew?.layer.cornerRadius = (iconNew?.frame.size.width)! * 0.5
                iconNew?.clipsToBounds = true
                label?.frame =  CGRect(x: 10, y: (iconNew?.frame.origin.y)!+(iconNew?.frame.size.height)!, width: SCREENWIDTH - 20, height: 30)
                
//                label.frame = CGRect(x: label.frame.origin.x, y: icon.frame.maxY + 10, width: label.frame.size.width, height: label.frame.size.height)
                
                
            }
//            else {
//                // 只拉伸高度
////                headerImageView?.frame = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 200 - scrollView.contentOffset.y)
//            }
 
        }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    

        func setupSubViews() {
            tableView = UITableView(frame: CGRect(x: 0, y: -20, width: view.bounds.width, height: SCREENHEIGHT+kNavigationBarHeight+kStatusBarHeight), style: .plain)
            tableView?.delegate = self
            tableView?.dataSource = self
            //        tableView?.bounces = false
            //        view.addSubview(tableView!)
    
//            tableView?.bounces = false
            let nib:UINib = UINib.init(nibName: identifier, bundle: nil)
            tableView?.register(nib, forCellReuseIdentifier: identifier)
            tableView?.backgroundColor = lightColor
            
            
//            tableView?.sectionIndexColor = greenColor;
//            
//            tableView?.sectionIndexBackgroundColor = UIColor.clear;
            tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        
            
            view.addSubview(self.tableView!)
            
            
            
            //        sectionIndexMinimumDisplayRowCount: 个数大于该值才会显示索引,默认为0。
            //        触摸时索引条背景的颜色:
            //        tableView?.sectionIndexTrackingBackgroundColor =  darkColor
//            tableView?.addIndexTip()
            
            
//                    let b = ZHBlurtView(frame: view.frame, withHeaderImgHeight: 200, iconHeight: 100)
////                    view.addSubview(b!)
            
            
//            tableView?.tableHeaderView = b!
            
            GCDQueue.execute(inMainQueue: {() -> Void in
                //        // Load data.
                var indexPaths = [IndexPath]()
                 self.isTableViewLoadData = true
                
                
//                for i in 0...7 {
                
                    for j in 0...4 {
                        
                        indexPaths.append(IndexPath(item: j, section: 0))
                    }
                    
//                }

               
                
                self.tableView!.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
                
            }, afterDelaySecs: 0.25)
            
            
            
            //        loopViews.tapClickBlock = {(loopView)-> Void in
            //            let alert = UIAlertView(title: "文字", message: "老：\(loopViews.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "cancle")
            //            alert.show()
            //        }
            
            
            
            
        }
        
//        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            //        if  section == 0 {
//            //            let titleView = UIView(frame: CGRect(x:0,y:0,width:SCREENWIDTH,height:50))
//            //            //                = FSSegmentTitleView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50), titles: ["全部", "葡萄", "猕猴桃", "苹果", "香蕉", "西瓜", "芒果","梨"], delegate: self as! FSSegmentTitleViewDelegate, indicatorType: FSIndicatorTypeEqualTitle)
//            //            titleView.backgroundColor = lightColor
//            //            return titleView
//            //        }else{
//            //            let titleView = UIView(frame: CGRect(x:0,y:0,width:SCREENWIDTH,height:50))
//            ////                = FSSegmentTitleView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50), titles: ["全部", "葡萄", "猕猴桃", "苹果", "香蕉", "西瓜", "芒果","梨"], delegate: self as! FSSegmentTitleViewDelegate, indicatorType: FSIndicatorTypeEqualTitle)
//            //            titleView.backgroundColor = lightColor
//            //            return titleView
//            //        }
//            
////            let labelTitle = UILabel(frame:CGRect(x:10,y:0,width:SCREENWIDTH-20,height:30))
////            labelTitle.text = cityDataSource[section] as? String
////            labelTitle.textColor = darkColor
////            labelTitle.font = fontSize(size: 14)
////            let backview = UIView(frame:CGRect(x:0,y:0,width:SCREENWIDTH,height:40))
////            backview.addSubview(labelTitle)
////            backview.backgroundColor = lightColor
////            return backview
//            
//            let b = ZHBlurtView(frame: view.frame, withHeaderImgHeight: 200, iconHeight: 100)
//            return b!
//            
//        }
    
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            
            return 0
        }
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return self.isTableViewLoadData ? 5 : 0
            
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.row == titleDateSource.count {
                return 80
            }
            return 50
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            //        if indexPath.section == 0{
            //         var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            //           if cell == nil {
            //             cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            //                        }
            //          cell?.textLabel?.text = self.title
            //            return cell!
            //
            //        }else{
            
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            
            if indexPath.row < titleDateSource.count {
                
            
            
            var cellTop:TitleCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? TitleCell
            cellTop.setIndex(dex: indexPath.row)
            cellTop.titleLabel?.text = titleDateSource[indexPath.row] as? String
            
            if cellTop == nil {
                cellTop = TitleCell(style: .default, reuseIdentifier: identifier)
            }
            cellTop.selectionStyle = UITableViewCellSelectionStyle.none
            return cellTop!
            }else {
          if cell == nil {
          cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
              }
                let but = UIButton(type: UIButtonType.custom)
                but.frame = CGRect(x: 10, y: 30, width: SCREENWIDTH-20, height: 40)
                but.titleLabel?.font = fontSize(size: 14)
                but.setTitleColor(UIColor.white, for: UIControlState.normal)
                but.setLayerCornerRadius(20, withWidth: 0, color: nil)
                but.backgroundColor = UIColor.red
                but.addTarget(self, action:#selector(buttonClick), for: UIControlEvents.touchUpInside)
                but.setTitle("退出登录", for: UIControlState.normal)
                cell?.contentView.backgroundColor = lightColor
                cell?.contentView.addSubview(but)
                cell?.selectionStyle = UITableViewCellSelectionStyle.none
                 return cell!
            }
            
            
            
        }
        
    func buttonClick() {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.view.makeToastActivityWithMessage(message: "")
        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.view.hideToastActivity()
        }
        let v = LoginViewController()
        let navIndex = UINavigationController(rootViewController: v)
        self.present(navIndex,animated:true,completion:nil)
    }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
     let orderList =   MyOrderListViewController()
//     orderList.topImage = shadowImage
     orderList.title = "订单列表"
        self.navigationController?.pushViewController(orderList, animated: true)
   
    break
    case 1:
        let addressList =   MyAddressListViewController()
        addressList.title = "收货地址"
        self.navigationController?.pushViewController(addressList, animated: true)
        
        break
    case 2:
        
        let couponList =   CouponListViewController()
        couponList.title = "优惠券"
        self.navigationController?.pushViewController(couponList, animated: true)
        
        break
    case 3:
        
        let about =  AboutUsViewController()
        about.title = "关于我们"
        self.navigationController?.pushViewController(about, animated: true)
        
        break
    default:
        break

    }
       
    }

    func setNavAlpha(_ alpha: CGFloat) {
        //1.没有效果
//        navigationController?.navigationBar.alpha = alpha
        //2. 没有效果
        //        navigationController?.navigationBar.barTintColor = UIColor(red: 223.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: alpha)
        //3. 动态更改背景图片的alpha
        //        let image = drawImageFromColor(UIColor.redColor().colorWithAlphaComponent(alpha), size: CGSize(width: view.bounds.width, height: 64.0))
        //        navigationController?.navigationBar.setBackgroundImage(image, forBarMetrics: .Default)
        
        //4.改变添加的view的alpha
        navigationController?.navigationBar.subviews.first?.alpha = alpha
        headerImageViewNew?.alpha = alpha
       
        
//        navigationController?.zj_setBackgroundColor(blueColor, alpha: alpha)
    }

    override func viewWillAppear(_ animated: Bool) {
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
//        navigationController?.navigationBar.subviews.first?.alpha = 0.0
//        self.navigationController?.navigationBar.isHidden = false
        
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationBar!.showCustomNavigationBar(true)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        
        
//        let offsetY = CGFloat((tableView?.contentOffset.y)!)
//
//        if (offsetY <= 0.0){
        
//            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
//        } else {
//
//            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
//
//        }
        
        
    }
//
    override func viewWillDisappear(_ animated: Bool) {
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
//        navigationController?.navigationBar.subviews.first?.alpha = 1.0
//        self.navigationController?.navigationBar.isHidden = false
        
        
    }

    
    
    
    
    
    class func scanBigImage(with currentImageview: UIImageView, alpha: CGFloat) {
        //  当前imageview的图片
        let image: UIImage? = currentImageview.image
        //  当前视图
        let window: UIWindow? = UIApplication.shared.keyWindow
        //  背景
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        //  当前imageview的原始尺寸->将像素currentImageview.bounds由currentImageview.bounds所在视图转换到目标视图window中，返回在目标视图window中的像素值
        oldframe = currentImageview.convert(currentImageview.bounds, to: window)
        backgroundView.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: alpha)
        //  此时视图不会显示
        backgroundView.alpha = 0
        //  将所展示的imageView重新绘制在Window中
        let imageView = UIImageView(frame: oldframe!)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tag = 1024
        backgroundView.addSubview(imageView)
        //  将原始视图添加到背景视图中
        window?.addSubview(backgroundView)
        
        
        
        //  添加点击事件同样是类方法 -> 作用是再次点击回到初始大小
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideImageView(withTap:)))
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
        
        //  动画放大所展示的ImageView
        UIView.animate(withDuration: 0.4, animations: {() -> Void in
            var y: CGFloat
            var width: CGFloat
            var height: CGFloat
            y = (UIScreen.main.bounds.size.height - (image?.size.height)! * UIScreen.main.bounds.size.width / (image?.size.width)!) * 0.5
            //宽度为屏幕宽度
            width = UIScreen.main.bounds.size.width
            //高度 根据图片宽高比设置
            height = (image?.size.height)! * UIScreen.main.bounds.size.width / (image?.size.width)!
            imageView.frame = CGRect(x: 0, y: y, width: width, height: height)
            //重要！ 将视图显示出来
            backgroundView.alpha = 1
        }, completion: {(_ finished: Bool) -> Void in
        })
        
    }

    
    // MARK: - UITableView
    /**
     *  恢复imageView原始尺寸
     *
     *  @param tap 点击事件
     */
    
    class func hideImageView(withTap: UITapGestureRecognizer) {
        let backgroundView: UIView? = withTap.view
        //  原始imageview
        let imageView: UIImageView? = withTap.view?.viewWithTag(1024) as? UIImageView
        //  恢复
        UIView.animate(withDuration: 0.4, animations: {() -> Void in
            imageView?.frame = oldframe!
            backgroundView?.alpha = 0
        }, completion: {(_ finished: Bool) -> Void in
            //完成后操作->将背景视图删掉
            backgroundView?.removeFromSuperview()
        })
    }

    
   func showImageView(withTap: UITapGestureRecognizer) {
       MySelfViewController.scanBigImage(with: iconNew!, alpha: 1.0)
    }

    
}
