//
//  FSScrollContentViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/24.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit
import WebKit
import WebViewJavascriptBridge

class MessageWebViewController: BaseSubViewController ,UITableViewDelegate,UITableViewDataSource,WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate{


  

    var tableView:UITableView?
    var vcCanScroll:Bool = false
    var fingerIsTouch:Bool = false
    
    var isTableViewLoadData: Bool = false
    var topImage:UIImage?
    
    let identifier:String = "MessageList"
    
    
    
    var progressView: UIProgressView?
    var webView: WKWebView?
    
    var bridge:WebViewJavascriptBridge?
    
    //    //索引数组
    //    private lazy var cityDataSource : NSArray = {
    //        let list:[String] = [
    //            "长宁区", "嘉定区", "黄浦区", "静安区", "青浦区", "闸北区", "杨浦区",
    //            "卢湾区"]
    //
    //        return list as NSArray
    //    }()
    //
    //    private lazy var cityDataSourcetwo : NSArray = {
    //        let list:[String] = [
    //            "长宁", "嘉定", "黄浦", "静安", "青浦", "闸北", "杨浦",
    //            "卢湾"]
    //
    //        return list as NSArray
    //    }()
    //
    
    
    //    //索引数组
    //    private lazy var characterDataSource : NSArray = {
    //        let list:[String] = [
    //            "A", "B", "C", "D", "E", "F", "G",
    //            "H", "I", "J", "K", "L", "M", "N",
    //            "O", "P", "Q", "R", "S", "T",
    //            "U", "V", "W", "X", "Y", "Z"]
    //
    //        return list as NSArray
    //    }()
    //
    
    
    //    func setLeftButtonItemBackWith(_ image: UIImage, tintColor: UIColor) {
    //
    //
    //
    //        let btn = UIButton(type: UIButtonType.custom)
    //        btn.setImage(image, for: UIControlState.normal)
    //        btn.addTarget(self, action: #selector(MyOrderListViewController.back), for: UIControlEvents.touchUpInside)
    //
    //
    //
    ////        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(back))
    ////        item.tintColor = tintColor
    ////        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain , target: self, action: #selector(back))
    ////        print("22222222222")
    //    }
    ////    func back(){
    ////        print("23454345")
    ////        self.navigationController?.popViewController(animated: true)
    ////    }
    
    
    
    
    
    

    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        
        if (keyPath == "loading") {
            print("loading")
        }
        else if (keyPath == "title") {
            title = webView?.title
        }
        else if (keyPath == "estimatedProgress") {
            print("progress: \(webView!.estimatedProgress)")
            progressView?.progress = Float((webView?.estimatedProgress)!)
            if (progressView?.progress)! > Float(0.6) {
                self.title = "1234567"
            }
        }
        
        
        if webView?.isLoading == false  {
            // 手动调用JS代码
            // 每次页面完成都弹出来，大家可以在测试时再打开
            let js = "callJsAlert()"
            webView?.evaluateJavaScript(js, completionHandler: {(_ response: Any?, _ error: Error?) -> Void in
                print("response: \(String(describing: response)) error: \(String(describing: error))")
            })
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
                self.progressView?.alpha = 0
            })
        }
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        navigationController?.isNavigationBarHidden = false
        //        self.navigationController?.navigationBar.setBackgroundImage(topImage, for: .default)
        ////        self.navigationController?.navigationBar.isHidden = false
        //        self.navigationController?.navigationBar.alpha = 1.0
        
        
        
        //        let delay = DispatchTime.now() + 0.3
        //        DispatchQueue.main.asyncAfter(deadline: delay) {
//        self.setupSubViews()
        
        edgesForExtendedLayout = []
        automaticallyAdjustsScrollViewInsets = false
        
        
        
        let config = WKWebViewConfiguration()
        // 设置偏好设置
        config.preferences = WKPreferences()
        // 默认为0
        config.preferences.minimumFontSize = 10
        // 默认认为YES
        config.preferences.javaScriptEnabled = true
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        
        // web内容处理池
        config.processPool = WKProcessPool()
        // 通过JS与webview内容交互
        config.userContentController = WKUserContentController()
        // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
        // 我们可以在WKScriptMessageHandler代理中接收到
        config.userContentController.add(self, name: "AppModel")
        
        
        //通过默认的构造器来创建对象
        webView = WKWebView(frame: view.bounds, configuration: config)
        let path: URL? = Bundle.main.url(forResource: "test", withExtension: "html")
        webView?.load(URLRequest(url: path!))
        //2.加载网页
        //   NSURL *url = [NSURL URLWithString:@"https://passport.bitmain.com/login?service=https%3A%2F%2Fshop.bitmain.com%2Fuser%2Faccount.htm"];
        //  NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //   [self.webView loadRequest:request];
        view.addSubview(webView!)
        // 导航代理
        webView?.navigationDelegate = self
        // 与webview UI交互代理
        webView?.uiDelegate = self
        
        // 添加KVO监听
        webView?.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        webView?.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        
        
        
        
        
        // 添加进入条
        progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 2))

        
        progressView?.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
        //改变进度条的高度
