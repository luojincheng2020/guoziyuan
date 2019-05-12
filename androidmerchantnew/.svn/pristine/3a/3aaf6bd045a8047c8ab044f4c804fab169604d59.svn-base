package com.abmm.sh.abmm.activity.Order;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.CallBackClass;
import com.abmm.sh.abmm.UtilityClass.HttpRequestClass;
import com.abmm.sh.abmm.activity.Base.BaseActivity;
import com.abmm.sh.abmm.model.LoginMessageModel;
import com.abmm.sh.abmm.model.OrderModel;
import com.abmm.sh.abmm.other.Config;
import com.abmm.sh.abmm.other.SharedPrefsUtil;
import com.abmm.sh.abmm.view.NavigationView;
import com.google.gson.Gson;

import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.text.DecimalFormat;


//发货页面
public class DeliveryActivity extends BaseActivity {


    private OrderModel model;
    @ViewInject(R.id.tx_shr)
    private TextView tx_shr;
    @ViewInject(R.id.tx_shdz)
    private TextView tx_shdz;
    @ViewInject(R.id.tx_sj)
    private TextView tx_sj;

    @ViewInject(R.id.tx_ddbh)
    private TextView tx_ddbh;

    @ViewInject(R.id.tx_xdrq)
    private TextView tx_xdrq;

    @ViewInject(R.id.tx_spmc)
    private TextView tx_spmc;

    @ViewInject(R.id.tx_spxh)
    private TextView tx_spxh;

    @ViewInject(R.id.tx_sl)
    private TextView tx_sl;

    @ViewInject(R.id.tx_hjje)
    private TextView tx_hjje;

    @ViewInject(R.id.tx_kdgs)
    private TextView tx_kdgs;

    @ViewInject(R.id.ed_kd_id)
    private EditText ed_kd_id;

    @ViewInject(R.id.btn_confirm)
    private TextView btn_confirm;

    @ViewInject(R.id.img_xiala)
    private ImageView img_xiala;


    private String[] str_express;


    private String cw = "";
    private NavigationView navigationView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.order_delivery_activity);
        x.view().inject(this);
        app.addActivity(this);

        model = (OrderModel) getIntent().getSerializableExtra("orderdetail");
        str_express = model.getExpress();
        initView();
        initData();
    }

    private void initView() {
        navigationView = (NavigationView) findViewById(R.id.nav_main);
        navigationView.setTitle("发货详情");
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

    private void initData() {
        DecimalFormat df = new DecimalFormat(".##");
        tx_shr.setText(tx_shr.getText() + model.getBuyername());
        tx_shdz.setText(tx_shdz.getText() + model.getBuyeraddress());
        tx_sj.setText(tx_sj.getText() + model.getBuyermobile());

        tx_ddbh.setText(tx_ddbh.getText() + model.getOrderid());
        tx_xdrq.setText(tx_xdrq.getText() + model.getOrdertime());
        tx_spmc.setText(tx_spmc.getText() + model.getTitle());
        tx_spxh.setText(tx_spxh.getText() + model.getType());
        tx_sl.setText(tx_sl.getText() + model.getNum());
        Double total = Double.parseDouble(model.getClearingprice()) * Double.parseDouble(model.getNum());
        tx_hjje.setText(tx_hjje.getText() + String.format("%.2f", total));


        //ed_kd_id.setText(model.getExpressno());

    }

    @Event(value = R.id.lin_kd)
    private void onKuaidiClick(View view) {

        new AlertDialog.Builder(DeliveryActivity.this).setTitle("选择快递").setItems(str_express, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                cw = str_express[which];
                tx_kdgs.setText(cw);
                //Toast.makeText(FahuoActivity.this, "您已经选择了: " + which + ":" + str_express[which],Toast.LENGTH_LONG).show();
                dialog.dismiss();

                if (tx_kdgs.getText().toString().equals("无需物流")) {
                    ed_kd_id.setText("无需物流");
                } else {
                    if (ed_kd_id.getText().toString().trim().equals("无需物流")) {
                        ed_kd_id.setText("");
                    }
                }

            }
        }).show();
    }


    @Event(value = R.id.btn_confirm)
    private void onConfirmClick(View view) {
        if (cw.equalsIgnoreCase("")) {
            Toast.makeText(x.app(), "请选择快递公司", Toast.LENGTH_SHORT).show();
            return;
        }
        if (!tx_kdgs.getText().toString().equals("无需物流")) {
            if (ed_kd_id.getText().toString().trim().length() == 0) {
                Toast.makeText(x.app(), "请输入快递单号", Toast.LENGTH_SHORT).show();
                return;
            }
        }


        showToast(this, "", "");
        String[] keys = new String[]{"orderid", "cw", "no"};
        String[] values = new String[]{model.getOrderid(), tx_kdgs.getText().toString(), ed_kd_id.getText().toString().trim()};
        HttpRequestClass.getRequest(this, keys, values, Config.api_sendorder, new CallBackClass() {

            @Override
            public void success(Object object) {
                Gson gson = new Gson();
                try {
                    JSONObject obj = (JSONObject) (object);
                    LoginMessageModel lmModel = gson.fromJson(obj.getJSONObject("Message").toString(), LoginMessageModel.class);
                    if (!lmModel.getMessageval().equalsIgnoreCase("success")) {
                        Toast.makeText(x.app(), lmModel.getMessagestr(), Toast.LENGTH_LONG).show();
                    } else {
                        Toast.makeText(x.app(), "发货成功", Toast.LENGTH_LONG).show();
                        SharedPrefsUtil.putValue(DeliveryActivity.this, "issuccess", "true");
                        finish();
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                } finally {
                    hiddenToast();
                }
            }

            @Override
            public void fail() {

            }
        });

    }
}
