//
//  FSScrollContentViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class OrderViewController: BaseBackViewController ,UITableViewDelegate,UITableViewDataSource,DateTimePickerViewDelegate{
    var tableView:UITableView?
    var vcCanScroll:Bool = false
    var fingerIsTouch:Bool = false
    
    var isTableViewLoadData: Bool = false
    var topImage:UIImage?
    
    let identifier:String = "OrderHeadTableViewCell"
   let identifierTwo:String = "OrderAddressTableViewCell"
    
    let identifierthree:String = "MessageTitleViewCell"
    let identifierfore:String = "OrderTitleViewCell"
    var isFromeShop:Bool = false //是否是实体店家
     var cellTopType:OrderTitleViewCell?
    var cellTopTime:OrderTitleViewCell?
    
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
        let nibtwo:UINib = UINib.init(nibName: identifierTwo, bundle: nil)
        tableView?.register(nibtwo, forCellReuseIdentifier: identifierTwo)
        
        let nibthree:UINib = UINib.init(nibName: identifierthree, bundle: nil)
        tableView?.register(nibthree, forCellReuseIdentifier: identifierthree)
        
        
        let nibfore:UINib = UINib.init(nibName: identifierfore, bundle: nil)
        tableView?.register(nibfore, forCellReuseIdentifier: identifierfore)
        
        
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
            
            
            
           
                
                for j in 0...6 {
                    
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
        
        return self.isTableViewLoadData ? 7 : 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
            
        case 1:
            return 70
            
        case 6:
            return 100
            
            
        default:
            return 50
           
        }
      
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
                 var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                   if cell == nil {
                     cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
                                }
//                  cell?.textLabel?.text = self.title
        
        
        
        if indexPath.row == 0 {
            var cellTop:OrderHeadTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? OrderHeadTableViewCell
            //        cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
            
            if cellTop == nil {
                cellTop = OrderHeadTableViewCell(style: .default, reuseIdentifier: identifier)
            }
            cellTop.selectionStyle = UITableViewCellSelectionStyle.none
            return cellTop!
        }else if indexPath.row == 1{
            var cellToptwo:OrderAddressTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifierTwo) as? OrderAddressTableViewCell
            //        cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
            
            if cellToptwo == nil {
                cellToptwo = OrderAddressTableViewCell(style: .default, reuseIdentifier: identifierTwo)
            }
            cellToptwo.selectionStyle = UITableViewCellSelectionStyle.none
            return cellToptwo!
        }else if indexPath.row == 2{
            var cellTopthree:MessageTitleViewCell! = tableView.dequeueReusableCell(withIdentifier: "MessageTitleViewCell") as? MessageTitleViewCell
            //        cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
            
            if cellTopthree == nil {
                cellTopthree = MessageTitleViewCell(style: .default, reuseIdentifier: "MessageTitleViewCell")
            }
            cellTopthree.selectionStyle = UITableViewCellSelectionStyle.none
            return cellTopthree!
        }else if indexPath.row == 3{
            var cellTopfive:OrderTitleViewCell! = tableView.dequeueReusableCell(withIdentifier: "OrderTitleViewCell") as? OrderTitleViewCell
            //        cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
            
            if cellTopfive == nil {
                cellTopfive = OrderTitleViewCell(style: .default, reuseIdentifier: "OrderTitleViewCell")
            }
            cellTopfive.titleLabel.text = "优惠券"
            cellTopfive.detailTextField.text = "2张"
            cellTopfive.detailTextField.textColor = UIColor.red
            cellTopfive.selectionStyle = UITableViewCellSelectionStyle.none
            return cellTopfive!
        }else if indexPath.row == 4{
            cellTopType = tableView.dequeueReusableCell(withIdentifier: "OrderTitleViewCell") as? OrderTitleViewCell
            //        cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
            
            if cellTopType == nil {
                cellTopType = OrderTitleViewCell(style: .default, reuseIdentifier: "OrderTitleViewCell")
            }
            cellTopType?.selectionStyle = UITableViewCellSelectionStyle.none
            return cellTopType!
        }else if indexPath.row == 5{
            cellTopTime = tableView.dequeueReusableCell(withIdentifier: "OrderTitleViewCell") as? OrderTitleViewCell
            //        cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
            
            if cellTopTime == nil {
                cellTopTime = OrderTitleViewCell(style: .default, reuseIdentifier: "OrderTitleViewCell")
            }
            cellTopTime?.labelLine.isHidden = true
            cellTopTime?.titleLabel.text = "送货时间"
            cellTopTime?.detailTextField.text = "请选择送(取)货时间"
            cellTopTime?.selectionStyle = UITableViewCellSelectionStyle.none
            return cellTopTime!
        }else if indexPath.row == 6{
          
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
            but.setTitle("确认订单", for: UIControlState.normal)
            cell?.contentView.backgroundColor = lightColor
            cell?.contentView.addSubview(but)
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            return cell!
       

  
        }

       return cell!
        
        
    }
    
func buttonClick() {
    
//    self.view.makeToastActivityWithMessage(message: "下单成功，请到个人中心里面查看我的订单")
    let delay = DispatchTime.now() + .seconds(2)
    self.view.makeToast(message: "下单成功，请到个人中心里面查看我的订单")
    DispatchQueue.main.asyncAfter(deadline: delay) {
//        self.view.hideToastActivity()
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let address = MyAddressListViewController()
            address.title = "收货地址"
            self.navigationController?.pushViewController(address, animated: true)
        }else if indexPath.row == 3{
            let coupon = CouponListViewController()
            coupon.title = "选择优惠券"
            self.navigationController?.pushViewController(coupon, animated: true)
        }else if indexPath.row == 4{
            if self.isFromeShop {
                LEEAlert.alert().config.leeTitle("请选择收货方式")?.leeAction("快递送货", {() -> Void in
                    // 点击事件Block
                    self.cellTopType?.detailTextField.text = "快递送货"
                })?.leeDestructiveAction("到店取货", {() -> Void in
                    // 点击事件Block
                    print("23453412345432")
                    self.cellTopType?.detailTextField.text = "到店取货"
                })?.leeCancelAction("取消", {() -> Void in
                    // 点击事件Block
                })?.leeShow()

            }
            
        }else if indexPath.row == 5{
            let pickerView = DateTimePickerView()
//            datePickerView = pickerView
            pickerView.delegate = self
            pickerView.pickerViewMode = DatePickerViewDateTimeMode
            view.addSubview(pickerView)
            pickerView.show()
        }

    }
    func didClickFinishDateTimePickerView(_ date: String) {
      cellTopTime?.detailTextField.text = date
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
