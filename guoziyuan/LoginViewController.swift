//
//  LoginViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/22.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit
class LoginViewController: BaseViewController,UITextFieldDelegate {
//   @IBOutlet weak var secrectButton: UIButton!
//    @IBOutlet weak var lineUp:UILabel!
//    @IBOutlet weak var lineDown:UILabel!
    
//    @IBOutlet weak var password:UITextField!
//    @IBOutlet weak var username:UITextField!
    var passwordFiled:XMNAnimTextFiled!
    var usernameFiled:XMNAnimTextFiled!
    static var username:NSString?
    static var password:NSString?
    var _btn:LoadButton!
    
   var dismisButton:UIButton?
    var registButton:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
//        lineUp.frame.size.height = LINEHEIGHT
//        lineDown.frame.size.height = LINEHEIGHT
//        lineUp.backgroundColor = lightColor
//        lineDown.backgroundColor = lightColor
//        edgesForExtendedLayout = [] //去掉偏移的视图效果 iOS7及以后的版本支持，self.view.frame.origin.y会下移64像素至navigationBar下方。
//        navigationController?.navigationBar.barTintColor = UIColor.green

        // Do any additional setup after loading the view.
        
        
       
        
        
        dismisButton = UIButton(type: UIButtonType.custom)
//        dismisButton?.frame = CGRect(x:-10,y:0,width:40,height:30);
        dismisButton?.frame = CGRect(x:0,y:0,width:20,height:30)
        dismisButton?.setImage(UIImage(named: "new_back")!, for: UIControlState.normal)
        dismisButton?.setTitleColor(darkColor, for: UIControlState.normal)

        
        
