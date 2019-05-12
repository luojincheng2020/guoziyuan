package com.abmm.sh.abmm.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.Utils;
import com.abmm.sh.abmm.model.DaodianfuModel;

import java.util.List;

/**
 * 到店付adapter
 */
public class DaodianfuAdapter extends BaseAdapter {
    private LayoutInflater mInflater = null;
    private List<DaodianfuModel> data;
    private DaodianfuModel model;


    public DaodianfuAdapter(Context context, List<DaodianfuModel> listdata) {
        //根据context上下文加载布局，这里的是Demo17Activity本身，即this
        this.mInflater = LayoutInflater.from(context);
        this.data = listdata;

    }


    //刷新数据，如果clear=true,清空数据，clear=false,继续加载数据
    public void changeData(List<DaodianfuModel> plist, boolean clear) {
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
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder = null;
        //如果缓存convertView为空，则需要创建View
        if (convertView == null) {
            holder = new ViewHolder();
            //根据自定义的Item布局加载布局
            convertView = mInflater.inflate(R.layout.list_daodianfu_item, null);
            holder.tx_title = (TextView) convertView.findViewById(R.id.tx_title);
            holder.useddate = (TextView) convertView.findViewById(R.id.useddate);
            holder.price = (TextView) convertView.findViewById(R.id.price);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        model = data.get(position);

        holder.tx_title.setText(model.getSellerusername());
        holder.price.setText(Utils.AddMoney(model.getPayableamt()));
        holder.useddate.setText(model.getOrdertime());


        return convertView;
    }

    static class ViewHolder {
        public TextView useddate;
        public TextView tx_title;
        public TextView price;

    }
}
