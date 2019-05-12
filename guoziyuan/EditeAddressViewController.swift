//
//  MySelfViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/20.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class EditeAddressViewController: BaseBackViewController ,UITableViewDelegate,UITableViewDataSource,XFAreaPickerViewDelegate,UITextFieldDelegate{
//    var headerImageViewNew:NNPersonalHomePageHeaderImageView?
//    var dynamicTableView:NNContentTableView?
//    var scrollViewNew:NNContentScrollView?
    
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
    let  kNavigationBarHeight:CGFloat = 44
    let  kStatusBarHeight:CGFloat = 20
    var headerImgHeight:CGFloat = 200
    var iconHeight:CGFloat = 60
    var backViews:UIImageView?
    let identifier:String = "AddressTableViewCell"
    var isTableViewLoadData: Bool = false
    var shadowImage:UIImage?
    
    var name:AddressTableViewCell?
    var telephone:AddressTableViewCell?
    var city:AddressTableViewCell?
    var address:AddressTableViewCell?
    var isDefault:Bool = false
    //索引数组
    private lazy var titleDateSource : NSArray = {
        let list:[String] = ["收  件  人","手  机  号","收货地区","详细地址","设为默认地址"]
        return list as NSArray
    }()
    
    private lazy var detailDateSource : NSArray = {
        let list:[String] = ["请输入您的姓名","请填写您的手机号码","请选择省市区","请填写收货详细地址","设为默认地址"]
        return list as NSArray
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.gray
        
        
        setupSubViews()
        
        
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func setupSubViews() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: SCREENHEIGHT), style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
 
        let nib:UINib = UINib.init(nibName: identifier, bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: identifier)
        tableView?.backgroundColor = lightColor

        tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        
        name = tableView?.dequeueReusableCell(withIdentifier: identifier) as? AddressTableViewCell
        telephone = tableView?.dequeueReusableCell(withIdentifier: identifier) as? AddressTableViewCell
        city = tableView?.dequeueReusableCell(withIdentifier: identifier) as? AddressTableViewCell
        address = tableView?.dequeueReusableCell(withIdentifier: identifier) as? AddressTableViewCell
        
        view.addSubview(self.tableView!)

        
        GCDQueue.execute(inMainQueue: {() -> Void in
            var indexPaths = [IndexPath]()
            self.isTableViewLoadData = true
            
            
            //                for i in 0...7 {
            
            for j in 0...5 {
                
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
    
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.isTableViewLoadData ? 6 : 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == titleDateSource.count {
            return 80
        }
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if indexPath.row < titleDateSource.count {
        
            
            
            var cellTop:AddressTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddressTableViewCell
            cellTop.setIndex(dex: indexPath.row)
            cellTop.titleLabel?.text = titleDateSource[indexPath.row] as? String
            cellTop.detailTextField?.placeholder = detailDateSource[indexPath.row] as? String
            if cellTop == nil {
                cellTop = AddressTableViewCell(style: .default, reuseIdentifier: identifier)
            }
            if  indexPath.row == 0{
                cellTop.detailTextField?.isEnabled = true
                name = cellTop
            }else if  indexPath.row == 1{
                cellTop.detailTextField?.isEnabled = true
                cellTop.detailTextField?.keyboardType = UIKeyboardType.numberPad
                telephone = cellTop
                telephone?.detailTextField?.delegate = self
                telephone?.detailTextField?.tag = 6666
            }else if  indexPath.row == 2{
               cellTop.detailTextField?.isEnabled = false
                city = cellTop
            }else if  indexPath.row == 3{
                cellTop.detailTextField?.isEnabled = true
                address = cellTop
            }
           
            if indexPath.row == 4{
                cellTop.detailTextField?.isEnabled = true
                cellTop.switchNow?.isHidden = false
                cellTop.detailTextField?.isHidden = true
                cellTop.lineLabel?.isHidden = true
            }else{
               cellTop.switchNow?.isHidden = true
                cellTop.detailTextField?.isHidden = false
                cellTop.lineLabel?.isHidden = false
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
            but.setTitle("保存", for: UIControlState.normal)
            cell?.contentView.backgroundColor = lightColor
            cell?.contentView.addSubview(but)
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            return cell!
        }
        
        
        
    }
    
    func buttonClick() {
        if name?.detailTextField?.text == "" {
            self.view.makeToast(message: "请输入手机人")
            return
        }
        if telephone?.detailTextField?.text == "" {
            self.view.makeToast(message: "请输入手机号")
            return
        }
        if city?.detailTextField?.text == "" {
            self.view.makeToast(message: "请选择收货地区")
            return
        }
        if address?.detailTextField?.text == "" {
            self.view.makeToast(message: "请输入收货详细地址")
            return
        }
        if !isPureInt((telephone?.detailTextField?.text)!) || telephone?.detailTextField?.text?.characters.count != 11 {
            self.view.makeToast(message: "您输入的手机号格式或位数不对")
            return
        }
        self.view.makeToastActivityWithMessage(message: "")
        let delay = DispatchTime.now() + .seconds(2)
        self.view.makeToast(message: "地址保存成功")
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.view.hideToastActivity()
            self.navigationController?.popViewController(animated: true)
        }
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        name?.detailTextField?.resignFirstResponder()
        telephone?.detailTextField?.resignFirstResponder()
        address?.detailTextField?.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 2{
            name?.detailTextField?.resignFirstResponder()
            telephone?.detailTextField?.resignFirstResponder()
            address?.detailTextField?.resignFirstResponder()
//           PickViewController().chooseCity()
//            PickViewController().click = {(arr)->Void in
//            }
//            FYLCityPickView().show(withDefaultProvince: "河南", complete: {(_ arr: [Any]) -> Void in
//            } as! FYLCityBlock)
            
            let areaPicker = XFAreaPickerView(delegate: self)
            areaPicker?.isHidden = false
            
            
        }
    }
    
    func areaPickerView(_ areaPickerView: XFAreaPickerView, didSelectArea area: [Any]) {
//        txt.text = area
//        print("12345===\(area)")
        city?.detailTextField?.text = "\(area[0]) \(area[1]) \(area[2])"
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            return true
        }
        let toBeString: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        //得到输入框的内容
        if textField.tag == 6666 {
            if toBeString.characters.count > 11 {
                //如果输入框内容大于20则弹出警告
                textField.text = toBeString.substring(to: (textField.text?.endIndex)!)
//                self.view.showToast(toast: "手机号不能超过11位")
//                let delay = DispatchTime.now() + .seconds(2)
                self.view.makeToast(message: "手机号不能超过11位")
//                DispatchQueue.main.asyncAfter(deadline: delay) {
//                    //        self.view.hideToastActivity()
//                    
//                    self.navigationController?.popViewController(animated: true)
//                }
//                let hud = MBProgressHUD.showAdded(to: view, animated: true)
//                hud.mode = MBProgressHUDModeText
//                hud.labelText = "手机号不能超过11位"
//                hud.hide(true, afterDelay: 1)
                 return false
            }
        }
        return true
    }

    
    func isPureInt(_ string: String) -> Bool {
        let ns2=(string as NSString).substring(to: 1)
        if  ns2 == "1"{
            return true
        }
        return false
    }
    
    
}
