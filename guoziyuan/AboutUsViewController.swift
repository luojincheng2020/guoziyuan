//
//  AboutUsViewController.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/30.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseBackViewController {
    var topImage:UIImage?
    @IBOutlet var textView:UITextView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = lightColor
        //显示黑背景菊花:
//        self.view.makeToastActivityWithMessage(message: "")
//        let delay = DispatchTime.now() + .seconds(1)
//        DispatchQueue.main.asyncAfter(deadline: delay) {
//            self.view.hideToastActivity()
//        }
        
   
        
        
        textView?.font = UIFont.systemFont(ofSize: 14)
        textView?.textColor = darkColor
       
        // Do any additional setup after loading the view.
//        showLoadViewTwo()
        
            /*******显示正确_图片*******/
//        MBProgressHUD.showSuccess("成功了", view: nil)
        /*******显示错误_图片*******/
//        MBProgressHUD.showError("失败了", view: nil)
        /*******仅文字提示无回调操作*******/
//        MBProgressHUD.showNotice("哇哈哈哈哈", view: nil)
//        showLoadViewThree()
//        showCustomLoadAnimate(self.view)
//        MBProgressHUD.drawErrorView(withText: "出错了", view: nil)
//        MBProgressHUD.drawRightView(withText: "对了", view: nil)
//        drawRoundLoadView()
        
        
        
//        showCustomLoadAnimate(self.view)
        
        
        ZSProgressHUD.showShowText("正在加载...")
        perform(#selector(self.delayLoad), with: "加载成功", afterDelay: 2)
        
        
    }
    
    
    func showLoadView() {
        //显示菊花:
        let HUD = MBProgressHUD.defaultMBProgress(nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
            HUD?.hide(true)
        })
        
    }
    /*******默认菊花带文字*******/
    func showLoadViewTwo() {
        let HUD = MBProgressHUD.defaultMBProgress(withText: "玩命加载中...", view: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
            HUD?.hide(true)
        })
        
    }
    
    
    /*******提示有回调操作*******/
    
    func showLoadViewThree() {
        let HUD = MBProgressHUD.defaultMBProgress(withText: "玩命加载中...", view: nil)
        HUD?.completionBlock = {() -> Void in
            //hud消失回调
            let HUD_2 = MBProgressHUD.showNotice("请先登录", view: nil)
            HUD_2?.hide(true, afterDelay: 0.5)
            HUD_2?.completionBlock = {() -> Void in
                //hud消失回调
//                let twoVC = TwoViewController()
//                navigationController?.pushViewController(twoVC as? UIViewController ?? UIViewController(), animated: true)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
            HUD?.hide(true)
        })
        
        
        
    }
    
    
    //显示自定义动画
    override func showCustomLoadAnimate(_ view: UIView) {
        let HUD = MBProgressHUD.showCustomAnimate("", imageName: "dropdown_anim__", imageCounts: 60, view: view)
        //延迟3秒模仿加载
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
            HUD?.hide(true)
        })
    }
