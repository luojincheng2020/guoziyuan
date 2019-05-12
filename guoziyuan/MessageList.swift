//
//  IndexTableViewCell.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/25.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit
import pop
class MessageList: UITableViewCell {
    var index:NSInteger?
    @IBOutlet weak var titleLabel:UILabel?
    @IBOutlet weak var lefticon:UIImageView?
    @IBOutlet weak var righticon:UIImageView?
    @IBOutlet weak var bigicon:UIImageView?
  
    
    @IBOutlet weak var detailLable:UILabel?
    @IBOutlet weak var moneyLabel:UILabel?
    @IBOutlet weak var numberLabel:UILabel?
    
    @IBOutlet weak var height:NSLayoutConstraint?
    @IBOutlet weak var lineLabel:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      lineLabel?.backgroundColor = lightColor
      height?.constant = LINEHEIGHT
        
    }
    
    func setIndex(dex:NSInteger) {
        index = dex
        if index!%2==0 {
            bigicon?.isHidden = true
            lefticon?.isHidden = false
            righticon?.isHidden = false
        }else{
            bigicon?.isHidden = false
            lefticon?.isHidden = true
            righticon?.isHidden = true
        }
//       label?.text = "葡萄"+"\(String(describing: index))"
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        print("1234345")
//        let loopViews:FSLoopScrollView = FSLoopScrollView.loopImageView(withFrame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 200), isHorizontal: true)
//        loopViews.imgResourceArr = ["http://img05.tooopen.com/images/20150202/sy_80219211654.jpg",
//                                    "http://img06.tooopen.com/images/20161123/tooopen_sy_187628854311.jpg",
//                                    "http://img07.tooopen.com/images/20170306/tooopen_sy_200775896618.jpg",
//                                    "http://img06.tooopen.com/images/20170224/tooopen_sy_199503612842.jpg",
//                                    "http://img02.tooopen.com/images/20160316/tooopen_sy_156105468631.jpg"];
//        //            loopView.tapClickBlock = {(_ loopView:FSLoopScrollView) -> Void in
//        //                let alert = UIAlertView(title: "大顺啊", message: "老：\(loopView.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "")
//        //                alert.show()
//        //                }
//        //
//        //        loopView.tapClickBlock = {(_ loopView: FSLoopScrollView) -> Void in
//        //        } as! (FSLoopScrollView?) -> Void
//        
//        loopViews.tapClickBlock = {(loopView)-> Void in
//            let alert = UIAlertView(title: "大顺啊", message: "老：\(loopViews.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "")
//            alert.show()
//        }
//        
//        self.contentView.addSubview(loopViews)
        
        
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//    }
    
    //    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    //
    //    }
    //
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
