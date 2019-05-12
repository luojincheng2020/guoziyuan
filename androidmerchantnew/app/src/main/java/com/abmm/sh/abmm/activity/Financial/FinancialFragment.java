package com.abmm.sh.abmm.activity.Financial;

import android.graphics.Color;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.CallBackClass;
import com.abmm.sh.abmm.UtilityClass.HttpRequestClass;
import com.abmm.sh.abmm.activity.Base.BaseFragment;
import com.abmm.sh.abmm.activity.Base.BaseTabHostActivity;
import com.abmm.sh.abmm.adapter.PointListAdapter;
import com.abmm.sh.abmm.adapter.WalletListAdapter;
import com.abmm.sh.abmm.model.PointModel;
import com.abmm.sh.abmm.model.WalletModel;
import com.abmm.sh.abmm.other.Config;
import com.abmm.sh.abmm.view.DropDownListView;
import com.abmm.sh.abmm.view.NavigationView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by com.abmm.sh.abmm on 16/12/21.
 * 财务
 */
@ContentView(R.layout.financial_fragment)
public class FinancialFragment extends BaseFragment {
    private View rootView;//缓存Fragment view


    @ViewInject(R.id.list_caiwu)
    private DropDownListView list_caiwu;


    private TextView tx_qb;
    private TextView tx_jf;
    @ViewInject(R.id.lin_point)
    private LinearLayout lin_point;
    @ViewInject(R.id.lin_status)
    private LinearLayout lin_status;
    @ViewInject(R.id.tx_list_title)
    private TextView tx_list_title;
    @ViewInject(R.id.tx_yuer)
    private TextView tx_yuer;
    @ViewInject(R.id.tx_weiqueren)
    private TextView tx_weiqueren;
    @ViewInject(R.id.tx_totalpoint)
    private TextView tx_totalpoint;
    @ViewInject(R.id.lin_girl)
    private LinearLayout lin_girl;


    private WalletModel model;
    private PointModel model_point;

    private WalletListAdapter adapter;
    private PointListAdapter adapter_point;

    private int listViewID = 1;
    private int pageNo = 1;
    private boolean isFirstLoad;
    private NavigationView navigationView;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        if (rootView == null) {
            isFirstLoad = true;
            rootView = x.view().inject(this, inflater, container);
            app.addActivity(getActivity());


        } else {
            ViewGroup parent = (ViewGroup) rootView.getParent();
            if (parent != null) {
                parent.removeView(rootView);
            }
        }

        initView();

        initListView();
        if (listViewID == 1){
            GetStatisticsList(3);
            tx_qb.setBackgroundResource(R.drawable.text_view_left);
            tx_jf.setBackgroundResource(R.drawable.text_view_right);
            tx_qb.setTextColor(Color.parseColor("#ff537b"));
            tx_jf.setTextColor(Color.parseColor("#ffffff"));
        }else{
            GetPointList(3);
            tx_qb.setBackgroundResource(R.drawable.text_view_left_2);
            tx_jf.setBackgroundResource(R.drawable.text_view_right_2);
            tx_qb.setTextColor(Color.parseColor("#ffffff"));
            tx_jf.setTextColor(Color.parseColor("#ff537b"));
        }



