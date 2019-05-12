package com.abmm.sh.abmm.UtilityClass;

import android.content.Context;
import android.util.Log;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 */
public class Utils {

    public static String TimestampToDate(String timeStamp) {
        long l = Long.parseLong(timeStamp) * 1000;
        Date date = new Date(l);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String str = format.format(date);
        return str;
    }

    public static String AddMoney(String str) {
        if (!str.contains("-") && !str.contains("+") && !str.trim().equalsIgnoreCase("")) {
            str = "+" + str;
        }
        Log.d("aa", str);
        return str;
    }

    /**
     * 根据手机的分辨率从 dp 的单位 转成为 px(像素)
     */
    public static int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

    /**
     * 根据手机的分辨率从 px(像素) 的单位 转成为 dp
     */
    public static int px2dip(Context context, float pxValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (pxValue / scale + 0.5f);
    }

    public static int CheckJsonStringType(String str) {
        int type = 0;
        char[] strChar = str.substring(0, 1).toCharArray();
        char firstChar = strChar[0];
        if (firstChar == '{') {
            type = 1;
        } else if (firstChar == '[') {
            type = 2;
        }
        return type;

    }


}