//        progressView?.progressTintColor = UIColor.green
//        progressView?.backgroundColor = UIColor.clear
//        progressView?.tintColor = UIColor.clear
//        progressView?.progressViewStyle = .default

        // 进度条颜色
        progressView?.progressTintColor = greenColor
        progressView?.trackTintColor = UIColor.clear
        view.addSubview(progressView!)
        progressView?.setProgress(0.3, animated: true)
        
        
        //下面是使用:WebViewJavascriptBridge来实现JS交互的:
//        第一步：开启日志
        // 开启日志，方便调试
        WebViewJavascriptBridge.enableLogging()
        
//第二步：给ObjC与JS建立桥梁
        // 给哪个webview建立JS与OjbC的沟通桥梁
        bridge = WebViewJavascriptBridge.init(forWebView: webView!)
        
        // 设置代理，如果不需要实现，可以不设置
        self.bridge?.setWebViewDelegate(self)
//        第三步：注册HandleName，用于给JS端调用iOS端
        // JS主动调用OjbC的方法
        // 这是JS会调用getUserIdFromObjC方法，这是OC注册给JS调用的
        // JS需要回调，当然JS也可以传参数过来。data就是JS所传的参数，不一定需要传
        // OC端通过responseCallback回调JS端，JS就可以得到所需要的数据
        
        //原生与JS约定接口名为“testObjcCallback”，data是JS传递过来的信息，responseCallback来将信息传递给JS
//                bridge?.registerHandler("testObjcCallback", handler: {(_ data: Any, _ responseCallback: WVJBResponseCallback) -> Void in
//                    responseCallback（
//                    ）
//                })
        
//        bridge?.registerHandler("getUserIdFromObjC", handler: {(_ data: Any, _ responseCallback: WVJBResponseCallback) -> Void in
//            print("js call getUserIdFromObjC, data from js is \(data)")
//            if responseCallback {
//                // 反馈给JS
//                responseCallback(["userId": "123456"])
//            }
//        })
   
    
        
        
        //初始化WebViewJavascriptBridge方法
//        bridge = WebViewJavascriptBridge(for: bookWebView, webViewDelegate: self, handler: {(_ data: Any, _ responseCallback: WVJBResponseCallback) -> Void in
//        })
        
        
        //原生与JS约定接口名为“testObjcCallback”，data是JS传递过来的信息，responseCallback来将信息传递给JS
