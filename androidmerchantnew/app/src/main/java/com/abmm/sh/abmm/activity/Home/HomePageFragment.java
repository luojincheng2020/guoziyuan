package com.abmm.sh.abmm.activity.Home;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.CallBackClass;
import com.abmm.sh.abmm.UtilityClass.HttpRequestClass;
import com.abmm.sh.abmm.activity.Base.BaseFragment;
import com.abmm.sh.abmm.activity.Base.BaseTabHostActivity;
import com.abmm.sh.abmm.activity.Base.LoginActivity;
import com.abmm.sh.abmm.adapter.MainOrderAdapter;
import com.abmm.sh.abmm.model.CodeModel;
import com.abmm.sh.abmm.model.LoginMessageModel;
import com.abmm.sh.abmm.model.MainOrderModel;
import com.abmm.sh.abmm.other.Config;
import com.abmm.sh.abmm.view.DropDownListView;
import com.abmm.sh.abmm.view.NavigationView;
import com.abmm.sh.abmm.zxing.CaptureActivity;
import com.abmm.sh.abmm.zxing.Intents;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.http.cookie.DbCookieStore;
import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by com.abmm.sh.abmm on 16/12/21.
 * 首页
 */
@ContentView(R.layout.home_page_fragment)
public class HomePageFragment extends BaseFragment {
    InputMethodManager manager;
    private View rootView;//缓存Fragment view
    @ViewInject(R.id.tx_blance)
    private TextView tx_blance;
    @ViewInject(R.id.tx_pendingbalance)
    private TextView tx_pendingbalance;
    private String blance;
    private String pendingbalance;
    private String title;
    private MainOrderModel orderModel;
    private MainOrderAdapter adapter;
    @ViewInject(R.id.btn_confirm)
    private TextView btn_confirm;
    private CodeModel codeModel = new CodeModel();
    private ImageView index_icon_1;
    private ImageView index_icon_2;
    @ViewInject(R.id.lin_profile)
    private LinearLayout lin_profile;

    @ViewInject(R.id.edittext_code)
    private EditText edit_code;

    @ViewInject(R.id.lin_girl)
    private LinearLayout lin_girl;

    @ViewInject(R.id.list_order)
    private DropDownListView list_order;

    private boolean isFirstLoad;

    private int pageNo = 1;
    private NavigationView navigationView;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
//        return super.onCreateView(inflater, container, savedInstanceState);


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
        initListView();//设置上拉下拉加载
        loadData(3);//获取数据
        return rootView;
    }

    private void initView() {
        navigationView = (NavigationView) rootView.findViewById(R.id.nav_main);


//        Bundle bundle = getActivity().getIntent().getExtras();
//        if (bundle != null) {
//            navigationView.setTitle(bundle.getString("shopname"));
//        }


        //扫一扫:
        index_icon_1 = (ImageView) navigationView.findViewById(R.id.img_icon_1);

        index_icon_1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent();
                intent.setAction(Intents.Scan.ACTION);
                intent.putExtra(Intents.Scan.CHARACTER_SET, "UTF-8");
                intent.putExtra(Intents.Scan.WIDTH, 600);
                intent.putExtra(Intents.Scan.HEIGHT, 400);
                // intent.putExtra(Intents.Scan.PROMPT_MESSAGE, "type your prompt message");
                intent.setClass(getActivity(), CaptureActivity.class);
                startActivityForResult(intent, 200);
            }
        });


        index_icon_2 = (ImageView) navigationView.findViewById(R.id.img_icon_2);

