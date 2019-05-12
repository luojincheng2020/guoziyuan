//
//  RegistViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/22.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class RegistViewController: BaseBackViewController,UITextFieldDelegate {
    @IBOutlet weak var secrectButton: UIButton!
    @IBOutlet weak var lineUp:UILabel!
    @IBOutlet weak var lineDown:UILabel!
    @IBOutlet weak var lineOne:UILabel!
    @IBOutlet weak var nickname:UITextField!
    @IBOutlet weak var password:UITextField!
    @IBOutlet weak var username:UITextField!
    
    @IBOutlet weak var height1:NSLayoutConstraint!
    @IBOutlet weak var height2:NSLayoutConstraint!
    @IBOutlet weak var height3:NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = [] //去掉偏移的视图效果 iOS7及以后的版本支持，self.view.frame.origin.y会下移64像素至navigationBar下方。

        // Do any additional setup after loading the view.
        
        
        height1.constant = LINEHEIGHT
        height2.constant = LINEHEIGHT
        height3.constant = LINEHEIGHT
        lineUp.backgroundColor = lightColor
        lineDown.backgroundColor = lightColor
        lineOne.backgroundColor = lightColor

        
        username.delegate = self
        username.tag = 6666
   
        
        
        
        
        let _btns = LoadButton(frame: CGRect(x: 60, y: 500-64, width: SCREENWIDTH - 120, height: 40.0))
        _btns.setLayerCornerRadius(20, withWidth: 0, color: nil)
        _btns.setBackgroundImage(UIImage(named: "loginback"), for: .normal)
        _btns.setTitle("注册", for: .normal)
        _btns.titleLabel?.font = fontSize(size: 14)
        _btns.setTitleColor(UIColor.white, for: .normal)
        _btns.addTarget(self, action: #selector(buttonClick(registAnimal:)), for: .touchUpInside)
        view.addSubview(_btns)
        
        
        
        
        
    }
    func buttonClick(registAnimal:LoadButton) {
        
        if nickname.text! == "" {
            self.view.makeToast(message: "请输入您的昵称")
            return
        }
        if username.text! == "" {
            self.view.makeToast(message: "请输入手机号")
            return
        }
        
        
        if password.text! == "" {
            self.view.makeToast(message: "请输入密码")
            return
        }
       
        
        
        if !isPureInt((username?.text)!) || username?.text?.characters.count != 11 {
            self.view.makeToast(message: "您输入的手机号格式或位数不对")
            return
        }
        
         registAnimal.toggle()
        ///POST 请求
        XMSessionManager.shared.request(Method: XMHTTPMethod.POST,URLString: REGISTER_URL, parameters: ["mobile":username.text as AnyObject,"password":password.text as AnyObject,"nickname":nickname.text as AnyObject], completed:{(json: AnyObject?,isSuccess: Bool)-> () in

            // 请求成功
            if isSuccess {
                print("ddd===\(String(describing: json))")
                
                
                let dic:NSDictionary = json as! NSDictionary
                if dic["success"] as! Bool == true{
//                    MBProgressHUD.showSuccess("注册成功,即将为你登录", view: nil)
                    
                    
                    
                    ///POST 请求  果子园登录接口
                    XMSessionManager.shared.request(Method: XMHTTPMethod.POST,URLString: LOGIN_URL, parameters: ["account":self.username.text as AnyObject,"password":self.password.text as AnyObject,"type":"2" as AnyObject], completed:{(json: AnyObject?,isSuccess: Bool)-> () in
                        // 请求成功
                        if isSuccess {
                            print("xxxx\(String(describing: json))")
                            
                            //                AppDelegate().showIndexView()
                            
                            
//                                            let index:IndexViewController = IndexViewController()
//                            
//                                            let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                            
//                                            appdelegate.tab?.selectedViewController = appdelegate.tab?.viewControllers?[0]
                            
                            let dic:NSDictionary = json as! NSDictionary
                            if dic["success"] as! Bool == true{
                                MBProgressHUD.showSuccess("注册成功，已为你登录", view: nil)
                                self.dismiss(animated: true, completion: nil)
//                                LoginViewController.username = self.username.text as NSString?
//                                LoginViewController.password = self.password.text as NSString?
//                                self.navigationController?.popViewController(animated: true)
                                
//                                let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                                
//                                appdelegate.tab?.selectedViewController = appdelegate.tab?.viewControllers?[4]
                                
                            }else{
//                                self.dismiss(animated: true, completion: nil)
                                self.navigationController?.popViewController(animated: true)
//                                let delay = DispatchTime.now() + .seconds(1)
//                                DispatchQueue.main.asyncAfter(deadline: delay) {
//                                    registAnimal.toggleOver()
//                                }
                                
                                MBProgressHUD.showError(dic["message"] as! String, view: nil)
                            }
                            
                            
                            
//                                            let index:IndexViewController = IndexViewController()
                            
                            
                            
                            
                            //                print("======\(String(describing: appdelegate.tab?.viewControllers?[0]))")
                            //                self.navigationController?.popToRootViewController(animated: true)
                            //
                        } else {
//                            self.dismiss(animated: true, completion: nil)
                            self.navigationController?.popViewController(animated: true)
                            MBProgressHUD.showError("登录失败，请重试!", view: nil)
                            
//                            let delay = DispatchTime.now() + .seconds(1)
//                            DispatchQueue.main.asyncAfter(deadline: delay) {
//                                registAnimal.toggleOver()
//                            }
                            
                            
                            
                        }
                    })

                    
                    
                    
                }else{
                    
                    let delay = DispatchTime.now() + .seconds(1)
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        registAnimal.toggleOver()
                    }
                    
                    MBProgressHUD.showError(dic["message"] as! String, view: nil)
                }
                
                
            } else {
                MBProgressHUD.showError("注册失败，请重试!", view: nil)
                let delay = DispatchTime.now() + .seconds(1)
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    registAnimal.toggleOver()
                }
            }
        })
    }
    
    
    @IBAction func lookOrClose(){
        if password.isSecureTextEntry {
            password.isSecureTextEntry = false
            secrectButton.setImage(UIImage(named:"new-show"), for: UIControlState.normal)
        }else{
            password.isSecureTextEntry = true
            secrectButton.setImage(UIImage(named:"new-hide"), for: UIControlState.normal)
        }
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
//                self.view.handleToastTapped(recognizer: UITapGestureRecognizer())
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
        nickname.resignFirstResponder()
        password.resignFirstResponder()
        username.resignFirstResponder()
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
