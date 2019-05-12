package com.abmm.sh.abmm.view;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.abmm.sh.abmm.R;

/**
 * Created by com.abmm.sh.abmm on 16/9/18.
 */
public class NavigationView extends RelativeLayout implements View.OnClickListener {
    private ImageView backView;
    private TextView titleView;
    private ImageView rightView;
    private TextView rightViewTitle;
    private ClickCallback callback;


    public NavigationView(Context context) {
//        super(context);
        this(context, null);
    }

    public NavigationView(Context context, AttributeSet attrs) {
        super(context, attrs);
        View view = LayoutInflater.from(context).inflate(R.layout.navlayout, this, true);
        backView = (ImageView) view.findViewById(R.id.iv_nav_back);
        backView.setOnClickListener(this);
        titleView = (TextView) view.findViewById(R.id.tv_nav_title);
        rightView = (ImageView) view.findViewById(R.id.iv_nav_right1);
        rightViewTitle = (TextView) view.findViewById(R.id.iv_nav_right2);
        rightView.setOnClickListener(this);
        rightViewTitle.setOnClickListener(this);
    }

    /**
     * 获取返回按钮
     *
     * @return
     */
    public ImageView getBackView() {
        return backView;
    }

    /**
     * 获取标题控件
     *
     * @return
     */
    public TextView getTitleView() {
        return titleView;
    }

    /**
     * 设置标题
     *
     * @param title
     */
    public void setTitle(String title) {
        titleView.setText(title);
    }

    /**
     * 获取右侧图片按钮,默认不显示
     *
     * @return
     */
    public ImageView getRightView() {
        return rightView;
    }

    /**
     * 获取右侧文字按钮,默认不显示
     *
     * @return
     */
    public TextView getRightViewTitle() {
        return rightViewTitle;
    }

    /**
     * 设置按钮点击回调接口
     *
     * @param callback
     */
    public void setClickCallback(ClickCallback callback) {
        this.callback = callback;
    }

    @Override
    public void onClick(View v) {
        int id = v.getId();
        if (id == R.id.iv_nav_back) {
            callback.onBackClick();
            return;
        }
        if (id == R.id.iv_nav_right1 || id == R.id.iv_nav_right2) {
            callback.onRightClick();
            return;
        }
    }

    /**
     * 导航栏点击回调接口
     * </br>如若需要标题可点击,可再添加
     *
     * @author Asia
     */
    public static interface ClickCallback {
        /**
         * 点击返回按钮回调
         */
        void onBackClick();

        void onRightClick();
    }
}
