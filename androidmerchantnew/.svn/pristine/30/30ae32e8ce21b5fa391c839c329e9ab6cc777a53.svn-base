package com.abmm.sh.abmm.activity.Base;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.CallBackClass;
import com.abmm.sh.abmm.UtilityClass.HttpRequestClass;
import com.abmm.sh.abmm.model.LoginMessageModel;
import com.abmm.sh.abmm.model.LoginModel;
import com.abmm.sh.abmm.other.Config;
import com.abmm.sh.abmm.other.SharedPrefsUtil;

import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.http.cookie.DbCookieStore;
import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by com.abmm.sh.abmm on 16/12/21.
 * 登录
 */

public class LoginActivity extends BaseActivity {

    @ViewInject(R.id.loading_image)
    private ImageView loading_image;

    @ViewInject(R.id.linear_view)
    private LinearLayout linear_view;
    @ViewInject(R.id.btn_login)
    private TextView btn_login;
    @ViewInject(R.id.ed_username)
    private EditText ed_username;
    @ViewInject(R.id.ed_password)
    private EditText ed_password;
    private MyApplication app = MyApplication.getInstance();
    private DbCookieStore instance;
    private Timer timer;
    private int endTime;
    private long exitTime = 0;
    private Handler timeHandler = new Handler() {
        public void handleMessage(Message msg) {
            if (msg.what == 0) {


                if (endTime == 3000) {
                    getWindow().setFlags(WindowManager.LayoutParams.FIRST_APPLICATION_WINDOW,
                            WindowManager.LayoutParams.FLAG_FULLSCREEN);

                    loading_image.setVisibility(View.GONE);
                    linear_view.setVisibility(View.VISIBLE);
                } else {
                    LoginAction();
                }
            }
        }
    };

    //设置时间
    private void setTimeThread() {
        timer.schedule(new TimerTask() {

            @Override
            public void run() {
                Message message = timeHandler.obtainMessage();
                message.what = 0;
                timeHandler.sendMessage(message);
                timer.cancel();
            }
        }, endTime, 3000);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.login_activity);
        x.view().inject(this);
        app.addActivity(this);
        Bundle bundle = getIntent().getExtras();
        if (bundle != null) {
            getWindow().setFlags(WindowManager.LayoutParams.FIRST_APPLICATION_WINDOW,
                    WindowManager.LayoutParams.FLAG_FULLSCREEN);
            String username = SharedPrefsUtil.getValue(LoginActivity.this, "name", "");
            String password = SharedPrefsUtil.getValue(LoginActivity.this, "password", "");
            if (username.trim().length() > 0 && password.trim().length() > 0) {
                ed_username.setText(username);
                ed_password.setText(password);
                loading_image.setVisibility(View.GONE);
                linear_view.setVisibility(View.VISIBLE);
            }
        } else {
            timer = new Timer();

            getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                    WindowManager.LayoutParams.FLAG_FULLSCREEN);

            loading_image.setVisibility(View.VISIBLE);
            linear_view.setVisibility(View.GONE);


            String username = SharedPrefsUtil.getValue(LoginActivity.this, "name", "");
            String password = SharedPrefsUtil.getValue(LoginActivity.this, "password", "");
            if (username.trim().length() > 0 && password.trim().length() > 0) {
                ed_username.setText(username);
                ed_password.setText(password);
                endTime = 1000;
                setTimeThread();
            } else {
                endTime = 3000;
                setTimeThread();
            }

        }

    }


    private void LoginAction() {

//       showToast(LoginActivity.this,"", "");

        String[] keys = new String[]{"username", "password", "questionid"};
        String[] values = new String[]{ed_username.getText().toString(), ed_password.getText().toString(), "0"};
        HttpRequestClass.getRequest(this, keys, values, Config.api_login, new CallBackClass() {

            @Override
            public void success(Object object) {


                try {

                    JSONObject obj = (JSONObject) object;


                    LoginMessageModel lmModel = app.gson.fromJson(obj.getJSONObject("Message").toString(), LoginMessageModel.class);
                    if (lmModel.getMessageval().equals("login_succeed") && obj.getJSONObject("Variables").getString("shopname").length() > 0) {
                        app.setlModel(app.gson.fromJson(obj.getJSONObject("Variables").toString(), LoginModel.class));
                        app.setOrdercount(obj.getJSONObject("Variables").getString("ordercount"));

                        SharedPrefsUtil.putValue(LoginActivity.this, "name", ed_username.getText().toString());
                        SharedPrefsUtil.putValue(LoginActivity.this, "password", ed_password.getText().toString());
                        Intent intent = new Intent();

//                        Bundle bundle = new Bundle();
//                        bundle.putString("shopname", obj.getJSONObject("Variables").getString("shopname"));
//                        intent.putExtras(bundle);


                        intent.setClass(LoginActivity.this, BaseTabHostActivity.class);
                        startActivity(intent);
                        finish();
                        getWindow().setFlags(WindowManager.LayoutParams.FIRST_APPLICATION_WINDOW,
                                WindowManager.LayoutParams.FLAG_FULLSCREEN);

                    } else {
                        if (lmModel.getMessageval().equals("login_succeed")) {

                            Toast.makeText(x.app(), "不是商家账户，请联系爱败客服", Toast.LENGTH_LONG).show();

                        } else {

                            Toast.makeText(x.app(), lmModel.getMessagestr(), Toast.LENGTH_LONG).show();

                        }
                        getWindow().setFlags(WindowManager.LayoutParams.FIRST_APPLICATION_WINDOW,
                                WindowManager.LayoutParams.FLAG_FULLSCREEN);

                        loading_image.setVisibility(View.GONE);
                        linear_view.setVisibility(View.VISIBLE);
                    }


                } catch (JSONException e) {
                    e.printStackTrace();
                    getWindow().setFlags(WindowManager.LayoutParams.FIRST_APPLICATION_WINDOW,
                            WindowManager.LayoutParams.FLAG_FULLSCREEN);

                    loading_image.setVisibility(View.GONE);
                    linear_view.setVisibility(View.VISIBLE);
                }


                hiddenToast();

            }

            @Override
            public void fail() {
                getWindow().setFlags(WindowManager.LayoutParams.FIRST_APPLICATION_WINDOW,
                        WindowManager.LayoutParams.FLAG_FULLSCREEN);

                loading_image.setVisibility(View.GONE);
                linear_view.setVisibility(View.VISIBLE);
                hiddenToast();
            }
        });
    }

    @Event(value = {R.id.btn_login})
    private void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_login:
                if (ed_username.getText().toString().trim().length() == 0) {
                    Toast.makeText(x.app(), "请输入手机号", Toast.LENGTH_SHORT).show();
                    return;
                }
                if (ed_password.getText().toString().trim().length() == 0) {
                    Toast.makeText(x.app(), "请输入密码", Toast.LENGTH_SHORT).show();
                    return;
                }

                showToast(this, "提示", "正在加载...");
                LoginAction();
                break;
        }
    }

}
