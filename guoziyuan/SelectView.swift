//
//  SelectView.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/9/1.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class SelectView: UIView {
    
    @IBOutlet var makeOrderButton:UIButton?
    @IBOutlet var carMakeOrderButton:UIButton?
    
    @IBOutlet var deButton:UIButton?
    
    @IBOutlet var addButton:UIButton?
    @IBOutlet var goodsNumberNow:UITextField?
    
    
    var clickAction: (() -> Void)? = nil
    
    var carClickAction: (() -> Void)? = nil
    
    
    var addAction: (() -> Void)? = nil
    
    var deAction: (() -> Void)? = nil
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func mackOrder(){
        clickAction!()
    }
    
    @IBAction func carMackOrder(){
        carClickAction!()
    }
    
    @IBAction func add(){
        addAction!()
    }
    
    @IBAction func derenum(){
        deAction!()
    }
}
