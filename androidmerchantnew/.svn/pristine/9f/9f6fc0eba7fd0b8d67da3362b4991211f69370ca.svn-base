package com.abmm.sh.abmm.activity.Order;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.CallBackClass;
import com.abmm.sh.abmm.UtilityClass.HttpRequestClass;
import com.abmm.sh.abmm.activity.Base.BaseActivity;
import com.abmm.sh.abmm.model.LoginMessageModel;
import com.abmm.sh.abmm.other.Config;
import com.abmm.sh.abmm.view.NavigationView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

//物流页面
public class LogisticsActivity extends BaseActivity {

    @ViewInject(R.id.tx_company)
    private TextView tx_company;

    @ViewInject(R.id.tx_state)
    private TextView tx_state;

    @ViewInject(R.id.tx_number)
    private TextView tx_number;

    @ViewInject(R.id.lin_wuliu)
    private LinearLayout lin_wuliu;

    @ViewInject(R.id.lin_nodata)
    private LinearLayout lin_nodata;

    @ViewInject(R.id.scroll_data)
    private ScrollView scroll_data;


    private LayoutInflater inflater;


    private String itemID;
    private NavigationView navigationView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.order_logistics_activity);
        x.view().inject(this);
        app.addActivity(this);
        inflater = getLayoutInflater();
        initView();
        GetWuliuInfo();


    }

    private void initView() {
        navigationView = (NavigationView) findViewById(R.id.nav_main);
        navigationView.setTitle("物流详情");
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


    private void GetWuliuInfo() {

        if (getIntent().getStringExtra("orderid") == null) {
            return;
        }

        showToast(this, "", "");
        String[] keys = new String[]{"type", "typeid"};
        String[] values = new String[]{"merchantgoods", getIntent().getStringExtra("orderid")};
        HttpRequestClass.getRequest(this, keys, values, Config.api_wuliuinfo, new CallBackClass() {

            @Override
            public void success(Object object) {
                try {
                    JSONObject obj = (JSONObject) (object);
                    LoginMessageModel lmModel = gson.fromJson(obj.getJSONObject("Message").toString(), LoginMessageModel.class);
                    if (lmModel.getMessageval().equals("success")) {
                        JSONObject kuaididata = obj.getJSONObject("Variables").getJSONObject("kuaididata");
                        tx_company.setText(tx_company.getText() + kuaididata.getString("company"));
                        tx_number.setText(tx_number.getText() + kuaididata.getString("number"));
                        tx_state.setText(kuaididata.getString("state"));
                        JSONArray data_arr = kuaididata.getJSONArray("data");
                        if (data_arr.length() == 0) {
                            scroll_data.setVisibility(View.GONE);
                            lin_nodata.setVisibility(View.VISIBLE);
                        } else {
                            scroll_data.setVisibility(View.VISIBLE);
                            lin_nodata.setVisibility(View.GONE);
                        }
                        View view = null;
                        TextView tx_ctx;
                        TextView tx_time;

                        for (int i = 0; i < data_arr.length(); i++) {
                            view = inflater.inflate(R.layout.wuliu_detail, null);
                            tx_ctx = (TextView) view.findViewById(R.id.tx_ctx);
                            tx_time = (TextView) view.findViewById(R.id.tx_time);
                            tx_ctx.setText(data_arr.getJSONObject(i).getString("context"));
                            tx_time.setText(data_arr.getJSONObject(i).getString("time"));
                            lin_wuliu.addView(view);
                        }


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

            }
        });

    }
}