//        bridge.registerHandler("testObjcCallback", handler: {(_ data: Any, _ responseCallback: WVJBResponseCallback) -> Void in
//            responseCallback（
//            "postInfomationToJS"
//            ）
//        })

    
        
     
        
        
        
        
  
    }
    
    func setupSubViews() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: SCREENHEIGHT), style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        //        tableView?.bounces = false
        //        view.addSubview(tableView!)
        self.view.addSubview(tableView!)
        let nib:UINib = UINib.init(nibName: identifier, bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: identifier)
        tableView?.backgroundColor = lightColor
        
        
        tableView?.sectionIndexColor = greenColor;
        
        tableView?.sectionIndexBackgroundColor = UIColor.clear;
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView?.backgroundColor = lightColor
        //        sectionIndexMinimumDisplayRowCount: 个数大于该值才会显示索引,默认为0。
        //        触摸时索引条背景的颜色:
        //        tableView?.sectionIndexTrackingBackgroundColor =  darkColor
        //        tableView?.addIndexTip()
        
        GCDQueue.execute(inMainQueue: {() -> Void in
            //        // Load data.
            var indexPaths = [IndexPath]()
            
            
            
            
            
            for j in 0...9 {
                
                indexPaths.append(IndexPath(item: j, section: 0))
            }
            
            
            
            
            //            while i < 17 {
            //                indexPaths.append(IndexPath(item: i, section: 0))
            //                i += 1
            //            }
            self.isTableViewLoadData = true
            
            //            self.tableView!.insertRows(at: indexPaths , with: .fade)
            
            self.tableView!.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
            
        }, afterDelaySecs: 0.15)
        
        
        
        //        loopViews.tapClickBlock = {(loopView)-> Void in
        //            let alert = UIAlertView(title: "文字", message: "老：\(loopViews.currentIndex+1)被点了", delegate: self, cancelButtonTitle: "love you", otherButtonTitles: "cancle")
        //            alert.show()
        //        }
        
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.isTableViewLoadData ? 10 : 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cellTop:MessageList! = tableView.dequeueReusableCell(withIdentifier: identifier) as? MessageList
        cellTop.setIndex(dex: indexPath.row)
        //        cellTop.titleLabel?.text = self.title! +  "\(indexPath.row)"
        
        if cellTop == nil {
            cellTop = MessageList(style: .default, reuseIdentifier: identifier)
        }
        cellTop.selectionStyle = UITableViewCellSelectionStyle.none
        return cellTop!
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail = MessageDetailViewController()
        detail.title = "今日资讯"
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
//        self.navigationController?.navigationBar.setBackgroundImage(topImage, for: .default)
//        //        self.navigationController?.navigationBar.isHidden = false
//        navigationController?.navigationBar.subviews.first?.alpha = 1.0
//        
//    }
    
    
    
    @available(iOS 8.0, *)
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if (message.name == "AppModel") {
            // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
            // NSDictionary, and NSNull类型
            print("9999===\(message.body)")
            //跳转到指定控制器中
//            let root = MessageDetailViewController()
//            navigationController?.pushViewController(root, animated: true)
        }
        
        
    }
    
    
    // 请求开始前，会先调用此代理方法
    // 与UIWebView的
    // - (BOOL)webView:(UIWebView *)webView
    // shouldStartLoadWithRequest:(NSURLRequest *)request
    // navigationType:(UIWebViewNavigationType)navigationType;
    // 类型，在请求先判断能不能跳转（请求）

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let hostname: String? = navigationAction.request.url?.host?.lowercased()
        if navigationAction.navigationType == .linkActivated && !(hostname?.contains(".lanou.com"))! {
            // 对于跨域，需要手动跳转
            UIApplication.shared.openURL((navigationAction.request.url)!)
            // 不允许web内跳转
            decisionHandler(.cancel)
        }
        else {
            progressView?.alpha = 1.0
            decisionHandler(.allow)
        }
        print("00===\(#function)")
    }
    
    
    // 在响应完成时，会回调此方法
    // 如果设置为不允许响应，web内容就不会传过来
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
        print("11===\(#function)")
        let jsToGetHTMLSource = "document.documentElement.innerHTML"
    }
    
    // 开始导航跳转时会回调
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("22===\(#function)")
    }
    
    // 接收到重定向时会回调
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("33===\(#function)")
    }
    
    // 导航失败时会回调
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("44===\(#function)")
    }
    
    // 页面内容到达main frame时回调
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("55===\(#function)")
    }
    
    // 导航完成时，会回调（也就是页面载入完成了）
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("66===\(#function)")
    }
    
    // 导航失败时会回调
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("77===\(#function)")
    }
    
    
    // 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
    // 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("88===\(#function)")
        completionHandler(.performDefaultHandling, nil)
    }
    
    // 9.0才能使用，web内容处理中断时会触发
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("99===\(#function)")
    }
    
    //  WKUIDelegate
    
    func webViewDidClose(_ webView: WKWebView) {
        print("99===\(#function)")
    }
    
    
    // 在JS端调用alert函数时，会触发此代理方法。
    // JS端调用alert时所传的数据可以通过message拿到
    // 在原生得到结果后，需要回调JS，是通过completionHandler回调
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
//        print("100===\(#function)")
        
//        print("100===\(message)")
        
        let alert = UIAlertController(title: "alert", message: "JS调用alert", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            completionHandler()
        }))
        present(alert, animated: true) { _ in }
        print("\(message)")
    }

    
    // JS端调用confirm函数时，会触发此方法
    // 通过message可以拿到JS端所传的数据
    // 在iOS端显示原生alert得到YES/NO后
    // 通过completionHandler回调给JS端
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print("101===\(#function)")
        let alert = UIAlertController(title: "confirm", message: "JS调用confirm", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            completionHandler(false)
        }))
        present(alert, animated: true) { _ in }
        print("\(message)")
        
        
    }
 
    // JS端调用prompt函数时，会触发此方法
    // 要求输入一段文本
    // 在原生输入得到文本内容后，通过completionHandler回调给JS
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
//        print("102===\(prompt)")
//        print("\(prompt)")
        if prompt == "1" {
            let alert = UIAlertController(title: "textinput", message: "请输入您的用户名", preferredStyle: .alert)
            alert.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
                textField.textColor = UIColor.red
            })
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                completionHandler(alert.textFields?.last?.text)
                
                
                // 手动调用JS代码
                // 每次页面完成都弹出来，大家可以在测试时再打开
                //            let js = "callJsAlert()"
                //            self.webView?.evaluateJavaScript(js, completionHandler: {(_ response: Any?, _ error: Error?) -> Void in
                //                print("response: \(String(describing: response)) error: \(String(describing: error))")
                //            })
                
                
            }))
            present(alert, animated: true) { _ in }
            
  
        }else if prompt == "2"{
            
            let alert = UIAlertController(title: "textinput", message: "请输入你的地址", preferredStyle: .alert)
            alert.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
                textField.textColor = UIColor.red
            })
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                completionHandler(alert.textFields?.last?.text)
                
                
                // 手动调用JS代码
                // 每次页面完成都弹出来，大家可以在测试时再打开
                //            let js = "callJsAlert()"
                //            self.webView?.evaluateJavaScript(js, completionHandler: {(_ response: Any?, _ error: Error?) -> Void in
                //                print("response: \(String(describing: response)) error: \(String(describing: error))")
                //            })
                
                
            }))
            present(alert, animated: true) { _ in }
            

            
            
        }
        
            
        
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