/*******环形动画*******/
    func drawRoundLoadView() {
         let HUD = MBProgressHUD.drawRoundLoadingView("请稍后...", view: nil)
        //延迟3秒模仿加载
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
            HUD?.hide(true)
        })
    }
    
    
    
    
    
    func delayLoad(_ str: Any) {
        if (str as? String == "加载成功") {
            ZSProgressHUD.showSuccessfulText(str as! String)
            
            
             textView?.text = "果子园是一家专门销售当季水果的网站，针对客户的需求，根据季节的变化，向用户推荐最适合最好吃的水果产品!  一、【协议的范围】  1.1【协议适用主体范围】  本协议是您与恒信资管之间关于您下载、安装、使用、登录本软件，以及使用本服务所订立的协议。 1.2【协议关系及冲突条款】  本协议的内容，包括但不限于以下与本服务、本协议相关的协议、规则、规范以及恒信资管可能不断发布的关于本服务的相关协议、规则、规范等内容，前述内容一经正式发布，即为本协议不可分割的组成部分，与其构成统一整体，您同样应当遵守：   二、【关于本服务】  2.1【本服务内容】  本服务内容是指恒信资管通过本软件向用户提供的相关服务（简称“本服务”）。 2.2【本服务形式】  您可能可以通过电脑、手机等终端以客户端、网页等形式使用本服务，具体以恒信资管提供的为准，同时，恒信资管会不断丰富您使用本服务的终端、形式等。当您使用本服务时，您应选择与您的终端、系统等相匹配的本软件版本，否则，您可能无法正常使用本服务。  2.3【许可的范围】  2.3.1 恒信资管给予您一项个人的、不可转让及非排他性的许可，以使用本软件。您可以为非商业目的在单一台终端设备上下载、安装、使用、登录本软件。  2.3.2 您可以制作本软件的一个副本，仅用作备份。备份副本必须包含原软件中含有的所有著作权信息。 2.3.3 本条及本协议其他条款未明示授权的其他一切权利仍由恒信资管保留，您在行使这些权利时须另外取得恒信资管的书面许可。恒信资管如果未行使前述任何权利，并不构成对该权利的放弃。   三、【软件的获取】  4.1 您可以直接从恒信资管的网站上获取本软件，也可以从得到恒信资管授权的第三方获取。  4.2 如果您从未经恒信资管授权的第三方获取本软件或与本软件名称相同的安装程序，恒信资管无法保证该软件能够正常使用，并对因此给您造成的损失不予负责。   四、【软件的安装与卸载】  5.1 恒信资管可能为不同的终端、系统等开发了不同的软件版本，您应当根据实际情况选择下载合适的版本进行安装。\n5.2 下载安装程序后，您需要按照该程序提示的步骤正确安装。  5.3 为提供更加优质、安全的服务，在本软件安装时恒信资管可能推荐您安装其他软件，您可以选择安装或不安装。  5.4 如果您不再需要使用本软件或者需要安装新版软件，可以自行卸载。如果您愿意帮助恒信资管改进产品服务，请告知卸载的原因。   五、【软件的更新】  6.1 为了增进用户体验、完善服务内容，恒信资管将不断努力开发新的服务，并为您不时提供软件更新（这些更新可能会采取软件替换、修改、功能强化、版本升级等形式）。  6.2 本软件可能为您默认开启自动升级、更新等功能，您可以在软件设置中自行选择是否需要开启此功能。 6.3 为了改善用户体验，并保证服务的安全性和功能的一致性，恒信资管有权不经向您特别通知而对软件进行更新，或者对软件的部分功能效果进行改变或限制。  6.4 本软件新版本发布后，旧版本的软件可能无法使用。恒信资管不保证旧版本软件继续可用及相应的客户服务，请您随时核对并下载最新版本。   七、【用户个人信息保护】  7.1 保护用户个人信息是恒信资管的一项基本原则，恒信资管将会采取合理的措施保护用户的个人信息。除法律法规规定的情形外，未经用户许可恒信资管不会向第三方公开、透露用户个人信息。恒信资管对相关信息采用专业加密存储与传输方式，保障用户个人信息的安全。  7.2 您在注册帐号或使用本服务的过程中，可能需要填写一些必要的信息。若国家法律法规或政策有特殊规定的，您需要填写真实的身份信息。若您填写的信息不完整，则无法使用本服务或在使用过程中受到限制。  7.3 一般情况下，您可随时浏览、修改自己提交的信息，但出于安全性和身份识别（如号码申诉服务等）的考虑，您可能无法修改注册时提供的初始注册信息及其他验证信息。  7.4 恒信资管将运用各种安全技术和程序建立完善的管理制度来保护您的个人信息，以免遭受未经授权的访问、使用或披露。  7.5 恒信资管非常重视对未成年人个人信息的保护。若您是18周岁以下的未成年人，在使用本服务前，应事先取得您家长或法定监护人的书面同意。   八、【用户行为规范】  8.1【用户注意事项】  8.1.1 您充分理解并同意：您在使用本服务某一特定服务时，本服务可以使用您终端设备的相关权限、接口及相关信息等以实现相应的功能，某些特定服务可能还需同意单独的协议、规则等，您在使用该项服务前请仔细阅读前述相关协议、规则。  8.1.2 恒信资管有权在本服务中或通过本服务向您展现各种信息，包括但不限于广告信息、新闻信息及宣传信息等，该信息可能以系统消息或弹出窗口等形式出现。  8.1.3 您可以选择不向恒信资管提供您的某些信息，或者根据产品设置取消恒信资管收集某些信息，但因此可能会导致相关服务功能无法实现。  8.1.4 您理解并同意：恒信资管将会尽其商业上的合理努力保障您在本软件及服务中的数据存储安全，但是，恒信资管并不能就此提供完全保证，包括但不限于以下情形：   （1）恒信资管不对您在本软件及服务中相关数据的删除或储存失败负责；  （2）恒信资管有权根据实际情况自行决定您在本软件及服务中数据的最长储存期限、服务器中数据的最大存储空间等，您可根据自己的需要自行备份本软件及服务中的相关数据。双方另有约定的按相应约定执行；  （3）如果您停止使用本软件及服务或服务被终止或取消，恒信资管可以从服务器上永久地删除您的数据。您的服务停止、终止或取消后，恒信资管没有义务向您返还任何数据。   8.2【五不准】  您在使用本服务时不得利用本服务从事以下行为，包括但不限于：  （1）发布、传送、传播、储存违反国家法律、危害国家安全统一、社会稳定、公序良俗、社会公德以及侮辱、诽谤、淫秽、暴力的内容；  （2）发布、传送、传播、储存侵害他人名誉权、肖像权、知识产权、商业秘密等合法权利的内容； （3）虚构事实、隐瞒真相以误导、欺骗他人； （4）发表、传送、传播广告信息及垃圾信息；  （5）从事其他违反法律法规、政策及公序良俗、社会公德等的行为。 8.3【用户禁止行为】  除非法律允许或恒信资管书面许可，您不得从事下列行为： （1）删除本软件及其副本上关于著作权的信息；  （2）对本软件进行反向工程、反向汇编、反向编译，或者以其他方式尝试发现本软件的源代码； （3）对恒信资管拥有知识产权的内容进行使用、出租、出借、复制、修改、链接、转载、汇编、发表、出版、建立镜像站点等；  （4）对本软件或者本软件运行过程中释放到任何终端内存中的数据、软件运行过程中客户端与服务器端的交互数据，以及本软件运行所必需的系统数据，进行复制、修改、增加、删除、挂接运行或创作任何衍生作品，形式包括但不限于使用插件、外挂或非恒信资管经授权的第三方工具/服务接入本软件和相关系统；  （5）通过修改或伪造软件运行中的指令、数据，增加、删减、变动软件的功能或运行效果，或者将用于上述用途的软件、方法进行运营或向公众传播，无论这些行为是否为商业目的；  （6）通过非恒信资管开发、授权的第三方软件、插件、外挂、系统，登录或使用恒信资管软件及服务，或制作、发布、传播上述工具；  （7）自行、授权他人或利用第三方软件对本软件及其组件、模块、数据等进行干扰；  注：您理解并同意：若您违反前述约定、本协议或相关法规政策，恒信资管有权不经您同意而直接解除您的好友关系；若您的单向或双向好友(简称“违规用户”)违反前述约定、本协议或相关法规政策，恒信资管有权按照本协议、相关协议或相关法规政策等，对违规用户进行处理，由此可能影响您与违规用户之间的信息交流、好友关系等以及您对本服务的使用，同时您知悉：这是恒信资管为了维护健康良好的网络环境而采取的必要措施，若由于恒信资管按照前述约定对违规用户采取措施而对您产生影响或任何损失的，您同意不追究恒信资管的任何责任或不向恒信资管主张任何权利。  （11）其他未经恒信资管明示授权、许可或违反本协议及相关协议、规则的行为。 8.4【对自己行为负责】  您充分了解并同意，并承担因使用内容而引起的所有风险，包括因对内容的正确性、完整性或实用性的依赖而产生的风险。恒信资管无s法且不会对您因前述风险而导致的任何损失或损害承担责任。  8.5【违约处理】  如果恒信资管发现或收到他人举报您有违反本协议约定的，恒信资管有权不经通知随时对相关内容进行删除、屏蔽，并采取包括但不限于暂停、暂停、终止您使用部分或全部本服务，追究法律责任等措施。  8.6【对第三方损害的处理】  您违反约定，导致任何第三方损害的，您应当独立承担责任；恒信资管因此遭受损失的，您也应当一并赔偿!"
            
            
        }
        else {
            ZSProgressHUD.showErrorText(str as! String)
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        //        self.navigationController?.navigationBar.isHidden = false
        //        navigationController?.navigationBar.subviews.first?.alpha = 1.0
        navigationController?.setNavigationBarHidden(false, animated: true)
        
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
