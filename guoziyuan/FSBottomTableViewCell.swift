//
//  FSBaseTopTableViewCell.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class FSBottomTableViewCell: UITableViewCell,UIAlertViewDelegate{

    
    var pageContentView:FSPageContentView?
    var viewControllers = [FSScrollContentViewController]()
    var isCellCanScroll:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  
    }

    func setViewControllers(viewController: [FSScrollContentViewController]) {
        viewControllers = viewController
    }
    func setIsCellCanScroll(isCell:Bool) {
        isCellCanScroll = isCell
        for VC: FSScrollContentViewController in viewControllers {
            VC.vcCanScroll = isCellCanScroll
            if !isCellCanScroll {
                //如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
                VC.tableView?.contentOffset = CGPoint.zero
            }
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
//            print("1234345")
//            let loopViews:FSLoopScrollView = FSLoopScrollView.loopImageView(withFrame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 200), isHorizontal: true)
//            loopViews.imgResourceArr = ["http://img05.tooopen.com/images/20150202/sy_80219211654.jpg",
//                                       "http://img06.tooopen.com/images/20161123/tooopen_sy_187628854311.jpg",
//                                       "http://img07.tooopen.com/images/20170306/tooopen_sy_200775896618.jpg",
//                                       "http://img06.tooopen.com/images/20170224/tooopen_sy_199503612842.jpg",
//                                       "http://img02.tooopen.com/images/20160316/tooopen_sy_156105468631.jpg"];
//            loopView.tapClickBlock = {(_ loopView:FSLoopScrollView) -> Void in
//                let alert = UIAlertView(title: "大顺啊", message: "老：\(loopView.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "")
//                alert.show()
//                }
//        
//        loopView.tapClickBlock = {(_ loopView: FSLoopScrollView) -> Void in
//        } as! (FSLoopScrollView?) -> Void
        
//        loopViews.tapClickBlock = {(loopView)-> Void in
//        let alert = UIAlertView(title: "大顺啊", message: "老：\(loopViews.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "")
//         alert.show()
//        }
//        
//            self.contentView.addSubview(loopViews)
       
        
    }
//
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