//点击个人信息图片:
        index_icon_2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


                if (lin_profile.getVisibility() == View.VISIBLE) {


                    Animation mOutAction = AnimationUtils.loadAnimation(x.app(), R.anim.push_up_out);
                    lin_profile.setVisibility(View.GONE);
                    lin_profile.startAnimation(mOutAction);


                } else {
                    Animation mShowAction = AnimationUtils.loadAnimation(x.app(), R.anim.push_down_in);
                    lin_profile.setVisibility(View.VISIBLE);
                    lin_profile.startAnimation(mShowAction);
                }
            }
        });


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


    private void initListView() {
        list_order.setHeaderDividersEnabled(false);
        list_order.setOnBottomListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                pageNo++;
                loadData(1);
            }
        });

        list_order.setOnDropDownListener(new DropDownListView.OnDropDownListener() {
            @Override
            public void onDropDown() {
                pageNo = 1;
                loadData(2);
            }
        });
        registerForContextMenu(list_order);
    }


    private void loadData(final int tag) {

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
                    JSONObject obj = (JSONObject) object;


                    LoginMessageModel lmModel = gson.fromJson(obj.getJSONObject("Message").toString(), LoginMessageModel.class);
                    if (lmModel.getMessageval().equals("success")) {
                        blance = obj.getJSONObject("Variables").getString("balance");
                        pendingbalance = obj.getJSONObject("Variables").getString("pendingbalance");
                        title = obj.getJSONObject("Variables").getString("title");
                        navigationView.setTitle(title);
                        tx_blance.setText(blance);
                        tx_pendingbalance.setText(pendingbalance);
//                        application.setYuer(blance);
//                        application.setWeiqueren(pendingbalance);
                        JSONArray orderArr = obj.getJSONObject("Variables").getJSONArray("oderlist");


                        List<MainOrderModel> orderList = new ArrayList<MainOrderModel>();
                        for (int i = 0; i < orderArr.length(); i++) {
                            orderModel = gson.fromJson(orderArr.get(i).toString(), MainOrderModel.class);
                            orderList.add(orderModel);
                        }

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
                                adapter = new MainOrderAdapter(getActivity(), orderList);
                                list_order.setAdapter(adapter);
                                list_order.setVisibility(View.VISIBLE);
                                lin_girl.setVisibility(View.GONE);
                            } else {
                                list_order.setVisibility(View.GONE);
                                lin_girl.setVisibility(View.VISIBLE);
                            }
                        }

                    } else {
                        Toast.makeText(x.app(), lmModel.getMessagestr(), Toast.LENGTH_SHORT).show();
                    }

                    edit_code.setEnabled(true);
                } catch (JSONException e) {
                    e.printStackTrace();
                    if (tag == 3) {
                        edit_code.setEnabled(false);
                    }
                } finally {

                }

                baseActivity.hiddenToast();
            }

            @Override
            public void fail() {
                baseActivity.hiddenToast();
                if (tag == 3) {
                    edit_code.setEnabled(false);
                }
            }
        });
    }

    private void ValidateCode(final String code) {


        String[] keys = new String[]{"code"};
        String[] values = new String[]{code};

        HttpRequestClass.getRequest(getActivity(), keys, values, Config.api_validatecode, new CallBackClass() {


            @Override
            public void success(Object object) {


                try {
                    JSONObject obj = (JSONObject) object;
                    LoginMessageModel lmModel = gson.fromJson(obj.getJSONObject("Message").toString(), LoginMessageModel.class);


                    if (lmModel.getMessagestr().equals("优惠券代码不存在")) {
                        Toast.makeText(x.app(), "优惠券代码不存在", Toast.LENGTH_SHORT).show();
                    } else {
                        JSONObject itemObj = obj.getJSONObject("Variables").getJSONObject("code");
                        //codeModel = gson.fromJson(itemObj.toString(), CodeModel.class);
                        codeModel.setCode(itemObj.getString("code"));
                        codeModel.setPrice(itemObj.getString("clearingprice"));
                        codeModel.setStatus(itemObj.getString("status"));
                        codeModel.setTitle(itemObj.getJSONObject("item").getString("title"));
                        codeModel.setNotice(itemObj.getJSONObject("item").getString("notice"));

                    }

                    Intent intent = new Intent();
                    intent.setClass(getActivity(), CodeConfirmResultActivity.class);
                    Bundle bundle = new Bundle();
                    bundle.putSerializable("codedetail", codeModel);
                    intent.putExtras(bundle);
                    startActivityForResult(intent, 400);

                } catch (JSONException e) {
                    e.printStackTrace();
                }


                baseActivity.hiddenToast();
            }

            @Override
            public void fail() {
                baseActivity.hiddenToast();
            }
        });


    }


    @Event(value = {R.id.btn_confirm, R.id.tx_xiugai, R.id.tx_tuichu})
    private void onclick(View v) {

        Intent it = new Intent();

        switch (v.getId()) {
            case R.id.btn_confirm:
                String code = edit_code.getText().toString().trim();
                if (code.length() == 0) {
                    Toast.makeText(x.app(), "请输入优惠券序列号", Toast.LENGTH_SHORT).show();
                    return;
                }
                ValidateCode(code);//提交优惠劵代码
                break;

            case R.id.tx_xiugai:
                lin_profile.setVisibility(View.GONE);
                it.setClass(getActivity(), ModifyPasswordActivity.class);
                startActivityForResult(it, 300);
                break;
            case R.id.tx_tuichu:
                lin_profile.setVisibility(View.GONE);
                DbCookieStore instance = DbCookieStore.INSTANCE;
                instance.removeAll();
                it.setClass(getActivity(), LoginActivity.class);
                Bundle bundle = new Bundle();
                bundle.putString("isHomePage", "yes");
                it.putExtras(bundle);
                startActivity(it);
                getActivity().finish();
                break;

        }


    }


    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (null != data && requestCode == 200) {
            switch (resultCode) {
                case Activity.RESULT_OK:
                    ValidateCode(data.getStringExtra(Intents.Scan.RESULT));
                    break;
                default:
                    break;
            }
        } else if (requestCode == 300 && resultCode == Activity.RESULT_OK) {
            lin_profile.setVisibility(View.GONE);
            DbCookieStore instance = DbCookieStore.INSTANCE;
            instance.removeAll();
            Intent it = new Intent();
            it.setClass(getActivity(), LoginActivity.class);
            Bundle bundle = new Bundle();
            bundle.putString("isHomePage", "yes");
            it.putExtras(bundle);
            startActivity(it);
            getActivity().finish();
        } else if (requestCode == 400 && resultCode == Activity.RESULT_OK) {
            edit_code.setText("");
            loadData(3);
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        BaseTabHostActivity.getInstance().getCount();
    }


}
