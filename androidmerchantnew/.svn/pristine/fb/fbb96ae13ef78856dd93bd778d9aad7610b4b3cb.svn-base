package com.abmm.sh.abmm.activity.Order;

import android.graphics.Color;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.CallBackClass;
import com.abmm.sh.abmm.UtilityClass.HttpRequestClass;
import com.abmm.sh.abmm.UtilityClass.Utils;
import com.abmm.sh.abmm.activity.Base.BaseFragment;
import com.abmm.sh.abmm.activity.Base.BaseTabHostActivity;
import com.abmm.sh.abmm.adapter.DaodianfuAdapter;
import com.abmm.sh.abmm.adapter.MainOrderAdapter;
import com.abmm.sh.abmm.adapter.OrderListAdapter;
import com.abmm.sh.abmm.model.DaodianfuModel;
import com.abmm.sh.abmm.model.LoginMessageModel;
import com.abmm.sh.abmm.model.MainOrderModel;
import com.abmm.sh.abmm.model.OrderModel;
import com.abmm.sh.abmm.other.Config;
import com.abmm.sh.abmm.other.SharedPrefsUtil;
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
 * 订单
 */
@ContentView(R.layout.order_fragment)
public class OrderFragment extends BaseFragment {
    private static final int DEFAULT_ITEM_SIZE = 20;
    private static final int ITEM_SIZE_OFFSET = 20;
    private static final int MSG_CODE_REFRESH = 0;
    private static final int MSG_CODE_LOADMORE = 1;
    private static final int TIME = 1000;
    public static String[] str_express;
    int padding;
    private View rootView;//缓存Fragment view
    private String curOrderType = "no";
    private OrderListAdapter adapter;
    private OrderModel model;
    private MainOrderModel orderModel;
    private MainOrderAdapter yhqAdapter;
    private DaodianfuModel daodianfuModel;
    private DaodianfuAdapter ddfAdapter;
    @ViewInject(R.id.lin_girl)
    private LinearLayout lin_girl;
    @ViewInject(R.id.tx_quanbu)
    private TextView tx_quanbu;
    @ViewInject(R.id.tx_daifahuo)
    private TextView tx_daifahuo;
    @ViewInject(R.id.tx_yifahuo)
    private TextView tx_yifahuo;
    @ViewInject(R.id.tx_qb_count)
    private TextView tx_qb_count;
    @ViewInject(R.id.tx_yfh_count)
    private TextView tx_yfh_count;
    @ViewInject(R.id.lin_quanbu)
    private LinearLayout lin_quanbu;
    @ViewInject(R.id.lin_dfh)
    private LinearLayout lin_dfh;
    @ViewInject(R.id.lin_yfh)
    private LinearLayout lin_yfh;
    private TextView tx_sp;
    private TextView tx_yhq;
    private TextView tx_ddf;
    @ViewInject(R.id.lin_status)
    private LinearLayout lin_status;
    @ViewInject(R.id.list_order)
    private DropDownListView list_order;
    @ViewInject(R.id.list_yhq)
    private DropDownListView list_yhq;
    @ViewInject(R.id.list_ddf)
    private DropDownListView list_ddf;
    @ViewInject(R.id.lin_yqjl)
    private LinearLayout lin_yqjl;
    @ViewInject(R.id.lin_ddfl)
    private LinearLayout lin_ddfl;
    @ViewInject(R.id.dfh_count)
    private TextView dfh_count;
    private boolean isFirstLoad;
    private int pageNo = 1;
    private NavigationView navigationView;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        if (rootView == null) {
            rootView = x.view().inject(this, inflater, container);
            app.addActivity(getActivity());
        } else {
            ViewGroup parent = (ViewGroup) rootView.getParent();
            if (parent != null) {
                parent.removeView(rootView);
            }
        }

        padding = Utils.dip2px(getActivity(), 5);
        initView();
        initListView();

        dfh();//显示代发货页面
        setGoodView();

        app.addActivity(getActivity());

