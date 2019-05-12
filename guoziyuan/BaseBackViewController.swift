//
//  BaseBackViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/11/2.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class BaseBackViewController: BaseViewController {

    
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
setLeftButtonItemBackWith(UIImage(named: "new_back")!, tintColor: darkColor)
        // Do any additional setup after loading the view.
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
