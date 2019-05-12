package com.abmm.sh.abmm.activity.Home;

import android.os.Bundle;
import android.widget.TextView;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.Utils;
import com.abmm.sh.abmm.activity.Base.BaseActivity;
import com.abmm.sh.abmm.view.NavigationView;

import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

/**
 * Created by com.abmm.sh.abmm on 16/12/28.
 * 验证优惠券成功的页面
 */

public class CodeValidateSuccessActivity extends BaseActivity {

    @ViewInject(R.id.tx_code_name)
    private TextView tx_code_name;
    @ViewInject(R.id.tx_code_price)
    private TextView tx_code_price;
    private NavigationView navigationView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home_code_validate_success);
        x.view().inject(this);
        app.addActivity(this);
        initView();
        tx_code_name.setText(getIntent().getStringExtra("code_name"));
        tx_code_price.setText(Utils.AddMoney(getIntent().getStringExtra("code_price")));

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
}