        return rootView;
    }

    private void initView() {
        navigationView = (NavigationView) rootView.findViewById(R.id.nav_main);
        tx_qb = (TextView) navigationView.findViewById(R.id.tx_qb);
        tx_jf = (TextView) navigationView.findViewById(R.id.tx_jf);
        navigationView.setTitle("财务");
        navigationView.getBackView().setVisibility(View.GONE);
        navigationView.setClickCallback(new NavigationView.ClickCallback() {

            @Override
            public void onRightClick() {

            }

            @Override
            public void onBackClick() {

            }
        });
    }


    private void GetStatisticsList(final int tag) {
        if (tag == 3) {
            pageNo = 1;
            if (isFirstLoad) {
                baseActivity.showToast(getActivity(), "", "");
                isFirstLoad = false;
            }
        }
        lin_point.setVisibility(View.GONE);
        lin_status.setVisibility(View.VISIBLE);
        tx_list_title.setText("账单明细");

        String[] keys = new String[]{"page"};
        String[] values = new String[]{String.valueOf(pageNo)};
        HttpRequestClass.getRequest(getActivity(), keys, values, Config.api_moneylist, new CallBackClass() {


            @Override
            public void success(Object object) {

                try {
                    JSONObject obj = (JSONObject) (object);
                    JSONArray arr = obj.getJSONObject("Variables").getJSONArray("waterlist");
                    tx_yuer.setText(obj.getJSONObject("Variables").getString("balance"));
                    tx_weiqueren.setText(obj.getJSONObject("Variables").getString("pendingbalance"));


                    List<WalletModel> dataList = new ArrayList<WalletModel>();
                    for (int i = 0; i < arr.length(); i++) {
                        model = gson.fromJson(arr.getJSONObject(i).toString(), WalletModel.class);
                        dataList.add(model);
                    }

                    if (tag == 1) {
                        //向下翻页
                        if (dataList.size() > 0) {
                            list_caiwu.onBottomComplete(); //loaidng图消失
                            adapter.changeData(dataList, false);
                        } else {
                            list_caiwu.setHasMore(false);//不让再往下拉
                            list_caiwu.onBottomComplete(); //loaidng图消失
                            adapter.refresh();
                        }
                    } else if (tag == 2) {
                        //向上重新翻到第一页
                        list_caiwu.setHasMore(true);
                        adapter.changeData(dataList, true);
                        list_caiwu.onDropDownComplete(); //loading图消失
                    } else if (tag == 3) {
                        //页面第一次初始化
                        if (dataList.size() > 0) {
                            adapter = new WalletListAdapter(getActivity(), dataList);
                            list_caiwu.setAdapter(adapter);
                            list_caiwu.setVisibility(View.VISIBLE);
                            lin_girl.setVisibility(View.GONE);
                        } else {
                            list_caiwu.setVisibility(View.GONE);
                            lin_girl.setVisibility(View.VISIBLE);
                        }
                    }

                } catch (JSONException e) {
                    e.printStackTrace();
                } finally {
                    baseActivity.hiddenToast();
                }
            }

            @Override
            public void fail() {

            }
        });


    }

    private void initListView() {
        list_caiwu.setHeaderDividersEnabled(false);
        list_caiwu.setOnBottomListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                pageNo++;
                if (listViewID == 1) {
                    GetStatisticsList(1);

                } else {
                    GetPointList(1);
                }
            }
        });

        list_caiwu.setOnDropDownListener(new DropDownListView.OnDropDownListener() {
            @Override
            public void onDropDown() {
                pageNo = 1;
                if (listViewID == 1) {
                    GetStatisticsList(2);

                } else {
                    GetPointList(2);
                }
            }
        });
        registerForContextMenu(list_caiwu);
    }


    //积分:
    private void GetPointList(final int tag) {
        if (tag == 3) {
            pageNo = 1;
            if (isFirstLoad) {
                baseActivity.showToast(getActivity(), "", "");
                isFirstLoad = false;
            }
        }
        lin_point.setVisibility(View.VISIBLE);
        lin_status.setVisibility(View.GONE);
        tx_list_title.setText("积分明细");


        String[] keys = new String[]{"page"};
        String[] values = new String[]{String.valueOf(pageNo)};
        HttpRequestClass.getRequest(getActivity(), keys, values, Config.api_pointslist, new CallBackClass() {


            @Override
            public void success(Object object) {

                try {
                    JSONObject obj = (JSONObject) (object);
                    JSONArray arr = obj.getJSONObject("Variables").getJSONArray("pointlist");
                    tx_totalpoint.setText(obj.getJSONObject("Variables").getString("point"));
                    List<PointModel> dataList_point = new ArrayList<PointModel>();
                    for (int i = 0; i < arr.length(); i++) {
                        Log.e(i + ": ", arr.getJSONObject(i).toString());
                        model_point = gson.fromJson(arr.getJSONObject(i).toString(), PointModel.class);
                        dataList_point.add(model_point);
                    }

                    if (tag == 1) {
                        //向下翻页

                        if (dataList_point.size() > 0) {
                            list_caiwu.onBottomComplete(); //loaidng图消失
                            adapter_point.changeData(dataList_point, false);
                        } else {
                            list_caiwu.setHasMore(false);//不让再往下拉
                            list_caiwu.onBottomComplete(); //loaidng图消失
                            adapter_point.refresh();
                        }
                    } else if (tag == 2) {
                        //向上重新翻到第一页
                        list_caiwu.setHasMore(true);
                        adapter_point.changeData(dataList_point, true);
                        list_caiwu.onDropDownComplete(); //loading图消失
                    } else if (tag == 3) {
                        //页面第一次初始化
                        if (dataList_point.size() > 0) {
                            adapter_point = new PointListAdapter(getActivity(), dataList_point);
                            list_caiwu.setAdapter(adapter_point);
                            list_caiwu.setVisibility(View.VISIBLE);
                            lin_girl.setVisibility(View.GONE);
                        } else {
                            list_caiwu.setVisibility(View.GONE);
                            lin_girl.setVisibility(View.VISIBLE);
                        }
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                } finally {
                    baseActivity.hiddenToast();
                }
            }

            @Override
            public void fail() {

            }
        });

    }


    @Event(value = {R.id.tx_qb, R.id.tx_jf})
    private void onHeadClick(View view) {
        pageNo = 1;
        isFirstLoad = true;
        switch (view.getId()) {
            case R.id.tx_qb:
                listViewID = 1;
                tx_qb.setBackgroundResource(R.drawable.text_view_left);
                tx_jf.setBackgroundResource(R.drawable.text_view_right);
                tx_qb.setTextColor(Color.parseColor("#ff537b"));
                tx_jf.setTextColor(Color.parseColor("#ffffff"));
                initListView();
                GetStatisticsList(3);
                break;
            case R.id.tx_jf:
                listViewID = 2;
                tx_qb.setBackgroundResource(R.drawable.text_view_left_2);
                tx_jf.setBackgroundResource(R.drawable.text_view_right_2);
                tx_qb.setTextColor(Color.parseColor("#ffffff"));
                tx_jf.setTextColor(Color.parseColor("#ff537b"));
                initListView();
                GetPointList(3);
                break;
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        BaseTabHostActivity.getInstance().getCount();
    }
}
