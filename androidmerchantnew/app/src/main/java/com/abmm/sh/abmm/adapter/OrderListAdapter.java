package com.abmm.sh.abmm.adapter;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.CallBackClass;
import com.abmm.sh.abmm.UtilityClass.HttpRequestClass;
import com.abmm.sh.abmm.activity.Order.DeliveryActivity;
import com.abmm.sh.abmm.activity.Order.LogisticsActivity;
import com.abmm.sh.abmm.activity.Order.OrderFragment;
import com.abmm.sh.abmm.model.OrderModel;
import com.abmm.sh.abmm.other.Config;

import org.xutils.common.util.DensityUtil;
import org.xutils.image.ImageOptions;
import org.xutils.x;

import java.util.List;

/**
 * Created by Kevin on 2016/4/13.
 */
public class OrderListAdapter extends BaseAdapter {
    private LayoutInflater mInflater = null;
    private List<OrderModel> data;
    private ImageOptions imageOptions;
    private Context ctx;
    private OrderFragment orderFragment;

    public OrderListAdapter(Context context, List<OrderModel> listdata, OrderFragment orderFragment) {
        //根据context上下文加载布局，这里的是Demo17Activity本身，即this
        this.mInflater = LayoutInflater.from(context);
        this.data = listdata;
        this.ctx = context;
        this.orderFragment = orderFragment;
        imageOptions = new ImageOptions.Builder()
                .setSize(DensityUtil.dip2px(120), DensityUtil.dip2px(120))
                .setRadius(DensityUtil.dip2px(5))
                // 如果ImageView的大小不是定义为wrap_content, 不要crop.
                //.setCrop(true) // 很多时候设置了合适的scaleType也不需要它.
                // 加载中或错误图片的ScaleType
                //.setPlaceholderScaleType(ImageView.ScaleType.MATRIX)
                .setImageScaleType(ImageView.ScaleType.CENTER_INSIDE)
                .setLoadingDrawableId(R.drawable.ic_launcher)
                .setFailureDrawableId(R.drawable.ic_launcher)
                .build();
    }

    //刷新数据，如果clear=true,清空数据，clear=false,继续加载数据
    public void changeData(List<OrderModel> plist, boolean clear) {
        if (plist != null && !plist.isEmpty()) {
            if (clear) {
                data.clear();
            }
            data.addAll(plist);
            refresh();
        }
    }


    public void refresh() {
        notifyDataSetChanged();
    }

    @Override
    public int getCount() {
        return data.size();
    }

    @Override
    public Object getItem(int position) {
        return position;
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        ViewHolder holder = null;
        //如果缓存convertView为空，则需要创建View
        if (convertView == null) {
            holder = new ViewHolder();
            //根据自定义的Item布局加载布局
            convertView = mInflater.inflate(R.layout.list_order_item, null);
            holder.tx_order_status = (TextView) convertView.findViewById(R.id.tx_order_status);
            holder.tx_order_id = (TextView) convertView.findViewById(R.id.tx_order_id);
            holder.tx_order_title = (TextView) convertView.findViewById(R.id.tx_order_title);
            holder.tx_order_model = (TextView) convertView.findViewById(R.id.tx_order_model);
            holder.tx_order_price = (TextView) convertView.findViewById(R.id.tx_order_price);
            holder.tx_order_time = (TextView) convertView.findViewById(R.id.tx_order_time);
            holder.tx_order_address = (TextView) convertView.findViewById(R.id.tx_order_address);
            holder.tx_order_memo = (TextView) convertView.findViewById(R.id.tx_order_memo);
            holder.tx_fh = (TextView) convertView.findViewById(R.id.tx_fh);

            holder.tx_tk = (TextView) convertView.findViewById(R.id.tx_tk);

            holder.tx_wlxx = (TextView) convertView.findViewById(R.id.tx_wlxx);
            holder.im_pic = (ImageView) convertView.findViewById(R.id.im_pic);
            holder.tx_total = (TextView) convertView.findViewById(R.id.tx_total);

            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        final OrderModel model = data.get(position);


        //发货:
        holder.tx_fh.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent it = new Intent();
                it.setClass(ctx, DeliveryActivity.class);
                Bundle bundle = new Bundle();
                model.setExpress(orderFragment.str_express);
                bundle.putSerializable("orderdetail", model);
                it.putExtras(bundle);
                ctx.startActivity(it);
            }
        });

        holder.tx_tk.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new AlertDialog.Builder(ctx).setTitle("    " + model.getTitle()).setMessage("    是否确定退款？")
                        .setPositiveButton("退款", new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int which) {


                                String[] keys = new String[]{"orderid"};
                                String[] values = new String[]{model.getOrderid()};
                                HttpRequestClass.getRequest(ctx, keys, values, Config.api_order_refund, new CallBackClass() {

                                    @Override
                                    public void success(Object object) {
                                        orderFragment.dfh();
                                    }

                                    @Override
                                    public void fail() {

                                    }
                                });

                            }
                        })
                        .setNegativeButton("取消", null)
                        .show();
            }
        });


//        WuliuActivity.class
        holder.tx_wlxx.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.e("model", data.get(position).toString());
                Intent it = new Intent();
                it.setClass(ctx, LogisticsActivity.class);
                it.putExtra("orderid", model.getOrderid());
                Log.e("model.getOrderid()", model.getOrderid());
                ctx.startActivity(it);
            }
        });

        holder.tx_tk.setVisibility(View.GONE);
        if (model.getStatus().equals("2")) {
            holder.tx_wlxx.setVisibility(View.VISIBLE);
            holder.tx_fh.setVisibility(View.GONE);
        } else if (model.getStatus().equals("5")) {
            holder.tx_wlxx.setVisibility(View.GONE);
            holder.tx_fh.setVisibility(View.VISIBLE);
            holder.tx_tk.setVisibility(View.VISIBLE);

        } else {
            holder.tx_wlxx.setVisibility(View.VISIBLE);
            holder.tx_fh.setVisibility(View.GONE);
        }


        holder.tx_order_status.setText(model.getStatusname());
        holder.tx_order_id.setText(model.getOrderid());
        holder.tx_order_title.setText(model.getTitle());
        holder.tx_order_model.setText(model.getType());
        double total = Double.parseDouble(model.getClearingprice()) * Double.parseDouble(model.getNum());
        holder.tx_total.setText("共" + model.getNum() + "件,合计￥" + total);
        holder.tx_order_price.setText(model.getClearingprice() + " X " + model.getNum());
        holder.tx_order_time.setText(model.getOrdertime());
        holder.tx_order_address.setText("买家信息: " + model.getBuyername() + " " + model.getBuyermobile() + " " + model.getBuyeraddress());
        holder.tx_order_memo.setText("买家留言: " + model.getMemo());
        x.image().bind(holder.im_pic, model.getPic(), imageOptions);
        return convertView;
    }

    static class ViewHolder {
        public TextView tx_order_status;
        public TextView tx_order_id;
        public TextView tx_order_title;
        public TextView tx_order_model;
        public TextView tx_order_price;
        public TextView tx_order_time;
        public TextView tx_order_address;
        public TextView tx_order_memo;
        public TextView tx_fh;
        public TextView tx_tk;
        public TextView tx_wlxx;
        public ImageView im_pic;
        public TextView tx_total;
    }
}
