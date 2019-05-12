//
//  DiscoverViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/22.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,YYCollectionViewLayoutDelegate {
    
    
    var itemHeights = [Any]()
    var dataSource = [Any]() /* capacity: numberOfItems */
    var resuse:String = "123"
    var layout: YYCollectionViewLayout?
    var collectionView: UICollectionView?
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return nil
        
        let cell: YYCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: resuse, for: indexPath) as? YYCollectionViewCell
        cell?.itemImage?.image = UIImage(named: "\(indexPath.row + 1).jpeg")
        cell?.itemImage?.contentMode = .scaleAspectFill
        cell?.itemName?.text = "美国原装进口Apple\(indexPath.row).0"
        cell?.itemDetail?.text = "本产品为\(arc4random_uniform(10))A级纯绿色无公害食品，富含天然矿物质。产品一经售出概不负责，最终解释权归卖家所有。产品如有雷同，纯属巧合。如有巧合，纯属意外。如有意外，纯属虚构。－－－非凡卖品有限公司"
        cell?.nowPrice?.text = "$11\(arc4random_uniform(99))"
        let attributeDict: [AnyHashable: Any] = [NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle, NSStrikethroughColorAttributeName: UIColor.red]
        cell?.oldPrice?.attributedText = NSAttributedString(string: "$99\(arc4random_uniform(99))", attributes: attributeDict as? [String : Any])
        cell?.saleNumber?.text = "月销9.\(arc4random_uniform(9))万笔"
        
        return cell!
    }

    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }

    @available(iOS 6.0, *)
    func yyCollectionViewLayout(for collection: UICollectionView!, with layout: YYCollectionViewLayout!, at indexPath: IndexPath!) -> CGSize {
        return CGSize(width:CGFloat(heightSize()),height:itemHeights[indexPath.row] as! CGFloat)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        layout = YYCollectionViewLayout()
        layout?.delegate = self
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(UINib(nibName: "YYCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: resuse)
        initData()

        // Do any additional setup after loading the view.
    }

    
    func initData() {

        for _ in 0..<numberOfItems {
            let height: CGFloat = CGFloat(200 + arc4random_uniform(200))
            itemHeights.append((height))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let v = GoodDetailViewController()
        
        self.navigationController?.pushViewController(v, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
//            self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
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