        //        login?.addTarget(self, action:#selector(buttonClicked(_:)), forControlEvents: UIControlEvents.touchUpInside)
        dismisButton?.addTarget(self,action:#selector(buttonClick(but:)),for:.touchUpInside)
        
        //        login?.addTarget(self,action:Selector("buttonClick"),for:UIControlEvents.touchUpInside)
       
//        self.navigationController?.navigationBar.addSubview(dismisButton!)
         let leftItem = UIBarButtonItem(customView: dismisButton!)
        self.navigationItem.leftBarButtonItem = leftItem
        
//        registButton = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        registButton = UIButton(type: UIButtonType.custom)
        registButton?.frame = CGRect(x:SCREENWIDTH-115,y:0,width:100,height:30);
        registButton?.setTitle("注册", for: UIControlState.normal)
        registButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        registButton?.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        registButton?.setTitleColor(darkColor, for: UIControlState.normal)
        //        login?.addTarget(self, action:#selector(buttonClicked(_:)), forControlEvents: UIControlEvents.touchUpInside)
        let rightItem = UIBarButtonItem(customView: registButton!)
        registButton?.addTarget(self,action:#selector(buttonClick(regist:)),for:.touchUpInside)
        
//                login?.addTarget(self,action:Selector("buttonClick"),for:UIControlEvents.touchUpInside)
        
//        self.navigationController?.navigationBar.addSubview(registButton!)
        self.navigationItem.rightBarButtonItem = rightItem
        
        
        
        
        
        
        usernameFiled = XMNAnimTextFiled(frame: CGRect(x: 60, y: 270, width: SCREENWIDTH - 120, height: 50))
        
        usernameFiled.placeHolderIcon = UIImage(named: "new-name")
        usernameFiled.placeHolderHightlightIcon = UIImage(named: "new-password")
        usernameFiled.placeHolderText = "请输入手机号"
        usernameFiled.textField.keyboardType = UIKeyboardType.numberPad
        
        usernameFiled.textField.textColor = darkColor
        usernameFiled?.textField?.delegate = self
        usernameFiled?.textField?.tag = 6666
        view.addSubview(usernameFiled)
        
        
        
        passwordFiled = XMNAnimTextFiled(frame: CGRect(x: 60, y: 340, width: SCREENWIDTH - 120, height: 50))
        
        passwordFiled.tipsIcon = UIImage(named: "new-hide")
        passwordFiled.placeHolderIcon = UIImage(named: "new-password")
        passwordFiled.placeHolderHightlightIcon = UIImage(named: "new-hide")
        passwordFiled.placeHolderText = "请输入密码"
        passwordFiled.inputType = XMNAnimTextFieldInputType.password
        passwordFiled.textField.textColor = darkColor
        view.addSubview(passwordFiled)
        
        
        
        
        
        
        
        
        _btn = LoadButton(frame: CGRect(x: 60, y: 420, width: SCREENWIDTH - 120, height: 40))
        _btn.setLayerCornerRadius(20, withWidth: 0, color: nil)
        _btn.setBackgroundImage(UIImage(named: "loginback"), for: .normal)
        _btn.setTitle("登录", for: .normal)
        _btn.titleLabel?.textColor = blackColor
        _btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        _btn.setTitleColor(UIColor.white, for: .normal)
        _btn.addTarget(self, action: #selector(buttonClick(loginAnimal:)), for: .touchUpInside)
        view.addSubview(_btn)
        
        
        
        //创造图片按钮：
//        var img=UIImage(named: "test_img")
//        
//        let item3=UIBarButtonItem(image: img, style: UIBarButtonItemStyle.Plain, target: self, action: nil)
//        self.navigationItem.rightBarButtonItem=item3
     
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    
        if (usernameFiled != nil) && (passwordFiled != nil) {
            if LoginViewController.username != nil {
               usernameFiled.textField.text = LoginViewController.username as String?
            }
            if LoginViewController.password != nil {
                passwordFiled.textField.text = LoginViewController.password as String?
            }
        }
    }
    func buttonClick(loginAnimal:LoadButton) {
        
        
    
        
        
//        let pic = "http://59.110.28.229:4444/data/attachment/forum/201705/10/011304db50uduvend999rn.jpg.thumb.jpg"
//        let picUrl = URL(string: pic)
//        
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
//        imageView.frame = CGRect(x: 0, y: 200, width: 150, height: 50)
//        imageView.sd_setImage(withURL: picUrl, completed: {(_ image: UIImage, _ error: Error?, _ cacheType: SDImageCacheType, _ imageURL: URL) -> Void in
//            imageView.image = image
//            print("4444444=====\(image)---")
//        })
//        imageView.sd_setImage(withURL: picUrl)
//        imageView.sd_setImage(with: picUrl!)
//        view.addSubview(imageView)
        
        
        
        
        
        
        
        
        
        
        
        
        if usernameFiled.text! == "" {
         self.usernameFiled.state = XMNAnimTextFieldState.error
            self.view.makeToast(message: "请输入手机号")
          return
        }
        
        
        if passwordFiled.text! == "" {
            self.passwordFiled.state = XMNAnimTextFieldState.error
            self.view.makeToast(message: "请输入密码")
            return
        }
        
        
        self.usernameFiled.state = XMNAnimTextFieldState.normal;
        self.passwordFiled.state = XMNAnimTextFieldState.normal;
        
        
        
        
        
        
        
        if !isPureInt((usernameFiled?.textField.text)!) || usernameFiled?.textField?.text?.characters.count != 11 {
            self.view.makeToast(message: "您输入的手机号格式或位数不对")
            return
        }
        
        loginAnimal.toggle()
        
        
        ///POST 请求  果子园登录接口 
        XMSessionManager.shared.request(Method: XMHTTPMethod.POST,URLString: LOGIN_URL, parameters: ["account":usernameFiled.text as AnyObject,"password":passwordFiled.text as AnyObject,"type":"2" as AnyObject], completed:{(json: AnyObject?,isSuccess: Bool)-> () in
            // 请求成功
            if isSuccess {
                print(json ?? "")
                
////                AppDelegate().showIndexView()
//                
//                
//                let index:IndexViewController = IndexViewController()
                
//                let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                
//                appdelegate.tab?.selectedViewController = appdelegate.tab?.viewControllers?[0]
                print("444444444444======\(json)")
                let dic:NSDictionary = json as! NSDictionary
                if dic["success"] as! Bool == true{
                    MBProgressHUD.showSuccess("登录成功", view: nil)
                   self.dismiss(animated: true, completion: nil)
                }else{
                    
                    let delay = DispatchTime.now() + .seconds(1)
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        self._btn.toggleOver()
                    }
                    
                    MBProgressHUD.showError(dic["message"] as! String, view: nil)
                }
                
//                print("======\(String(describing: appdelegate.tab?.viewControllers?[0]))")
//                self.navigationController?.popToRootViewController(animated: true)
//
            } else {
                
                MBProgressHUD.showError("登录失败，请重试!", view: nil)
                
                        let delay = DispatchTime.now() + .seconds(1)
                        DispatchQueue.main.asyncAfter(deadline: delay) {
                            loginAnimal.toggleOver()
                        }
        
                
                
            }
        })
        
        
        ///POST 请求  测试接口: 这个请求有数据:
//                XMSessionManager.shared.request(Method: XMHTTPMethod.POST,URLString: "http://59.110.28.229:4444/api/mobile/index.php?loginfield=auto&charset=utf-8&version=7&loginsubmit=yes&mobile=no&module=login", parameters: ["username":"会飞的炒锅" as AnyObject,"password":"88888888" as AnyObject,"questionid":"0" as AnyObject,"answer":"" as AnyObject], completed:{(json: AnyObject?,isSuccess: Bool)-> () in
//                    // 请求成功
//                    if isSuccess {
//                        print(json ?? "请求成功====")
//                    } else {
//                        print("请求失败")
//                    }
//                })
        
        //GET 请求
        
        //        XMSessionManager.shared.request(Method: XMHTTPMethod.GET,URLString: "www.guoziyuan.shop/api/member/apiRegister", parameters: ["nickname":"会飞的炒锅" as AnyObject,"password":"88888888" as AnyObject,"mobile":"13222644685" as AnyObject], completed:{(json: AnyObject?,isSuccess: Bool)-> () in
        //            // 请求成功
        //            if isSuccess {
        //                print(json ?? "======")
        //            } else {
        //                print("请求失败")
        //            }
        //        })

        
//                        AppDelegate().showIndexView()
        
        
//        let index:IndexViewController = IndexViewController()
//        
//        AppDelegate().window?.rootViewController = index
//        
        
    }
    
    
    func buttonClick(regist:UIButton) {
      let regist = RegistViewController()
        regist.title = "注册"
      self.navigationController?.pushViewController(regist, animated: true)
        _btn.toggleOver()
        _btn.setLayerCornerRadius(20, withWidth: 0, color: nil)
    }
    func buttonClick(but:UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func lookOrClose(){
//        
//        
//        
//        
//        
//        if passwordFiled.textField.isSecureTextEntry {
//            passwordFiled.textField.isSecureTextEntry = false
//            secrectButton.setImage(UIImage(named:"new-show"), for: UIControlState.normal)
//        }else{
//            passwordFiled.textField.isSecureTextEntry = true
//            secrectButton.setImage(UIImage(named:"new-hide"), for: UIControlState.normal)
//        }
//    }

    
    
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
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameFiled.textField.resignFirstResponder()
        passwordFiled.textField.resignFirstResponder()
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
