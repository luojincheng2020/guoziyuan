//
//  IndexTableViewCell.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/25.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//
/*订单列表*/
import UIKit
import pop
class OrderListOld: UITableViewCell {
    var index:NSInteger?
    
    var dicBuy:NSDictionary?
    var dic:NSDictionary?
    @IBOutlet weak var titleLabel:UILabel?
    @IBOutlet weak var icon:UIImageView?
    @IBOutlet weak var coverBtn:UIButton?
    @IBOutlet weak var moneyLabel:UILabel?
    @IBOutlet weak var timeLabel:UILabel?
    @IBOutlet weak var typeLabel:UILabel?
    @IBOutlet weak var lineLabel:UILabel?
    var clickAction: ((_ index:NSInteger) -> Void)? = nil
    var haveAction: ((_ index:NSInteger) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      lineLabel?.backgroundColor = lightColor
    coverBtn?.setLayerCornerRadius(13, withWidth: 1, color: greenColor)
        coverBtn?.setTitleColor(greenColor, for: UIControlState.normal)
        self.icon?.setLayerCornerRadius(4, withWidth: 0, color: nil)
    }
    @IBAction func clickPay(button:UIButton){
        if button.titleLabel?.text! == "立即付款" {
           self.clickAction?(self.index!)
        }else{
            self.haveAction?(self.index!)
        }
        
    }
    func setDic(diction:NSDictionary) {
        dic = diction
//            {
//                ActualAmount = "55.55";
//                BillId = "<null>";
//                ChannelCode = "<null>";
//                ChannelName = "<null>";
//                CommitDate = "<null>";
//                CommitStatus = 0;
//                CreatedDate = "2018-02-06 23:29:31";
//                DbOperateType = 0;
//                ExchangeAmount = "55.55";
//                GoodsName = "<null>";
//                Id = dd79e108ab80466eb1f295c43b71ef00;
//                InvoiceId = "<null>";
//                InvoiceStatus = "-1";
//                IsDeleted = 0;
//                IsSuspent = 0;
//                LastModified = "2018-02-07 00:52:36";
//                LoginId = 7d9dc25bf04c4121935fc85ce8f1c75c;
//                Name = "30\U5206\U949f\U604b\U7231\U5b66\U4f1a\U7ecf\U6d4e\U5b662";
//                OrderNo = 324942a8420d4ca08c41f827950f057c;
//                OrderStatus = "-1";
//                PayAmount = 221;
//                PayDate = "2018-02-06 23:29:31";
//                PayStatus = 2;
//                PayType = 1;
//                ProductAmount = "55.55";
//                ProductId = 80fadf810fc14628acd4cea35e1a662f;
//                ProductType = 1;
//                Reason = "<null>";
//                Remark = "<null>";
//                ShouldAmount = "55.55";
//                TotalAmount = "55.55";
//                TotalCount = "55.55";
//                UnitPrice = "55.55";
//                VIPEndDate = "2018-02-06 23:29:31";
//                VIPStartDate = "2018-02-06 23:29:31";
//        }

        self.timeLabel?.text = diction["CreatedDate"] as? String
         self.titleLabel?.text = diction["Name"] as? String
        let url = URL.init(string: (diction["ImageSrcSmall"] as? String)!)
        self.icon?.setImageWith(url!, placeholderImage: UIImage(named:"teacher"))
        self.moneyLabel?.text = "￥\(String(describing: diction["SalePrice"] as! CGFloat))"
//        print("========\(diction["InvoiceStatus"] as? NSInteger)")
        if (diction["OrderStatus"] as! Int) == -1 {
            print("eeeeeeeeeeeee====\((diction["OrderStatus"] as! Int))")
            self.typeLabel?.text = "待支付"
            self.coverBtn?.isHidden = false
            self.typeLabel?.isHidden = true
            self.coverBtn?.setTitle("立即付款", for: UIControlState.normal)

        }else if (diction["OrderStatus"] as! Int) == 0 {
            self.typeLabel?.text = "已完成"
            self.coverBtn?.isHidden = true
            self.typeLabel?.isHidden = false
        }else if (diction["OrderStatus"] as! Int) == 1 {
            self.typeLabel?.text = "待发货"
            self.coverBtn?.isHidden = true
            self.typeLabel?.isHidden = false
        }else if (diction["OrderStatus"] as! Int) == 2 {
            self.typeLabel?.text = "待收货"
            self.coverBtn?.isHidden = false
            self.coverBtn?.setTitle("待收货", for: UIControlState.normal)
            self.typeLabel?.isHidden = true
            
        }
        print("4444445=========\(diction["OrderStatus"])")
    }
    
    
    
    
    func setDicBuy(diction:NSDictionary) {
        dicBuy = diction
        //            {
        //                ActualAmount = "55.55";
        //                BillId = "<null>";
        //                ChannelCode = "<null>";
        //                ChannelName = "<null>";
        //                CommitDate = "<null>";
        //                CommitStatus = 0;
        //                CreatedDate = "2018-02-06 23:29:31";
        //                DbOperateType = 0;
        //                ExchangeAmount = "55.55";
        //                GoodsName = "<null>";
        //                Id = dd79e108ab80466eb1f295c43b71ef00;
        //                InvoiceId = "<null>";
        //                InvoiceStatus = "-1";
        //                IsDeleted = 0;
        //                IsSuspent = 0;
        //                LastModified = "2018-02-07 00:52:36";
        //                LoginId = 7d9dc25bf04c4121935fc85ce8f1c75c;
        //                Name = "30\U5206\U949f\U604b\U7231\U5b66\U4f1a\U7ecf\U6d4e\U5b662";
        //                OrderNo = 324942a8420d4ca08c41f827950f057c;
        //                OrderStatus = "-1";
        //                PayAmount = 221;
        //                PayDate = "2018-02-06 23:29:31";
        //                PayStatus = 2;
        //                PayType = 1;
        //                ProductAmount = "55.55";
        //                ProductId = 80fadf810fc14628acd4cea35e1a662f;
        //                ProductType = 1;
        //                Reason = "<null>";
        //                Remark = "<null>";
        //                ShouldAmount = "55.55";
        //                TotalAmount = "55.55";
        //                TotalCount = "55.55";
        //                UnitPrice = "55.55";
        //                VIPEndDate = "2018-02-06 23:29:31";
        //                VIPStartDate = "2018-02-06 23:29:31";
        //        }
        
        self.timeLabel?.text = diction["CreatedDate"] as? String
        self.titleLabel?.text = diction["Name"] as? String
        let url = URL.init(string: (diction["ImageSrc"] as? String)!)
        self.icon?.setImageWith(url!, placeholderImage: UIImage(named:"teacher"))
        self.moneyLabel?.text = "￥\(String(describing: diction["SalePrice"] as! CGFloat))"
        //        print("========\(diction["InvoiceStatus"] as? NSInteger)")
        if (diction["OrderStatus"] as! NSInteger) == -1 {
            self.typeLabel?.text = "待支付"
            self.coverBtn?.isHidden = false
            self.typeLabel?.isHidden = true
        }else if (diction["OrderStatus"] as! NSInteger) == 0 {
            self.typeLabel?.text = "已完成"
            self.coverBtn?.isHidden = true
            self.typeLabel?.isHidden = false
        }else if (diction["OrderStatus"] as! NSInteger) == 1 {
            self.typeLabel?.text = "待发货"
            self.coverBtn?.isHidden = true
            self.typeLabel?.isHidden = false
        }else if (diction["OrderStatus"] as! NSInteger) == 2 {
            self.typeLabel?.text = "待收货"
            self.coverBtn?.isHidden = false
            self.coverBtn?.setTitle("待收货", for: UIControlState.normal)
            self.typeLabel?.isHidden = true
        }
    }
    
    
    
