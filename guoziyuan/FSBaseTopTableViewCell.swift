//
//  FSBaseTopTableViewCell.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class FSBaseTopTableViewCell: UITableViewCell,UIAlertViewDelegate{

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
            
            let loopViews:FSLoopScrollView = FSLoopScrollView.loopImageView(withFrame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 200), isHorizontal: true)
            loopViews.imgResourceArr = ["http://img02.tooopen.com/images/20160316/tooopen_sy_156105468631.jpg",
                                       "http://img02.tooopen.com/images/20160316/tooopen_sy_156105468631.jpg",
                                       "http://img02.tooopen.com/images/20160316/tooopen_sy_156105468631.jpg",
                                       "http://img02.tooopen.com/images/z20160316/tooopen_sy_156105468631.jpg",
                                       "http://img02.tooopen.com/images/20160316/tooopen_sy_156105468631.jpg"];
//            loopView.tapClickBlock = {(_ loopView:FSLoopScrollView) -> Void in
//                let alert = UIAlertView(title: "大顺啊", message: "老：\(loopView.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "")
//                alert.show()
//                }
//        
//        loopView.tapClickBlock = {(_ loopView: FSLoopScrollView) -> Void in
//        } as! (FSLoopScrollView?) -> Void
        
        loopViews.tapClickBlock = {(loopView)-> Void in
        let alert = UIAlertView(title: "大顺啊", message: "老：\(loopViews.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "")
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
