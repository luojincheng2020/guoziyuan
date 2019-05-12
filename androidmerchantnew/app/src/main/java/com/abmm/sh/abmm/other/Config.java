package com.abmm.sh.abmm.other;

/**
 * Created by com.abmm.sh.abmm on 16/12/23.
 * 接口配置文件
 */

public class Config {
    //测试站
    public static final String base_url = "http://59.110.28.229:4444";
    //正式站
    //public static final String base_url = "http://www.aibaimm.com";
    //登录接口
    public static final String api_login = base_url + "/api/mobile/index.php?loginfield=auto&charset=utf-8&version=5&loginsubmit=yes&mobile=no&module=merchantlogin";
    //首页板块：
    public static final String api_main = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchantserverordercodelist";
    //未发货订单数
    public static final String api_order_count = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchanserverordercount";
    //验证优惠券
    public static final String api_validatecode = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchantcheckcode";
    //使用优惠券
    public static final String api_usecode = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchantusecode";
    //修改密码
    public static final String api_changepassword = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=changepwd";

    //下面是订单板块:
//订单列表
    public static final String api_orderlist = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchantservergoodsorderlist";
    //到店付订单列表
    public static final String api_daodianfu = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchantserverorderflashpaylist";
    //订单退款
    public static final String api_order_refund = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchantorderrefundgoods";
    //物流信息
    public static final String api_wuliuinfo = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=kuaidisubscribe";
    //确认发货
    public static final String api_sendorder = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchantserversetdevlivery";

    //下面是统计板块：
    //统计列表
    public static final String api_statistics = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchantitemlist";

    //优惠券详细信息
    public static final String api_code_detail = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchantservercodedetail";
    //商品详细信息
    public static final String api_goods_detail = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchantservergoodsdetail";

    //下面是财务板块:

    //财务 钱包--账户流水表
    public static final String api_moneylist = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchantbalancewaterlist";
    //积分
    public static final String api_pointslist = base_url + "/api/mobile/index.php?charset=utf-8&version=5&module=merchantpointlist";
}
