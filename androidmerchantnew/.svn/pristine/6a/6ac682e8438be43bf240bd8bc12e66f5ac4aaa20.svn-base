package com.abmm.sh.abmm.adapter;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.activity.Statistical.CodeDetailActivity;
import com.abmm.sh.abmm.activity.Statistical.GoodsDetailActivity;
import com.abmm.sh.abmm.model.StatisticalModel;

import java.util.List;

/**
 * 统计页面adapter
 */
public class StatisticalListAdapter extends BaseAdapter {
    private LayoutInflater mInflater = null;
    private List<StatisticalModel> data;
    private StatisticalModel model;
    private Context ctx;


    public StatisticalListAdapter(Context context, List<StatisticalModel> listdata) {
        //根据context上下文加载布局，这里的是Demo17Activity本身，即this
        this.mInflater = LayoutInflater.from(context);
        this.data = listdata;
        this.ctx = context;

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
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder = null;
        //如果缓存convertView为空，则需要创建View
        if (convertView == null) {
            holder = new ViewHolder();
            //根据自定义的Item布局加载布局
            convertView = mInflater.inflate(R.layout.statistical_list_item, null);
            holder.tx_title = (TextView) convertView.findViewById(R.id.tx_title);
            holder.tx_price = (TextView) convertView.findViewById(R.id.tx_price);
            holder.tx_starttime = (TextView) convertView.findViewById(R.id.tx_starttime);
            holder.tx_yixiaofei = (TextView) convertView.findViewById(R.id.tx_yixiaofei);
            holder.tx_status = (TextView) convertView.findViewById(R.id.tx_status_tj);
            holder.tx_t1 = (TextView) convertView.findViewById(R.id.tx_t1);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        model = data.get(position);

        holder.tx_status.setText(model.getStatus());

//        if (model.getStatus().equals("0")) {
//            holder.tx_status.setText("已结束");
//        } else if (model.getStatus().equals("1")) {
//            holder.tx_status.setText("销售中");
//        }
        final String itemID = model.getItemid();
        if (model.getType().equalsIgnoreCase("goods")) {
            holder.tx_t1.setText("已销售: ");
            holder.tx_price.setText(model.getPrice());
            holder.tx_starttime.setText(model.getStarttime() + " 上线");
            holder.tx_yixiaofei.setText(model.getSalenum());
            holder.tx_title.setText("商品: " + model.getTitle());
//            GoodsDetailActivity.class
            convertView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent it = new Intent();
                    it.setClass(ctx, GoodsDetailActivity.class);
                    it.putExtra("itemid", itemID);
                    ctx.startActivity(it);
                }
            });
        } else if (model.getType().equalsIgnoreCase("code")) {
            holder.tx_t1.setText("已消费: ");
            holder.tx_price.setText(model.getPrice());
            holder.tx_starttime.setText(model.getStarttime() + " 上线");
            holder.tx_yixiaofei.setText(model.getSalenum());
            holder.tx_title.setText("优惠券: " + model.getTitle());
//            CodeDetailActivity.class
            convertView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent it = new Intent();
                    it.setClass(ctx, CodeDetailActivity.class);
                    it.putExtra("itemid", itemID);
                    ctx.startActivity(it);
                }
            });
        } else {
            holder.tx_starttime.setVisibility(View.GONE);
            holder.tx_t1.setText("已买单: ");
            holder.tx_title.setText("到店付: ");
            holder.tx_price.setText(model.getTitle());
            holder.tx_yixiaofei.setText(model.getSalenum());

        }


        return convertView;
    }

    static class ViewHolder {
        public TextView tx_title;
        public TextView tx_price;
        public TextView tx_starttime;
        public TextView tx_yixiaofei;
        public TextView tx_status;
        public TextView tx_t1;

    }
}
