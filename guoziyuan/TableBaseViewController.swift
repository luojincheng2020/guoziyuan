//
//  TableViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/9/8.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit
import MJRefresh
class TableBaseViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView:BaseTableView?
    var isTableViewLoadData: Bool = false
    var dateArray = [IndexPath]()
    private lazy var imageArr : NSArray = {
        let list:[UIImage] = [UIImage(named:"dropdown_loading_01")!,UIImage(named:"dropdown_loading_02")!
            ,UIImage(named:"dropdown_loading_03")!]
        
        return list as NSArray
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        setupSubViews()
    }
    
    
    func setupSubViews(rect:CGRect,style:UITableViewStyle, isShowHead:Bool,isShowFooter:Bool) {
        tableView = BaseTableView(frame: rect, style: style)
        tableView?.delegate = self
        tableView?.dataSource = self
        //        tableView?.bounces = false
        //        view.addSubview(tableView!)
        self.view.addSubview(tableView!)
//        let nib:UINib = UINib.init(nibName: identifier, bundle: nil)
//        tableView?.register(nib, forCellReuseIdentifier: identifier)
//        tableView?.backgroundColor = lightColor
//        
//        
//        tableView?.sectionIndexColor = greenColor;
//        
//        tableView?.sectionIndexBackgroundColor = UIColor.clear;
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView?.backgroundColor = lightColor
        //        sectionIndexMinimumDisplayRowCount: 个数大于该值才会显示索引,默认为0。
        //        触摸时索引条背景的颜色:
        //        tableView?.sectionIndexTrackingBackgroundColor =  darkColor
        //        tableView?.addIndexTip()
        
        
        
        
        //        loopViews.tapClickBlock = {(loopView)-> Void in
        //            let alert = UIAlertView(title: "文字", message: "老：\(loopViews.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "cancle")
        //            alert.show()
        //        }
        
        if isShowHead {
            let header = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(self.loadNewData))
            //         设置普通状态的动画图片
            let img = UIImage(named:"dropdown_anim__0001")
            
            let imgState = UIImage(named:"dropdown_anim__00057")
            //        let imageStr:NSArray = ["dropdown_loading_01","dropdown_loading_02","dropdown_loading_03"]
            
            
            header?.setImages([img ?? UIImage()], for: MJRefreshState.idle)
            //        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
            header?.setImages([imgState ?? UIImage()], for: MJRefreshState.pulling)
            //        // 设置正在刷新状态的动画图片
            header?.setImages(imageArr as! [Any], for: MJRefreshState.refreshing)
            //        // 设置header
            tableView?.mj_header = header
            header?.beginRefreshing()
            // 隐藏时间
            header?.lastUpdatedTimeLabel.isHidden = true
            
            // 隐藏状态
            header?.stateLabel.isHidden = true
        }
        
        
        
        
        
        
        
        if isShowFooter {
            //        MJRefreshGifHeader  MJRefreshAutoGifFooter自动下拉刷新:
            
            let footer = MJRefreshAutoGifFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMoreData))
            //         设置普通状态的动画图片
            let imgFooter = UIImage(named:"dropdown_anim__0001")
            
            let imgStateFooter = UIImage(named:"dropdown_anim__00057")
            //        let imageStr:NSArray = ["dropdown_loading_01","dropdown_loading_02","dropdown_loading_03"]
            
            
            footer?.setImages([imgFooter ?? UIImage()], for: MJRefreshState.idle)
            //        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
            footer?.setImages([imgStateFooter ?? UIImage()], for: MJRefreshState.pulling)
            //        // 设置正在刷新状态的动画图片
            footer?.setImages(imageArr as! [Any], for: MJRefreshState.refreshing)
            //        // 设置header
            tableView?.mj_footer = footer
            //        footer?.beginRefreshing()
            
            
            // 隐藏时间
            //        footer?.lastUpdatedTimeLabel.isHidden = true
            
            // 隐藏状态
            //        footer?.stateLabel.isHidden = true
            footer?.setTitle("", for: .idle)
            footer?.setTitle("松开即可加载", for: .pulling)
            footer?.setTitle("正在加载中...", for: .refreshing)
            footer?.setTitle("没有更多数据了", for: .noMoreData)
            
            
            //        let header = MJRefreshNormalHeader(refreshingBlock: {() -> Void in
            //            self.loadNewData()
            //        })
            //        header?.beginRefreshing()
            //       tableView?.mj_header = header
            
        }
        

        
        
    }
    
    func loadNewData() {
        
        
        //        for j in 0...indexPaths.count {
        
        //            self.indexPaths.append(IndexPath(item: j, section: 0))
        //            if j==9{
        //                self.tableView?.mj_header.endRefreshing()
        //            }
        
        
        //            self.tableView!.deleteRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        
        
        //        }
        
        //        indexPaths.removeAll()
            
    }
    
    
    
    
    func loadMoreData() {
        
        
        
      }

    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell? = UITableViewCell()
       return cell!
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
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