    func setIndex(dex:NSInteger) {
        index = dex
//        if index! % 2 == 0 {
//            self.icon?.image = UIImage(named:"book")
//            self.titleLabel?.text = "内容运营：如何运营一个9000万的用户平台?....(2016)"
//            self.coverBtn?.isHidden = true
//            self.typeLabel?.isHidden = false
////            self.coverBtn?.setImage(UIImage(named:"pay"), for: UIControlState.normal)
//        }else{
//            self.titleLabel?.text = "零售变革：渠道为主到产品为主（2017年）"
//            self.icon?.image = UIImage(named:"boolboy")
//            self.coverBtn?.isHidden = false
//            self.typeLabel?.isHidden = true
////            self.coverBtn?.setImage(UIImage(named:"complete"), for: UIControlState.normal)
//        }
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
// override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//   super.setHighlighted(highlighted, animated: animated)
//    
//    
//    if highlighted {
//        let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
//        scaleAnimation?.duration = 0.1
//        scaleAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 0.95, y: 0.95))
//        titleLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
////        icon?.pop_add(scaleAnimation, forKey: "scaleAnimation")
////        detailLable?.pop_add(scaleAnimation, forKey: "scaleAnimation")
////        moneyLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
////        numberLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
//        
//    }
//    else {
//        
//        let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
//        scaleAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
//        scaleAnimation?.velocity = NSValue(cgPoint: CGPoint(x: 2, y: 2))
//        scaleAnimation?.springBounciness = 20.0
//        titleLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
////        icon?.pop_add(scaleAnimation, forKey: "scaleAnimation")
////        detailLable?.pop_add(scaleAnimation, forKey: "scaleAnimation")
////        moneyLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
////        numberLabel?.pop_add(scaleAnimation, forKey: "scaleAnimation")
//    }
//    
//   }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
