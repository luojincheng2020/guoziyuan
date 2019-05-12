package com.abmm.sh.abmm.activity.Statistical;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.ListView;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.CallBackClass;
import com.abmm.sh.abmm.UtilityClass.HttpRequestClass;
import com.abmm.sh.abmm.UtilityClass.Utils;
import com.abmm.sh.abmm.activity.Base.BaseFragment;
import com.abmm.sh.abmm.activity.Base.BaseTabHostActivity;
import com.abmm.sh.abmm.adapter.StatisticalListAdapter;
import com.abmm.sh.abmm.model.StatisticalModel;
import com.abmm.sh.abmm.other.Config;
import com.abmm.sh.abmm.view.NavigationView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by com.abmm.sh.abmm on 16/12/21.
 * 统计
 */
@ContentView(R.layout.statistical_fragment)
public class StatisticalFragment extends BaseFragment {
    private View rootView;//缓存Fragment view
    private StatisticalModel model;
    private List<StatisticalModel> dataList = new ArrayList<StatisticalModel>();
    private ListView list_tongji;
    private StatisticalListAdapter adapter;

    private boolean isFirstLoad;
    @ViewInject(R.id.lin_girl)
    private LinearLayout lin_girl;
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


        list_tongji = (ListView) rootView.findViewById(R.id.list_tongji);
        adapter = new StatisticalListAdapter(getActivity(), dataList);
        list_tongji.setAdapter(adapter);
        GetStatisticsList();
        app.addActivity(getActivity());
        return rootView;
    }

    private void initView() {
        navigationView = (NavigationView) rootView.findViewById(R.id.nav_main);
        navigationView.setTitle("统计");
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


    private void GetStatisticsList() {
        if (isFirstLoad) {
            baseActivity.showToast(getActivity(), "", "");
            isFirstLoad = false;
        }
        String[] keys = new String[]{};
        String[] values = new String[]{};
        HttpRequestClass.getRequest(getActivity(), keys, values, Config.api_statistics, new CallBackClass() {

            @Override
            public void success(Object object) {

                try {
                    JSONObject obj = (JSONObject) (object);
                    JSONArray arr = obj.getJSONObject("Variables").getJSONArray("itemlist");
                    JSONObject detailObj;
                    JSONArray detailArr;
                    dataList.clear();
                    for (int i = 0; i < arr.length(); i++) {
                        model = gson.fromJson(arr.getJSONObject(i).toString(), StatisticalModel.class);
                        if (Utils.CheckJsonStringType(arr.getJSONObject(i).getString("detail")) == 1) {
                            detailObj = arr.getJSONObject(i).getJSONObject("detail");
                            model.setPrice("¥ " + detailObj.getString("clearingprice"));
                        } else {
                            detailArr = arr.getJSONObject(i).getJSONArray("detail");
                            if (detailArr.length() > 0) {
                                detailObj = detailArr.getJSONObject(0);
                                model.setPrice("¥ " + detailObj.getString("clearingprice"));
                            }
                        }

                        dataList.add(model);

                    }
                    arr = obj.getJSONObject("Variables").getJSONArray("flashpaylist");
                    for (int i = 0; i < arr.length(); i++) {
                        detailObj = arr.getJSONObject(i);
                        model = new StatisticalModel();
                        model.setTitle(detailObj.getString("memo"));
                        model.setType("ddf");
                        model.setSalenum(detailObj.getString("salenum"));

                        dataList.add(model);

                    }

                    if (dataList.size() == 0) {
                        list_tongji.setVisibility(View.INVISIBLE);
                        lin_girl.setVisibility(View.VISIBLE);
                    } else {
                        list_tongji.setVisibility(View.VISIBLE);
                        lin_girl.setVisibility(View.GONE);
                    }

                    adapter.notifyDataSetChanged();
                } catch (JSONException e) {
                    e.printStackTrace();
                } finally {
                    baseActivity.hiddenToast();
                }


            }

            @Override
            public void fail() {
                baseActivity.hiddenToast();
            }
        });

    }


    @Override
    public void onResume() {
        super.onResume();
        BaseTabHostActivity.getInstance().getCount();
    }
}
