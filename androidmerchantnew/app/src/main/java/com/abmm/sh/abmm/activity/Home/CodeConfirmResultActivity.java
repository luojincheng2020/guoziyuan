package com.abmm.sh.abmm.activity.Home;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.CallBackClass;
import com.abmm.sh.abmm.UtilityClass.HttpRequestClass;
import com.abmm.sh.abmm.activity.Base.BaseActivity;
import com.abmm.sh.abmm.model.CodeModel;
import com.abmm.sh.abmm.model.LoginMessageModel;
import com.abmm.sh.abmm.other.Config;
import com.abmm.sh.abmm.view.NavigationView;

import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

/**
 * Created by com.abmm.sh.abmm on 16/12/28.
 * 验证优惠券序列表是否成功页面
 */

public class CodeConfirmResultActivity extends BaseActivity {

    @ViewInject(R.id.lin_detail)
    private LinearLayout lin_detail;
    @ViewInject(R.id.lin_tips)
    private LinearLayout lin_tips;
    @ViewInject(R.id.lin_confirm)
    private RelativeLayout lin_confirm;
    @ViewInject(R.id.tx_code)
    private TextView tx_code;
    @ViewInject(R.id.tx_title)
    private TextView tx_title;
    @ViewInject(R.id.tx_price)
    private TextView tx_price;
    //    @ViewInject(R.id.tx_date)
//    private TextView tx_date;
    @ViewInject(R.id.tx_result)
    private TextView tx_result;
    private CodeModel model;
    @ViewInject(R.id.btn_confirm)
    private TextView btn_confirm;
    @ViewInject(R.id.tx_notice)
    private TextView tx_notice;
    private NavigationView navigationView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home_code_confirm_activity);
        x.view().inject(this);
        app.addActivity(this);
        initView();

//        Bundle bundle = getIntent().getExtras();
//        if (bundle != null) {
        model = (CodeModel) getIntent().getSerializableExtra("codedetail");
//        }

        if (model.getStatus().equals("0")) {
            SetDetail();
            lin_tips.setVisibility(View.GONE);
        } else if (model.getStatus().equals("1")) {
            lin_confirm.setVisibility(View.GONE);
            lin_detail.setVisibility(View.GONE);
            tx_result.setText("对不起，您的优惠券已被使用");
        } else if (model.getStatus().equals("2")) {
            lin_confirm.setVisibility(View.GONE);
            lin_detail.setVisibility(View.GONE);
            tx_result.setText("对不起，此优惠券已退款");

        } else if (model.getStatus().equals("3")) {
            lin_confirm.setVisibility(View.GONE);
            lin_detail.setVisibility(View.GONE);
            tx_result.setText("对不起，此优惠券已过期");

        } else if (model.getStatus().equals("-1")) {
            lin_confirm.setVisibility(View.GONE);
            lin_detail.setVisibility(View.GONE);
            tx_result.setText("对不起，无此优惠券码，请重新输入");
        }


    }

    private void initView() {
        navigationView = (NavigationView) findViewById(R.id.nav_main);
        navigationView.setTitle("验证结果");
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


    @Event(value = R.id.btn_confirm)
    private void onReturnClick(View view) {
        switch (view.getId()) {
            case R.id.btn_confirm:
                confirmCode();
                break;
        }
    }

    private void SetDetail() {
        tx_code.setText(model.getCode());
        tx_title.setText(model.getTitle());
        tx_price.setText(model.getPrice());
        tx_notice.setText(model.getNotice());
        //tx_date.setText(Utils.TimestampToDate(model.getStarttime()) + " 至 " + Utils.TimestampToDate(model.getEndtime()));
    }

    private void confirmCode() {
        showToast(this, "", "");
        String[] keys = new String[]{"code"};
        String[] values = new String[]{model.getCode()};
        HttpRequestClass.getRequest(this, keys, values, Config.api_usecode, new CallBackClass() {

            @Override
            public void success(Object object) {

                try {
                    JSONObject obj = (JSONObject) object;
                    LoginMessageModel lmModel = gson.fromJson(obj.getJSONObject("Message").toString(), LoginMessageModel.class);
                    if (lmModel.getMessageval().equals("success")) {
                        Intent it = new Intent(CodeConfirmResultActivity.this, CodeValidateSuccessActivity.class);
                        it.putExtra("code_name", model.getTitle());
                        it.putExtra("code_price", model.getPrice());
                        setResult(RESULT_OK);
                        startActivity(it);
                        finish();
                    } else {
                        Toast.makeText(x.app(), lmModel.getMessagestr(), Toast.LENGTH_LONG).show();
                    }

                } catch (JSONException e) {
                    e.printStackTrace();
                } finally {
                    hiddenToast();
                }

            }

            @Override
            public void fail() {
                hiddenToast();
            }
        });
    }

}
