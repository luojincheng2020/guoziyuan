package com.abmm.sh.abmm.activity.Base;

import android.annotation.TargetApi;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Toast;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.other.SystemBarTintManager;
import com.google.gson.Gson;


/**
 * Created by com.abmm.sh.abmm on 16/12/21.
 */

public class BaseFragment extends Fragment {

    protected BaseActivity baseActivity = new BaseActivity();
    protected MyApplication app = MyApplication.getInstance();
    protected BaseTabHostActivity tabHostActivity = BaseTabHostActivity.getInstance();
    protected boolean isdebug = true;
    protected Gson gson = new Gson();

    public static void initSystemBar(Fragment activity) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            setTranslucentStatus(activity, true);
        }

        SystemBarTintManager tintManager = new SystemBarTintManager(activity.getActivity());

        // 激活状态栏设置
        tintManager.setStatusBarTintEnabled(true);
        tintManager.setStatusBarTintResource(R.color.white);
    }


    @TargetApi(19)

    private static void setTranslucentStatus(Fragment activity, boolean on) {

        Window win = activity.getActivity().getWindow();
        WindowManager.LayoutParams winParams = win.getAttributes();
        final int bits = WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS;
        if (on) {
            winParams.flags |= bits;
        } else {
            winParams.flags &= ~bits;
        }
        win.setAttributes(winParams);
    }

    public void showToast(String str) {
//        Toast.makeText(getContext(), str, Toast.LENGTH_SHORT).show();
    }

    //跳转登录页面用公用方法
//    public void goLogin(Activity activity)
//    {
//        app.notlogin="yes";
//        Intent intent = new Intent(activity, MemberLoginActivity.class);
//        startActivity(intent);
//    }
    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        initSystemBar(this);

//
//        FragmentManager fm = getSupportFragmentManager();
//        Fragment fragment =fm.findFragmentById(R.id.bottom_layout);
//
//        if(fragment == null )
//        {
//            fragment = createFragment() ;
//
//            fm.beginTransaction().add(R.id.id_fragment_container,fragment).commit();
//        }


    }

    @Override
    public void onResume() {
        super.onResume();
//        if(!StringUtils.isEmpty(app.notlogin)){
//            if(app.getLoginUser().getMemberuid()>0)
//            {
//                app.notlogin="";
//            }
//        }
    }

    public void showDebug(String str) {

        if (isdebug) {
            Toast.makeText(getContext(), str, Toast.LENGTH_SHORT).show();
        }
    }


}
