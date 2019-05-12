//
//  PrefixHeaderSwift.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/20.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit
import SDWebImage
import AFNetworking
import pop
//import MJRefresh
import WebViewJavascriptBridge
import Masonry



let SCREENHEIGHT = UIScreen.main.bounds.height
let SCREENWIDTH = UIScreen.main.bounds.width
let LINE = 2
let PADDING = 10
let LINEHEIGHT:CGFloat = 0.5
let numberOfItems = 21
let changeRate = (SCREENWIDTH / SCREENHEIGHT)

let lightColor = UIColor(red: 241 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1.0)
let darkColor = UIColor(red: 102 / 255.0, green: 102 / 255.0, blue: 102 / 255.0, alpha: 1.0)
let blackColor = UIColor(red: 50 / 255.0, green: 50 / 255.0, blue: 50 / 255.0, alpha: 1.0)
let greenColor = UIColor(red: 4 / 255.0, green: 255 / 255.0, blue: 0 / 255.0, alpha: 1.0)
let redColor = UIColor(red: 255 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
let blueColor = UIColor.blue
let API = "http://www.guoziyuan.shop"
let LOGIN_URL = "\(API)/api/member/apiLogin" //登录接口
let REGISTER_URL = "\(API)/api/member/apiRegister" //注册接口


let ADDRESS_LIST_URL = "\(API)/api/address/apiGetAddressInfos" //收货地址列表接口

let CREATE_ADDRESS_URL = "\(API)/api/address/apiCreateAddressInfo" //新增收货地址接口
let DELETE_ADDRESS_URL = "\(API)/api/address/apiDeleteAddressInfo" //删除收货地址接口
let MODIFY_ADDRESS_URL = "\(API)/api/address/apiModifyAddressInfo" //修改收货地址接口




//let ITEM_WIDTH  = (SCREENWIDTH - PADDING*(LINE+1))/LINE
func fontSize(size:CGFloat) -> UIFont{
 return UIFont.systemFont(ofSize: size)
}
func heightSize() -> CGFloat{
    return (SCREENWIDTH - 10*(2+1))/2
}





