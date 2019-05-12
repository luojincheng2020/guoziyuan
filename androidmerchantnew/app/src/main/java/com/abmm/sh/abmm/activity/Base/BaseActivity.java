package com.abmm.sh.abmm.activity.Base;

import android.content.Context;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.KeyEvent;
import android.widget.Toast;

import com.google.gson.Gson;

import org.xutils.x;

public class BaseActivity extends AppCompatActivity {
    protected Gson gson = new Gson();
    protected MyApplication app = MyApplication.getInstance();
    private long exitTime = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        setContentView(R.layout.home_page_fragment);
    }


    public void showToast(Context context, String titleString, String messageString) {
        MyApplication.showProgressDialog(context, titleString, messageString);
    }

    public void hiddenToast() {
        MyApplication.hideProgressDialog();
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
