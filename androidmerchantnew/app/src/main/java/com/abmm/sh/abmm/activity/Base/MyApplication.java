package com.abmm.sh.abmm.activity.Base;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.Application;
import android.app.Dialog;
import android.content.Context;
import android.os.Build;
import android.support.v4.app.Fragment;
import android.view.Window;
import android.view.WindowManager;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.model.LoginModel;
import com.abmm.sh.abmm.other.CustomProgressDialog;
import com.abmm.sh.abmm.other.SystemBarTintManager;
import com.google.gson.Gson;

import org.xutils.x;

import java.util.ArrayList;
import java.util.List;

import im.fir.sdk.FIR;

/**
 * Created by com.abmm.sh.abmm on 16/12/15.
 */

public class MyApplication extends Application {

    public static Context cxt = null;
    public static CustomProgressDialog progressDialog;
    private static MyApplication instance = null;
    private static List<Activity> activityList = new ArrayList<Activity>();
    public LoginModel lModel;//登录信息
    public Dialog dialog;
    public Gson gson = new Gson();
    private Object object = new Object();
    private String ordercount; //订单数量：

    public MyApplication() {
        super();
        synchronized (object) {
            if (instance == null)
                instance = this;
        }
    }

    public static MyApplication getInstance() {
        return instance;
    }

    public static void initSystemBar(Fragment activity) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            setTranslucentStatus(activity, true);
        }

        SystemBarTintManager tintManager = new SystemBarTintManager(activity.getActivity());

        // 激活状态栏设置
        tintManager.setStatusBarTintEnabled(true);
        tintManager.setStatusBarTintResource(R.color.white);
    }

    @TargetApi(19)

    private static void setTranslucentStatus(Fragment activity, boolean on) {

        Window win = activity.getActivity().getWindow();
        WindowManager.LayoutParams winParams = win.getAttributes();
        final int bits = WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS;
        if (on) {
            winParams.flags |= bits;
        } else {
            winParams.flags &= ~bits;
        }
        win.setAttributes(winParams);
    }

    /*
 * 提示加载
 */
    public static void showProgressDialog(Context _cxt, String title, String message) {
//        if (progressDialog == null) {
//            progressDialog = ProgressDialog.show(cxt, title, message, true, false);
//        } else if (progressDialog.isShowing()) {
//            progressDialog.setTitle(title);
//            progressDialog.setMessage(message);
//        }
//
//        progressDialog.show();


        if (cxt == null) {
            cxt = _cxt;
            progressDialog = new CustomProgressDialog(cxt, "");
        } else if (cxt != _cxt) {
            cxt = _cxt;
            progressDialog = new CustomProgressDialog(cxt, "");
        }


//        Animation mShowAction = AnimationUtils.loadAnimation(x.app(), R.anim.push_show_in);
        progressDialog.show();
//        progressDialog.startAnimation(mShowAction);

//        Animation mShowAction = new TranslateAnimation(Animation.RELATIVE_TO_SELF, 0.0f, Animation.RELATIVE_TO_SELF, 0.0f,
//                Animation.RELATIVE_TO_SELF, -6.0f, Animation.RELATIVE_TO_SELF, 0.0f);
//        mShowAction.setDuration(1500);
//        progressDialog.setAnimation(mShowAction);


    }

    /*
     * 隐藏提示加载
     */
    public static void hideProgressDialog() {

        if (progressDialog != null && progressDialog.isShowing()) {
            progressDialog.dismiss();


//            Animation mHiddenAction = AnimationUtils.loadAnimation(x.app(), R.anim.push_up_out);


            //progressDialog = null;
        }

    }

    public LoginModel getlModel() {
        return lModel;
    }

    public void setlModel(LoginModel lModel) {
        this.lModel = lModel;
    }

    public String getOrdercount() {
        return ordercount;
    }

    public void setOrdercount(String ordercount) {
        this.ordercount = ordercount;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        FIR.init(this);//使用代码崩溃监控 要设置BUG_HD_SDK_GENERAL_KEY
        x.Ext.init(this);//Xutils初始化
    }

    public void showDialog(Activity activity) {
        dialog = new Dialog(activity, R.style.loading);
        dialog.setContentView(R.layout.loading);
        dialog.show();
    }

    public void hiddenDialog(Activity activity) {
        dialog.dismiss();
    }

    public void addActivity(Activity activity) {
        activityList.add(activity);
    }

    public void finishAllActivity() {
        for (Activity activity : activityList) {
            if (activity != null)
                activity.finish();
        }
        activityList.clear();
    }

    public int getAllActivityCount() {
        return activityList.size();
    }
}
