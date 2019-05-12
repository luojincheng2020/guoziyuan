//
//  ViewController.swift
//  仿网易scrollView
//
//  Created by 张海峰 on 2017/8/10.
//  Copyright © 2017年 张海峰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var titleScrollView :UIScrollView = UIScrollView()
    var contentScrollView :UIScrollView = UIScrollView()
    var radioBtn :UIButton = UIButton()
    lazy var titleBtns : NSMutableArray = NSMutableArray()
    var isInitalize : Bool = false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (isInitalize == false) {
            //4.设置所有的标题
            setupAllTitle()
            isInitalize = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //这一行代码主要确定是否隐藏导航栏
        self.navigationController?.isNavigationBarHidden = true
        //1.添加标题滚动视图
        setupTitleScrollView()
        //2.添加内容滚动视图
        setupContentScrollView()
        //IOS 7 以后导航控制器中scrollView顶部会添加64的额外滚动区域
        self.automaticallyAdjustsScrollViewInsets = false
        //处理标题的点击

    }
}

//MARK:-  设置UI
extension ViewController:UIScrollViewDelegate{
    func setupTitleScrollView(){
        titleScrollView = UIScrollView.init()
        //判断是否有导航栏 
        let y : CGFloat = self.navigationController!.isNavigationBarHidden ? 20 : 64
        titleScrollView.frame = CGRect.init(x: 0, y: y, width: SCREENWIDTH, height: 44)
         self.view.addSubview(titleScrollView)
    }
    func setupContentScrollView(){
        contentScrollView = UIScrollView.init()
        //判断是否有导航栏
        let y : CGFloat = titleScrollView.frame.maxY
        contentScrollView.frame = CGRect.init(x: 0, y: y, width: SCREENWIDTH, height: SCREENHEIGHT - y)
        self.view.addSubview(contentScrollView)
        contentScrollView.delegate=self;
        //分页
        contentScrollView.isPagingEnabled = true;
        //弹簧
        contentScrollView.bounces = false;
        //设置代理。目的：监听内容滚动视图 什么时候滚动完成
    }
    func setupAllTitle() {
        let count :NSInteger = self.childViewControllers.count;
        let btnW :CGFloat = 100
        let btnH :CGFloat = self.titleScrollView.bounds.size.height
        var btnX :CGFloat = 0
        for i in 0 ..< count {
            let titleBtn :UIButton = UIButton.init(type:UIButtonType.custom)
            let VC :UIViewController =  self.childViewControllers[i]
            titleBtn.setTitle(VC.title, for: UIControlState.normal)
            btnX = CGFloat(i) * btnW
            titleBtn.tag = i
            titleBtn.setTitleColor(darkColor, for: UIControlState.normal)
            titleBtn.frame = CGRect.init(x: btnX, y: 0, width: btnW, height: btnH)
            titleBtn.addTarget(self, action: #selector(titleBtnClick), for: UIControlEvents.touchUpInside)
            self.titleBtns.add(titleBtn)
            if i == 0 {
                titleBtnClick(titleBtn: titleBtn)
            }
            titleScrollView.addSubview(titleBtn)
            titleScrollView.contentSize = CGSize.init(width: CGFloat(count) * btnW, height: 0)
            titleScrollView.showsHorizontalScrollIndicator = false;
            contentScrollView.contentSize = CGSize.init(width: CGFloat(count) * SCREENWIDTH, height: 0)
            contentScrollView.showsHorizontalScrollIndicator = false;
        }
    }
}
//MARK:-  处理关联事件
extension ViewController{
    func titleBtnClick(titleBtn: UIButton)  {
        selButton(btn: titleBtn)
        setupOneViewController(btnTag :titleBtn.tag)
        setupTitleCenter(btn: titleBtn)
        let x :CGFloat  = CGFloat(titleBtn.tag) * SCREENWIDTH;
        self.contentScrollView.contentOffset = CGPoint.init(x: x, y: 0);
        radioBtn = titleBtn;

    }
    func selButton(btn: UIButton){
        radioBtn.transform = CGAffineTransform(scaleX: 1, y: 1);
        radioBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.setTitleColor(greenColor, for: UIControlState.normal)
        btn.transform = CGAffineTransform(scaleX: 1.3, y: 1.3);
    }
    func setupOneViewController(btnTag: NSInteger){
        let VC : UIViewController = self.childViewControllers[btnTag]
        if (VC.view.superview != nil) {
            return
        }
        let x : CGFloat = CGFloat(btnTag) * SCREENWIDTH
        VC.view.frame = CGRect.init(x: x, y: 0, width: SCREENWIDTH, height: contentScrollView.bounds.size.height)
        self.contentScrollView.addSubview(VC.view)
    }
    func setupTitleCenter(btn: UIButton){
        var offsetPoint : CGPoint = titleScrollView.contentOffset
        offsetPoint.x =  btn.center.x -  SCREENWIDTH / 2
        //左边超出处理
        if offsetPoint.x < 0{
            offsetPoint.x = 0
        }
        let maxX : CGFloat = titleScrollView.contentSize.width - SCREENWIDTH;
        //右边超出处理
        if offsetPoint.x > maxX {
            offsetPoint.x = maxX
        }
        titleScrollView.setContentOffset(offsetPoint, animated: true)
    }
}
//MARK:-  处理UIScrollViewDelegate事件
extension ViewController{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取标题
        let leftI :NSInteger   = NSInteger(scrollView.contentOffset.x / SCREENWIDTH);
        let rightI :NSInteger   = leftI + 1
        //选中标题
        if (rightI < titleBtns.count) {
            let titleBtn :UIButton  = titleBtns[leftI] as! UIButton
            selButton(btn: titleBtn)
            setupOneViewController(btnTag: rightI)
            setupTitleCenter(btn: titleBtn)
        }
        //字体缩放 1.缩放比例 2.缩放那两个按钮
        //获取左边的按钮
        let leftBtn :UIButton  = self.titleBtns[leftI] as! UIButton
        //获取右边的按钮
        var rightBtn :UIButton = UIButton()
        if (rightI<self.titleBtns.count) {
            rightBtn  = self.titleBtns[rightI] as! UIButton
        }
        var scaleR :CGFloat  = scrollView.contentOffset.x / SCREENWIDTH;
        scaleR -=  CGFloat(leftI)
        let scaleL :CGFloat  = 1 - scaleR;
        //缩放按钮
        leftBtn.transform = CGAffineTransform.init(scaleX: scaleL * 0.3 + 1, y: scaleL * 0.3 + 1)
        rightBtn.transform = CGAffineTransform.init(scaleX: scaleR * 0.3 + 1, y: scaleR * 0.3 + 1)
        //颜色渐变
//        let rightColor:UIColor = UIColor.init(red: scaleR, green: 0, blue: 0, alpha: 1)
//        let leftColor:UIColor = UIColor.init(red: scaleL, green: 0, blue: 0, alpha: 1)
        let rightColor:UIColor = UIColor.init(red: 4/255, green: scaleR, blue: 0, alpha: 1)
        let leftColor:UIColor = UIColor.init(red: 4/255, green:scaleL, blue: 0, alpha: 1)
        rightBtn.setTitleColor(rightColor, for: UIControlState.normal)
        leftBtn.setTitleColor(leftColor, for: UIControlState.normal)
    }
}


