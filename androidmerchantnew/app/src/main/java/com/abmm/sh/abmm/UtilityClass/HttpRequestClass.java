package com.abmm.sh.abmm.UtilityClass;

import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import com.google.gson.Gson;

import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.http.RequestParams;
import org.xutils.x;

/**
 * Created by com.abmm.sh.abmm on 16/12/26.
 */

public class HttpRequestClass {

    static public void getRequest(final Context context, String[] keys, String[] values, final String url, final CallBackClass callBackClass) {
        RequestParams params = new RequestParams(url);
        params.addQueryStringParameter("r", System.currentTimeMillis() + "");
        for (int i = 0; i < keys.length; i++) {
            params.addQueryStringParameter(keys[i], values[i]);
        }
        Callback.Cancelable cancelled = x.http().post(params, new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                Gson gson = new Gson();
                try {
                    Log.e("get结果=", url + result);
                    JSONObject obj = new JSONObject(result);
                    callBackClass.success(obj);

                } catch (JSONException e) {
                    e.printStackTrace();
                    callBackClass.fail();
                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {
                if (ex.getMessage().toString().length() > 0) {
                    Toast.makeText(x.app(), ex.getMessage(), Toast.LENGTH_LONG).show();
                }
                callBackClass.fail();
            }

            @Override
            public void onCancelled(CancelledException cex) {
                Toast.makeText(x.app(), "cancelled", Toast.LENGTH_LONG).show();
                callBackClass.fail();

            }

            @Override
            public void onFinished() {
            }
        });
    }


    static public void postRequest(final Context context, String[] keys, String[] values, final String url, final CallBackClass callBackClass) {
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("r", System.currentTimeMillis() + "");
        for (int i = 0; i < keys.length; i++) {
            params.addBodyParameter(keys[i], values[i]);
        }
        Callback.Cancelable cancelled = x.http().post(params, new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                Gson gson = new Gson();
                try {
                    Log.e("post结果=", url + result);
                    JSONObject obj = new JSONObject(result);
                    callBackClass.success(obj);

                } catch (JSONException e) {
                    e.printStackTrace();
                    callBackClass.fail();
                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {
                if (ex.getMessage().toString().length() > 0) {
                    Toast.makeText(x.app(), ex.getMessage(), Toast.LENGTH_LONG).show();
                }
                callBackClass.fail();
            }

            @Override
            public void onCancelled(CancelledException cex) {
                Toast.makeText(x.app(), "cancelled", Toast.LENGTH_LONG).show();
                callBackClass.fail();

            }

            @Override
            public void onFinished() {
            }
        });
    }


}
