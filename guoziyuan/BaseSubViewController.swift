//
//  BaseViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/22.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class BaseSubViewController: BaseViewController {

    func setLeftButtonItemBackWith(_ image: UIImage, tintColor: UIColor) {
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(back))
        item.tintColor = tintColor
        navigationItem.leftBarButtonItem = item
    }
    func back(){
     self.navigationController?.popViewController(animated: true)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setTitleColor(color: blackColor, font: fontSize(size: 16))
//         setLeftButtonItemBackWith(UIImage(named: "new_back")!, tintColor: darkColor)
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.barTintColor = UIColor.green

        // Do any additional setup after loading the view.
        
        
        

        
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
//        navigationBar?.setLeftItemImage("new_back")
//        navigationBar?.clickLeftItemBlock = {() -> Void in
//            self.navigationController?.popViewController(animated: true)
//            //            #selector(IndexViewController.cityClick)
//        }
//        navigationBar?.clickRightItemBlock = {() -> Void in
//            //            self.navigationController?.pushViewController(SecondViewController() as? UIViewController ?? UIViewController(), animated: true)
//        }
    }
    //设置导航条上的字体颜色和大小:
//    func setTitleColor(color:UIColor!,font:UIFont!) {
////        if ((color === nil) && (font === nil)) {
////            return
////        }
//        var dict = [AnyHashable:Any]()
//        if (color != nil) {
//        dict[NSForegroundColorAttributeName] = color
//        }
//        if font != nil {
//            dict[NSFontAttributeName] = font
//        }
//        
//        self.navigationController?.navigationBar.titleTextAttributes = dict as? [String : Any];
//        
//    }
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
