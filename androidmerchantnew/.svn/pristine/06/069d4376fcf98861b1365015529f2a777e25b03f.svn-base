package com.abmm.sh.abmm.activity.Base;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentTabHost;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TabHost;
import android.widget.TextView;
import android.widget.Toast;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.CallBackClass;
import com.abmm.sh.abmm.UtilityClass.HttpRequestClass;
import com.abmm.sh.abmm.activity.Financial.FinancialFragment;
import com.abmm.sh.abmm.activity.Home.HomePageFragment;
import com.abmm.sh.abmm.activity.Order.OrderFragment;
import com.abmm.sh.abmm.activity.Statistical.StatisticalFragment;
import com.abmm.sh.abmm.other.Config;

import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.x;

import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by com.abmm.sh.abmm on 16/12/21.
 * 组装4个板块的FragmentActivity
 */

public class BaseTabHostActivity extends FragmentActivity implements TabHost.OnTabChangeListener {
    public static FragmentTabHost mTabHost;
    private static BaseTabHostActivity instance = null;
    static private int timenow = 0;
    public TextView countTextView;//订单数量
    protected MyApplication app = MyApplication.getInstance();
    private long exitTime = 0;
    private Object object = new Object();
    private LayoutInflater layoutInflater;
    private Class<?> fragmentArray[] = {HomePageFragment.class, OrderFragment.class, StatisticalFragment.class, FinancialFragment.class};
    private int noMSGImageViewArray[] = {R.drawable.bottom_tab_item_home, R.drawable.bottom_tab_item_order, R.drawable.bottom_tab_item_statistiacl, R.drawable.bottom_tab_item_financial};
    private String mTextviewArray[] = {"首页", "订单", "统计", "财务"};
    //定时从服务器上获取订单个数的handler
    private Handler handler = new Handler() {
        public void handleMessage(android.os.Message msg) {
            switch (msg.what) {
                case 0:
                    getCount();
                    break;
                default:
                    break;
            }
        }
    };

    public BaseTabHostActivity() {
        super();
        synchronized (object) {
            if (instance == null)
                instance = this;
        }
    }

    public static BaseTabHostActivity getInstance() {
        return instance;
    }

    //定时从服务器上获取个数的线程
    private void getCountThread() {
        Timer timer = new Timer();
        timer.schedule(new TimerTask() {

            @Override
            public void run() {
                Message message = handler.obtainMessage();
                message.what = 0;
                handler.sendMessage(message);
            }
        }, 0, 600000);//600000
    }


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bottom);
        initView();
        getCount();
        getCountThread();
    }


    private void initView() {

        // 实例化布局对象
        layoutInflater = LayoutInflater.from(this);
        // 实例化TabHost对象，得到TabHost
        mTabHost = (FragmentTabHost) findViewById(android.R.id.tabhost);
        mTabHost.setup(this, getSupportFragmentManager(), R.id.realtabcontent);
        mTabHost.setOnTabChangedListener(this);

        // 得到fragment的个数
        int count = fragmentArray.length;
        for (int i = 0; i < count; i++) {
            // 为每一个Tab按钮设置图标、文字和内容
            TabHost.TabSpec tabSpec = mTabHost.newTabSpec(mTextviewArray[i]).setIndicator(getTabItemView(i));
            // 将Tab按钮添加进Tab选项卡中
            mTabHost.addTab(tabSpec, fragmentArray[i], null);
            // 设置Tab按钮的背景
            mTabHost.getTabWidget().getChildAt(i).setBackgroundResource(R.drawable.bottom_tab_item_bg);
            //设置分割线为白色：
            mTabHost.getTabWidget().setDividerDrawable(R.color.white);
            mTabHost.setTag(i);
        }
    }

    private View getTabItemView(int index) {
        View view = layoutInflater.inflate(R.layout.tab_content, null);
        ImageView imageView = (ImageView) view.findViewById(R.id.tab_imageview);
        imageView.setImageResource(noMSGImageViewArray[index]);
        TextView textView = (TextView) view.findViewById(R.id.tab_textview);
        textView.setText(mTextviewArray[index]);
        if (index == 1) {
            if (countTextView == null) {
                countTextView = (TextView) view.findViewById(R.id.tab_have_new_count);
            }
        }
        return view;
    }


    @Override
    public void onTabChanged(String tabId) {

    }


    //获取未发货订单数量
    public void getCount() {

        String[] keys = new String[]{};
        String[] values = new String[]{};

        HttpRequestClass.getRequest(x.app(), keys, values, Config.api_order_count, new CallBackClass() {


            @Override
            public void success(Object object) {


                try {
                    JSONObject obj = (JSONObject) object;
                    app.setOrdercount(obj.getJSONObject("Variables").getString("ordercount"));
                    SetOrderCount();

                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void fail() {

            }
        });

    }

    public void SetOrderCount() {

//        View view = layoutInflater.inflate(R.layout.tab_content, null);
//        countTextView = (TextView) view.findViewById(R.id.tab_have_new_count);

        if (app.getOrdercount().equalsIgnoreCase("0")) {
            countTextView.setVisibility(View.GONE);
        } else {
            countTextView.setVisibility(View.VISIBLE);
            countTextView.setText(app.getOrdercount());
        }
    }

    //退出整个APP,双击2次退出整个APP
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (KeyEvent.KEYCODE_BACK == keyCode) {
            // 判断是否在两秒之内连续点击返回键，是则退出，否则不退出
            if (System.currentTimeMillis() - exitTime > 2000) {

                Toast.makeText(x.app(), "再按一次退出程序", Toast.LENGTH_LONG).show();
                // 将系统当前的时间赋值给exitTime
                exitTime = System.currentTimeMillis();
            } else {
                app.finishAllActivity();
            }
            return true;
        }
        return false;
    }

}
