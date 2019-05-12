package com.abmm.sh.abmm.activity.Statistical;

import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.CallBackClass;
import com.abmm.sh.abmm.UtilityClass.HttpRequestClass;
import com.abmm.sh.abmm.activity.Base.BaseActivity;
import com.abmm.sh.abmm.adapter.ImagePlayerAdapter;
import com.abmm.sh.abmm.model.LoginMessageModel;
import com.abmm.sh.abmm.other.Config;
import com.abmm.sh.abmm.view.NavigationView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.image.ImageOptions;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;

import cn.trinea.android.view.autoscrollviewpager.AutoScrollViewPager;


public class CodeDetailActivity extends BaseActivity {

    private String itemID;
    private ImagePlayerAdapter adapter;
    private ImageOptions imageOptions;

    @ViewInject(R.id.tx_status)
    private TextView tx_status;

    @ViewInject(R.id.tx_sale)
    private TextView tx_sale;

    @ViewInject(R.id.tx_clearprice)
    private TextView tx_clearprice;

    @ViewInject(R.id.tx_mprice)
    private TextView tx_mprice;

    @ViewInject(R.id.lin_xiangqing)
    private LinearLayout lin_xiangqing;

    @ViewInject(R.id.tx_xuzhi)
    private TextView tx_xuzhi;

    @ViewInject(R.id.tx_jiezhi)
    private TextView tx_jiezhi;

    @ViewInject(R.id.tx_start)
    private TextView tx_start;

    @ViewInject(R.id.tx_end)
    private TextView tx_end;
    @ViewInject(R.id.code_scrollview)
    private ScrollView code_scrollview;
    private NavigationView navigationView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.statistical_code_detail_activity);
        x.view().inject(this);
        app.addActivity(this);
        initView();
        itemID = getIntent().getStringExtra("itemid");
        Log.e("", itemID);
        imageOptions = new ImageOptions.Builder()
                //.setSize(DensityUtil.dip2px(500), DensityUtil.dip2px(160))
                //.setRadius(DensityUtil.dip2px(5))
                // 如果ImageView的大小不是定义为wrap_content, 不要crop.
                //.setCrop(true) // 很多时候设置了合适的scaleType也不需要它.
                // 加载中或错误图片的ScaleType
                //.setPlaceholderScaleType(ImageView.ScaleType.MATRIX)
                .setImageScaleType(ImageView.ScaleType.FIT_XY)
                .setLoadingDrawableId(R.drawable.codepic)
                .setFailureDrawableId(R.drawable.codepic)
                .build();
        GetCodeDetail();


    }

    private void initView() {
        navigationView = (NavigationView) findViewById(R.id.nav_main);
        navigationView.setTitle("优惠券统计详情");
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


    private void GetCodeDetail() {


        showToast(this, "", "");
        String[] keys = new String[]{"itemid"};
        String[] values = new String[]{itemID};
        HttpRequestClass.getRequest(CodeDetailActivity.this, keys, values, Config.api_code_detail, new CallBackClass() {
            @Override
            public void success(Object object) {
                try {

                    Animation mShowAction = AnimationUtils.loadAnimation(x.app(), R.anim.push_show_in);
                    code_scrollview.setVisibility(View.VISIBLE);
                    code_scrollview.startAnimation(mShowAction);

                    JSONObject obj = (JSONObject) (object);
                    LoginMessageModel lmModel = gson.fromJson(obj.getJSONObject("Message").toString(), LoginMessageModel.class);
                    if (lmModel.getMessageval().equals("success")) {
                        ArrayList imageURL = new ArrayList<String>();
                        ArrayList titleList1 = new ArrayList<String>();
                        ArrayList titleList2 = new ArrayList<String>();
                        JSONArray pic_arr = obj.getJSONObject("Variables").getJSONObject("item").getJSONArray("pic");
                        for (int i = 0; i < pic_arr.length(); i++) {
                            imageURL.add(pic_arr.getJSONObject(i).getString("bigurl"));
                            Log.e("", pic_arr.getJSONObject(i).getString("bigurl"));
                            titleList1.add(obj.getJSONObject("Variables").getJSONObject("item").getString("title"));
                            titleList2.add(obj.getJSONObject("Variables").getJSONObject("item").getString("memo"));


                        }

                        adapter = new ImagePlayerAdapter(CodeDetailActivity.this, imageURL, titleList1, titleList2);
                        AutoScrollViewPager viewPager = (AutoScrollViewPager) findViewById(R.id.view_pager);
                        viewPager.setAdapter(adapter);
                        viewPager.setInterval(2000);
                        viewPager.startAutoScroll();


                        tx_status.setText(obj.getJSONObject("Variables").getJSONObject("item").getString("status"));
                        tx_sale.setText(obj.getJSONObject("Variables").getJSONObject("item").getString("salenum"));
                        tx_clearprice.setText(obj.getJSONObject("Variables").getJSONObject("item").getJSONObject("detail").getString("clearingprice"));
                        tx_mprice.setText(obj.getJSONObject("Variables").getJSONObject("item").getJSONObject("detail").getString("marketprice"));
                        tx_xuzhi.setText(obj.getJSONObject("Variables").getJSONObject("item").getString("notice"));
                        tx_start.setText(obj.getJSONObject("Variables").getJSONObject("item").getString("starttime"));
                        tx_end.setText(obj.getJSONObject("Variables").getJSONObject("item").getString("endtime"));
                        tx_jiezhi.setText(obj.getJSONObject("Variables").getJSONObject("item").getJSONObject("detail").getString("expiredate"));

                        JSONArray con_arr = obj.getJSONObject("Variables").getJSONObject("item").getJSONArray("content");
                        TextView tx;
                        ImageView img;
                        for (int i = 0; i < con_arr.length(); i++) {
                            if (con_arr.getJSONObject(i).getString("type").equalsIgnoreCase("txt")) {
                                tx = new TextView(CodeDetailActivity.this);
                                tx.setText(con_arr.getJSONObject(i).getString("content"));
                                tx.setTextColor(Color.parseColor("#000000"));
                                lin_xiangqing.addView(tx);
                            } else {
                                img = new ImageView(CodeDetailActivity.this);
                                x.image().bind(img, con_arr.getJSONObject(i).getString("url"), imageOptions);
                                lin_xiangqing.addView(img);

                            }
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
