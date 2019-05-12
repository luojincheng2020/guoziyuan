package com.abmm.sh.abmm.activity.Home;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.CallBackClass;
import com.abmm.sh.abmm.UtilityClass.HttpRequestClass;
import com.abmm.sh.abmm.activity.Base.BaseActivity;
import com.abmm.sh.abmm.activity.Base.LoginActivity;
import com.abmm.sh.abmm.model.LoginMessageModel;
import com.abmm.sh.abmm.other.Config;
import com.abmm.sh.abmm.other.SharedPrefsUtil;
import com.abmm.sh.abmm.view.NavigationView;

import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;


/**
 * Created by com.abmm.sh.abmm on 16/12/21.
 * 修改密码页面
 */


public class ModifyPasswordActivity extends BaseActivity {


    String oldpassowrd;
    String newpassword;
    String newpassword2;


    @ViewInject(R.id.ed_oldpassword)
    private EditText ed_oldpassword;

    @ViewInject(R.id.ed_newpassword)
    private EditText ed_newpassword;

    @ViewInject(R.id.ed_newpassword2)
    private EditText ed_newpassword2;
    private NavigationView navigationView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home_password_activity);
        x.view().inject(this);
        app.addActivity(this);
        initView();
    }

    private void initView() {
        navigationView = (NavigationView) findViewById(R.id.nav_main);
        navigationView.setTitle("修改密码");
        navigationView.setClickCallback(new NavigationView.ClickCallback() {

            @Override
            public void onRightClick() {

            }

            @Override
            public void onBackClick() {
                finish();
            }
        });
    }

    @Event(value = R.id.btn_password)
    private void onbtn_passwordClick(View view) {
        oldpassowrd = ed_oldpassword.getText().toString().trim();
        newpassword = ed_newpassword.getText().toString().trim();
        newpassword2 = ed_newpassword2.getText().toString().trim();

        if (oldpassowrd.length() == 0) {
            Toast.makeText(x.app(), "请输入旧密码", Toast.LENGTH_SHORT).show();
            return;
        }
        if (newpassword.length() == 0) {
            Toast.makeText(x.app(), "请输入新密码", Toast.LENGTH_SHORT).show();
            return;
        }
        if (newpassword2.length() == 0) {
            Toast.makeText(x.app(), "请再次输入新密码", Toast.LENGTH_SHORT).show();
            return;
        }
        if (!newpassword.equals(newpassword2)) {
            Toast.makeText(x.app(), "两次输入的新密码不一致", Toast.LENGTH_SHORT).show();
            return;
        }
        changePassword();

    }

    private void changePassword() {
        showToast(this, "", "");


        String[] keys = new String[]{"oldpwd", "pwd", "pwdcon"};
        String[] values = new String[]{oldpassowrd, newpassword, newpassword2};
        HttpRequestClass.getRequest(this, keys, values, Config.api_changepassword, new CallBackClass() {


            @Override
            public void success(Object object) {


                try {
                    JSONObject obj = (JSONObject) object;


                    LoginMessageModel lmModel = gson.fromJson(obj.getJSONObject("Message").toString(), LoginMessageModel.class);
                    if (lmModel.getMessageval().equalsIgnoreCase("success")) {
                        Toast.makeText(x.app(), "修改成功，请重新登陆！", Toast.LENGTH_LONG).show();
                        SharedPrefsUtil.putValue(ModifyPasswordActivity.this, "password", newpassword);
//                        setResult(RESULT_OK);
//                        finish();
                        Intent intent = new Intent();
                        intent.setClass(ModifyPasswordActivity.this, LoginActivity.class);
                        Bundle bundle = new Bundle();
                        bundle.putString("isHomePage", "yes");
                        intent.putExtras(bundle);
                        startActivity(intent);
                        finish();

                    } else {
                        Toast.makeText(x.app(), lmModel.getMessagestr(), Toast.LENGTH_LONG).show();
                    }


                } catch (JSONException e) {
                    e.printStackTrace();
                } finally {
                }

                hiddenToast();

            }

            @Override
            public void fail() {
                hiddenToast();
            }
        });

    }

}