        return rootView;
    }

    private void initView() {
        navigationView = (NavigationView) rootView.findViewById(R.id.nav_main);
        tx_sp = (TextView) navigationView.findViewById(R.id.tx_sp);
        tx_yhq = (TextView) navigationView.findViewById(R.id.tx_yhq);
        tx_ddf = (TextView) navigationView.findViewById(R.id.tx_ddf);
        navigationView.getTitleView().setVisibility(View.GONE);
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

    private void setGoodView() {
        lin_status.setVisibility(View.VISIBLE);
        tx_sp.setBackgroundResource(R.drawable.text_view_left);
        tx_yhq.setBackgroundResource(R.drawable.text_view_center);
        tx_ddf.setBackgroundResource(R.drawable.text_view_right);
        tx_sp.setTextColor(Color.parseColor("#ff537b"));
        tx_yhq.setTextColor(Color.parseColor("#ffffff"));
//        tx_yhq.setPadding(padding*2,padding*2,padding,padding);
        tx_ddf.setTextColor(Color.parseColor("#ffffff"));
        list_order.setVisibility(View.GONE);
        list_yhq.setVisibility(View.GONE);
        list_ddf.setVisibility(View.GONE);
        lin_yqjl.setVisibility(View.GONE);
        lin_ddfl.setVisibility(View.GONE);
    }

    private void initListView() {
        list_ddf.setHeaderDividersEnabled(false);
        list_ddf.setOnBottomListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                pageNo++;
                GetDdfData(1);
            }
        });

        list_ddf.setOnDropDownListener(new DropDownListView.OnDropDownListener() {
            @Override
            public void onDropDown() {
                pageNo = 1;
                GetDdfData(2);
            }
        });
        registerForContextMenu(list_ddf);


        list_yhq.setHeaderDividersEnabled(false);
        list_yhq.setOnBottomListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                pageNo++;
                GetYhqData(1);
            }
        });

        list_yhq.setOnDropDownListener(new DropDownListView.OnDropDownListener() {
            @Override
            public void onDropDown() {
                pageNo = 1;
                GetYhqData(2);
            }
        });
        registerForContextMenu(list_yhq);


        list_order.setHeaderDividersEnabled(false);
        list_order.setOnBottomListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                pageNo++;
                GetOrderList(curOrderType, 1);
            }
        });

        list_order.setOnDropDownListener(new DropDownListView.OnDropDownListener() {
            @Override
            public void onDropDown() {
                pageNo = 1;
                GetOrderList(curOrderType, 2);
            }
        });
        registerForContextMenu(list_order);
    }


    //全部：
    private void allgoodsOrder() {
        lin_quanbu.setBackgroundResource(R.drawable.order_tx_bg);
        lin_dfh.setBackgroundResource(0);
        lin_yfh.setBackgroundResource(0);
        tx_quanbu.setTextColor(Color.parseColor("#ff537b"));
        tx_yifahuo.setTextColor(Color.parseColor("#000000"));
        tx_daifahuo.setTextColor(Color.parseColor("#000000"));
        GetOrderList("all", 3);
    }

    //待发货:
    public void dfh() {
        lin_dfh.setBackgroundResource(R.drawable.order_tx_bg);
        lin_quanbu.setBackgroundResource(0);
        lin_yfh.setBackgroundResource(0);
        tx_quanbu.setTextColor(Color.parseColor("#000000"));
        tx_yifahuo.setTextColor(Color.parseColor("#000000"));
        tx_daifahuo.setTextColor(Color.parseColor("#ff537b"));
        GetOrderList("no", 3);
    }

    //已发货:
    public void yfh() {
        lin_yfh.setBackgroundResource(R.drawable.order_tx_bg);
        lin_dfh.setBackgroundResource(0);
        lin_quanbu.setBackgroundResource(0);
        tx_quanbu.setTextColor(Color.parseColor("#000000"));
        tx_yifahuo.setTextColor(Color.parseColor("#ff537b"));
        tx_daifahuo.setTextColor(Color.parseColor("#000000"));
        GetOrderList("yes", 3);
    }

    @Event(value = {R.id.lin_quanbu, R.id.lin_dfh, R.id.lin_yfh, R.id.tx_sp, R.id.tx_yhq, R.id.tx_ddf})
    private void onClick(View view) {
        pageNo = 1;
        isFirstLoad = true;
        switch (view.getId()) {
            case R.id.lin_quanbu:
                allgoodsOrder();
                break;
            case R.id.lin_dfh:
                dfh();
                break;
            case R.id.lin_yfh:
                yfh();
                break;

            case R.id.tx_sp:
                getGoodsOrderList();
                break;
            case R.id.tx_yhq:
                getYhq();
                break;
            case R.id.tx_ddf:
                getDdf();
                break;

        }
    }

    //点击商品:
    private void getGoodsOrderList() {
        lin_status.setVisibility(View.VISIBLE);
        tx_sp.setBackgroundResource(R.drawable.text_view_left);
        tx_yhq.setBackgroundResource(R.drawable.text_view_center);
        tx_ddf.setBackgroundResource(R.drawable.text_view_right);
        tx_sp.setTextColor(Color.parseColor("#ff537b"));
        tx_yhq.setTextColor(Color.parseColor("#ffffff"));
//        tx_yhq.setPadding(padding*2,padding*2,padding,padding);
        tx_ddf.setTextColor(Color.parseColor("#ffffff"));
        list_order.setVisibility(View.GONE);
        list_yhq.setVisibility(View.GONE);
        list_ddf.setVisibility(View.GONE);
        lin_yqjl.setVisibility(View.GONE);
        lin_ddfl.setVisibility(View.GONE);
        GetOrderList(curOrderType, 3);
    }

    //点击优惠券:
    private void getYhq() {
        lin_status.setVisibility(View.GONE);
        tx_sp.setBackgroundResource(R.drawable.text_view_left_2);
        tx_yhq.setBackgroundResource(R.drawable.text_view_center_2);
        tx_ddf.setBackgroundResource(R.drawable.text_view_right);
//        tx_yhq.setPadding(padding,padding,padding,padding);
        tx_sp.setTextColor(Color.parseColor("#ffffff"));
        tx_yhq.setTextColor(Color.parseColor("#ff537b"));
        tx_ddf.setTextColor(Color.parseColor("#ffffff"));
        list_order.setVisibility(View.GONE);
        list_yhq.setVisibility(View.GONE);
        list_ddf.setVisibility(View.GONE);
        lin_yqjl.setVisibility(View.VISIBLE);
        lin_ddfl.setVisibility(View.GONE);
        GetYhqData(3);
    }

    //点击到店付
    private void getDdf() {
        lin_status.setVisibility(View.GONE);
        tx_sp.setBackgroundResource(R.drawable.text_view_left_2);
        tx_yhq.setBackgroundResource(R.drawable.text_view_center);
        tx_ddf.setBackgroundResource(R.drawable.text_view_right_2);
//        tx_yhq.setPadding(padding,padding,padding,padding);
        tx_sp.setTextColor(Color.parseColor("#ffffff"));
        tx_yhq.setTextColor(Color.parseColor("#ffffff"));
        tx_ddf.setTextColor(Color.parseColor("#ff537b"));
        list_order.setVisibility(View.GONE);
        list_yhq.setVisibility(View.GONE);
        list_ddf.setVisibility(View.GONE);
        lin_ddfl.setVisibility(View.VISIBLE);
        lin_yqjl.setVisibility(View.GONE);
        GetDdfData(3);
    }


    private void GetOrderList(final String type, final int tag) {
        if (tag == 3) {
            pageNo = 1;
            if (isFirstLoad) {
                baseActivity.showToast(getActivity(), "", "");
                isFirstLoad = false;
            }
        }
        curOrderType = type;


        String[] keys = new String[]{"page", "type"};
        String[] values = new String[]{String.valueOf(pageNo), type};
        HttpRequestClass.getRequest(getActivity(), keys, values, Config.api_orderlist, new CallBackClass() {

            @Override
            public void success(Object object) {

                try {

                    JSONObject obj = (JSONObject) (object);
                    JSONArray arr = obj.getJSONObject("Variables").getJSONArray("orderlist");
                    if (type.equals("no")) {
                        int count = Integer.valueOf(obj.getJSONObject("Variables").getString("count"));
                        if (count != 0) {
                            dfh_count.setText(String.valueOf(count));
                            dfh_count.setVisibility(View.VISIBLE);
                            app.setOrdercount(String.valueOf(count));
                            BaseTabHostActivity.getInstance().SetOrderCount();
                        } else {
                            app.setOrdercount(String.valueOf(count));
                            BaseTabHostActivity.getInstance().SetOrderCount();
                            dfh_count.setVisibility(View.GONE);
                        }
                    }
                    JSONObject oneOrder;

                    List<OrderModel> orderList = new ArrayList<OrderModel>();
                    for (int i = 0; i < arr.length(); i++) {
                        oneOrder = arr.getJSONObject(i);
                        model = gson.fromJson(oneOrder.toString(), OrderModel.class);
                        model.setPrice(oneOrder.getJSONObject("detail").getString("price"));
                        model.setClearingprice(oneOrder.getJSONObject("detail").getString("clearingprice"));
                        model.setNum(oneOrder.getJSONObject("detail").getString("num"));
                        model.setType(oneOrder.getJSONObject("detail").getString("type"));
                        model.setPic(oneOrder.getJSONObject("detail").getString("pic"));
                        model.setTitle(oneOrder.getJSONObject("detail").getJSONObject("title").getString("title"));
                        orderList.add(model);
                    }


                    arr = obj.getJSONObject("Variables").getJSONArray("express");
                    str_express = new String[arr.length() + 1];
                    for (int i = 0; i < arr.length() + 1; i++) {
                        if (i < arr.length()) {
                            str_express[i] = arr.getJSONObject(i).getString("cw");
                        }
                        if (i == arr.length()) {
                            str_express[i] = "无需物流";
                        }


                    }


//                    application.setExpress(str_express);

                    if (tag == 1) {
                        //向下翻页
                        if (orderList.size() > 0) {
                            list_order.onBottomComplete(); //loaidng图消失
                            adapter.changeData(orderList, false);
                        } else {
                            list_order.setHasMore(false);//不让再往下拉
                            list_order.onBottomComplete(); //loaidng图消失
                            adapter.refresh();
                        }

                    } else if (tag == 2) {
                        //向上重新翻到第一页
                        list_order.setHasMore(true);
                        adapter.changeData(orderList, true);
                        list_order.onDropDownComplete(); //loading图消失
                    } else if (tag == 3) {
                        //页面第一次初始化
                        if (orderList.size() > 0) {
                            adapter = new OrderListAdapter(getActivity(), orderList, OrderFragment.this);
                            list_order.setAdapter(adapter);
                            list_order.setVisibility(View.VISIBLE);
                            lin_girl.setVisibility(View.GONE);
                        } else {
                            list_order.setVisibility(View.GONE);
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

    private void GetYhqData(final int tag) {

        if (tag == 3) {
            pageNo = 1;
            if (isFirstLoad) {
                baseActivity.showToast(getActivity(), "", "");
                isFirstLoad = false;
            }
        }


        String[] keys = new String[]{"page"};
        String[] values = new String[]{String.valueOf(pageNo)};
        HttpRequestClass.getRequest(getActivity(), keys, values, Config.api_main, new CallBackClass() {


            @Override
            public void success(Object object) {
                try {
                    JSONObject obj = (JSONObject) (object);
                    LoginMessageModel lmModel = gson.fromJson(obj.getJSONObject("Message").toString(), LoginMessageModel.class);
                    if (lmModel.getMessageval().equals("success")) {
                        JSONArray orderArr = obj.getJSONObject("Variables").getJSONArray("oderlist");

                        List<MainOrderModel> yhqList = new ArrayList<MainOrderModel>();
                        for (int i = 0; i < orderArr.length(); i++) {
                            orderModel = gson.fromJson(orderArr.get(i).toString(), MainOrderModel.class);
                            yhqList.add(orderModel);
                        }

                        if (tag == 1) {
                            //向下翻页
                            if (yhqList.size() > 0) {
                                list_yhq.onBottomComplete(); //loaidng图消失
                                yhqAdapter.changeData(yhqList, false);
                            } else {
                                list_yhq.setHasMore(false);//不让再往下拉
                                list_yhq.onBottomComplete(); //loaidng图消失
                                yhqAdapter.refresh();
                            }

                        } else if (tag == 2) {
                            //向上重新翻到第一页
                            list_yhq.setHasMore(true);
                            yhqAdapter.changeData(yhqList, true);
                            list_yhq.onDropDownComplete(); //loading图消失
                        } else if (tag == 3) {
                            //页面第一次初始化
                            if (yhqList.size() > 0) {
                                yhqAdapter = new MainOrderAdapter(getActivity(), yhqList);
                                list_yhq.setAdapter(yhqAdapter);
                                list_yhq.setVisibility(View.VISIBLE);
                                lin_girl.setVisibility(View.GONE);
                            } else {
                                list_yhq.setVisibility(View.GONE);
                                lin_girl.setVisibility(View.VISIBLE);
                            }
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

    private void GetDdfData(final int tag) {
        if (tag == 3) {
            pageNo = 1;
            if (isFirstLoad) {
                baseActivity.showToast(getActivity(), "", "");
                isFirstLoad = false;
            }
        }

        String[] keys = new String[]{"page"};
        String[] values = new String[]{String.valueOf(pageNo)};
        HttpRequestClass.getRequest(getActivity(), keys, values, Config.api_daodianfu, new CallBackClass() {


            @Override
            public void success(Object object) {
                try {
                    JSONObject obj = (JSONObject) (object);
                    JSONArray orderArr = obj.getJSONObject("Variables").getJSONArray("oderlist");
                    List<DaodianfuModel> ddfList = new ArrayList<DaodianfuModel>();
                    for (int i = 0; i < orderArr.length(); i++) {
                        daodianfuModel = gson.fromJson(orderArr.get(i).toString(), DaodianfuModel.class);
                        ddfList.add(daodianfuModel);
                    }

                    if (tag == 1) {
                        //向下翻页
                        if (ddfList.size() > 0) {
                            list_ddf.onBottomComplete(); //loaidng图消失
                            ddfAdapter.changeData(ddfList, false);
                        } else {
                            list_ddf.setHasMore(false);//不让再往下拉
                            list_ddf.onBottomComplete(); //loaidng图消失
                            ddfAdapter.refresh();
                        }

                    } else if (tag == 2) {
                        //向上重新翻到第一页
                        list_ddf.setHasMore(true);
                        ddfAdapter.changeData(ddfList, true);
                        list_ddf.onDropDownComplete(); //loading图消失
                    } else if (tag == 3) {
                        //页面第一次初始化
                        if (ddfList.size() > 0) {
                            ddfAdapter = new DaodianfuAdapter(getActivity(), ddfList);
                            list_ddf.setAdapter(ddfAdapter);
                            list_ddf.setVisibility(View.VISIBLE);
                            lin_girl.setVisibility(View.GONE);
                        } else {
                            list_ddf.setVisibility(View.GONE);
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

    @Override
    public void onResume() {
        super.onResume();
        String result = SharedPrefsUtil.getValue(getActivity(), "issuccess", "");
        if (result.equals("true")) {
            GetOrderList("no", 3);
            SharedPrefsUtil.putValue(getActivity(), "issuccess", "");
        }
    }
}
