//
//  AddressTableViewCell.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/9/2.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit
import pop
class AddressTableViewCell: UITableViewCell {
    var index:NSInteger?
    @IBOutlet weak var titleLabel:UILabel?
    @IBOutlet weak var detailTextField:UITextField?
    
    @IBOutlet weak var switchNow:UISwitch?
    @IBOutlet weak var height:NSLayoutConstraint?
    @IBOutlet weak var lineLabel:UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lineLabel?.backgroundColor = lightColor
        height?.constant = LINEHEIGHT
        titleLabel?.textColor = blackColor
    }
    func setIndex(dex:NSInteger) {
        index = dex
        //       label?.text = "葡萄"+"\(String(describing: index))"
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        
        if highlighted {
            let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            scaleAnimation?.duration = 0.1
            scaleAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 0.95, y: 0.95))
            titleLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
            //        icon?.pop_add(scaleAnimation, forKey: "scaleAnimation")
            //        detailLable?.pop_add(scaleAnimation, forKey: "scaleAnimation")
            //        moneyLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
            //        numberLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
            
        }
        else {
            
            let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            scaleAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
            scaleAnimation?.velocity = NSValue(cgPoint: CGPoint(x: 2, y: 2))
            scaleAnimation?.springBounciness = 20.0
            titleLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
            //        icon?.pop_add(scaleAnimation, forKey: "scaleAnimation")
            //        detailLable?.pop_add(scaleAnimation, forKey: "scaleAnimation")
            //        moneyLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
            //        numberLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
