//
//  FSBaseTopTableViewCell.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class FSBaselineTableViewCell: UITableViewCell,UIAlertViewDelegate{

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
   
            let loopViews:FSLoopScrollView = FSLoopScrollView.loopTitleView(withFrame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 50), isTitleView: true, titleImgArr:["home_ic_new","home_ic_hot","home_ic_new","home_ic_new","home_ic_hot"])
        loopViews.titlesArr = ["这是一个简易的文字轮播",
        "马陆葡萄",
        "猕猴桃",
        "苹果",
        "香蕉"]
//            loopView.tapClickBlock = {(_ loopView:FSLoopScrollView) -> Void in
//                let alert = UIAlertView(title: "大顺啊", message: "老：\(loopView.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "")
//                alert.show()
//                }
//        
//        loopView.tapClickBlock = {(_ loopView: FSLoopScrollView) -> Void in
//        } as! (FSLoopScrollView?) -> Void
        
        loopViews.tapClickBlock = {(loopView)-> Void in
        let alert = UIAlertView(title: "文字", message: "老：\(loopViews.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "cancle")
         alert.show()
        }
        
            self.contentView.addSubview(loopViews)
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
