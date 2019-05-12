package com.abmm.sh.abmm.other;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.AnimationDrawable;
import android.view.Gravity;
import android.widget.ImageView;

import com.abmm.sh.abmm.R;

/**
 * 提示图片
 */
public class CustomProgressDialog extends Dialog {
    private AnimationDrawable animationDrawable;

    public CustomProgressDialog(Context context, String strMessage) {
        this(context, R.style.CustomDialog, strMessage);
    }

    public CustomProgressDialog(Context context, int theme, String strMessage) {
        super(context, theme);
        this.setContentView(R.layout.loadingprogressdialog);
        this.getWindow().getAttributes().gravity = Gravity.CENTER;
        ImageView animationIV = (ImageView) findViewById(R.id.img_loading);
        animationDrawable = (AnimationDrawable) animationIV.getDrawable();
        animationDrawable.setOneShot(false);
        animationDrawable.start();
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {

//        if (!hasFocus) {
//            dismiss();
//        }
    }
}