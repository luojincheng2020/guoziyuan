//
//  AppDelegate.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/20.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate {

    var window: UIWindow?
    var tab:UITabBarController?
    var discover:DiscoverViewController!
    var isMiddle:Bool?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        URLProtocol.registerClass(RNCachingURLProtocol())
        URLProtocol.registerClass(RNCachingURLProtocol.self)
//        URLProtocol.registerClass()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        let index:IndexViewController = IndexViewController()
        let shop:ShopIndexViewController = ShopIndexViewController()
        discover = DiscoverViewController()
        let messgae:MessageViewController = MessageViewController()
        let myself:MySelfViewController = MySelfViewController()
        index.title = "首页"
        shop.title = "门店"
        discover.title = "发现"
        messgae.title = "消息"
        myself.title = "我的"
        index.tabBarItem.image = UIImage(named:"index")
        shop.tabBarItem.image = UIImage(named:"new_gravida_off")
        isMiddle = false
        
        //显示静态图片:
//        discover.tabBarItem.image = UIImage(named: "new_post")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        discover.tabBarItem.selectedImage = UIImage(named: "new_post")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        //显示gif图片:
        let jeremyGif = UIImage.gif(name:"shuiguo")
        discover.tabBarItem.image = UIImage(named: "discover")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        discover.tabBarItem.selectedImage = jeremyGif
        
        
        
        
//        if discover.tabBarItem.sel {
//            
//            discover.tabBarItem.imageInsets = UIEdgeInsetsMake(-8, 0, 5, 0);
//
//            
//        }else{
//            discover.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//            
//        }
        
        
        
        
        messgae.tabBarItem.image = UIImage(named:"message")
        
        myself.tabBarItem.image = UIImage(named:"myself")
        
        let navIndex = UINavigationController(rootViewController: index)
        let navShop = UINavigationController(rootViewController: shop)
        
        let navDiscover = UINavigationController(rootViewController: discover)
        let navMessage = UINavigationController(rootViewController: messgae)
        
        
        let navSelf = UINavigationController(rootViewController: myself)
        let navArr:NSArray = [navIndex,navShop,navDiscover,navMessage,navSelf]
        
        tab = UITabBarController()
        tab?.viewControllers = navArr as? [UIViewController]
        tab?.delegate = self
        UITabBar.appearance().tintColor = greenColor
        self.window?.rootViewController = tab
        return true
    }
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if tab?.selectedIndex == 2 {
//           return false
// 
//        }
//        return true
//
//    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        

        if tab?.selectedIndex == 2 {
//            if isMiddle == true {
////                tab?.tabBar.isUserInteractionEnabled = false
//            discover.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//
//            }
//
//            if isMiddle  == false{
//            discover.tabBarItem.isEnabled = false
            
//            UIEdgeInsetsMake(-6, 0, 6, 0) 数字必须是对称的 否则每点击一次就会变化
            discover.tabBarItem.imageInsets = UIEdgeInsetsMake(-6, 0, 6, 0);
            
//            }
//         isMiddle = true
       
           
        }else{
            
//            tab?.tabBar.isUserInteractionEnabled = true
            isMiddle  = false
            discover.tabBarItem.isEnabled = true
            discover.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);

        }
        
        

        if tab?.selectedIndex == 0 || tab?.selectedIndex == 4 {
//            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        }else{
           UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        }
        
    }
    
    
    
    
    
    
    func showIndexView() {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.backgroundColor = UIColor.white
        let index:IndexViewController = IndexViewController()
        let shop:ShopIndexViewController = ShopIndexViewController()
        discover = DiscoverViewController()
        let messgae:MessageViewController = MessageViewController()
        let myself:MySelfViewController = MySelfViewController()
        index.title = "首页"
        shop.title = "门店"
        discover.title = "发现"
        messgae.title = "资讯"
        myself.title = "个人"
        index.tabBarItem.image = UIImage(named:"index")
        shop.tabBarItem.image = UIImage(named:"new_gravida_off")
        
        //显示静态图片:
        //        discover.tabBarItem.image = UIImage(named: "new_post")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        //        discover.tabBarItem.selectedImage = UIImage(named: "new_post")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        //显示gif图片:
        let jeremyGif = UIImage.gif(name:"shuiguo")
        discover.tabBarItem.image = UIImage(named: "discover")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        discover.tabBarItem.selectedImage = jeremyGif
        
        messgae.tabBarItem.image = UIImage(named:"message")
        
        myself.tabBarItem.image = UIImage(named:"myself")
        
        let navIndex = UINavigationController(rootViewController: index)
        let navShop = UINavigationController(rootViewController: shop)
        
        let navDiscover = UINavigationController(rootViewController: discover)
        let navMessage = UINavigationController(rootViewController: messgae)
        
        
        let navSelf = UINavigationController(rootViewController: myself)
        let navArr:NSArray = [navIndex,navShop,navDiscover,navMessage,navSelf]
        
        tab = UITabBarController()
        tab?.viewControllers = navArr as? [UIViewController]
        tab?.delegate = self
        UITabBar.appearance().tintColor = greenColor
        tab?.selectedIndex = 0;
        self.window!.rootViewController = tab!
        self.window!.makeKeyAndVisible()
//        print("123452345==\(String(describing: tab))")
    }
    
 
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

