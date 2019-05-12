//
//  BaseViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/22.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var HUD:MBProgressHUD?
    var navigationBar:XYQNavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleColor(color: blackColor,font: UIFont.boldSystemFont(ofSize: 16))
        

        // add
//        view.addSubview(navigationBar!)
        
        
        
        
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.barTintColor = UIColor.green

        // Do any additional setup after loading the view.
    }
    
    func creatNav() {
        navigationBar = XYQNavigationBar.createCustom()
        //    [self.navigationBar setDefalut];
        //update（此处可以自由改变导航栏的属性值）
        //        navigationBar.title = "自定义导航栏"
        //block
        //        weak var weakSelf: ARKitSampleViewController? = self
        
//        navigationBar?.clickLeftItemBlock = {() -> Void in
//            self.navigationController?.popViewController(animated: true)
//        }
//        navigationBar?.clickRightItemBlock = {() -> Void in
//            //            weakSelf?.navigationController?.pushViewController(SecondViewController() as? UIViewController ?? UIViewController(), animated: true)
//        }
        
        
        

        
//        
        view.addSubview(navigationBar!)
       
    }
    func showCustomLoadAnimate(_ view: UIView) {
        HUD = MBProgressHUD.showCustomAnimate("", imageName: "dropdown_anim__", imageCounts: 60, view: view)
      
    }
   func hiddenCustomView(){
    //延迟3秒模仿加载
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
    self.HUD?.hide(true)
    })
    }
    

    //设置导航条上的字体颜色和大小:
    func setTitleColor(color:UIColor!,font:UIFont!) {
//        if ((color === nil) && (font === nil)) {
//            return
//        }
        
        var dict = [AnyHashable:Any]()
        if (color != nil) {
        dict[NSForegroundColorAttributeName] = color
        }
        if font != nil {
            dict[NSFontAttributeName] = font
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [String : Any];
    
        
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
