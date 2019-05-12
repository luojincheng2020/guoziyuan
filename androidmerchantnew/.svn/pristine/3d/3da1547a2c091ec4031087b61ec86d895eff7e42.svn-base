package com.abmm.sh.abmm.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.Utils;
import com.abmm.sh.abmm.model.MainOrderModel;

import java.util.List;

/**
 * Created by Kevin on 2016/4/13.
 */
public class MainOrderAdapter extends BaseAdapter {
    private LayoutInflater mInflater = null;
    private List<MainOrderModel> data;
    private MainOrderModel model;

    public MainOrderAdapter(Context context, List<MainOrderModel> listdata) {
        //根据context上下文加载布局，这里的是Demo17Activity本身，即this
        this.mInflater = LayoutInflater.from(context);
        this.data = listdata;
    }

    //刷新数据，如果clear=true,清空数据，clear=false,继续加载数据
    public void changeData(List<MainOrderModel> plist, boolean clear) {
        if (plist != null && !plist.isEmpty()) {
            if (clear) {
                data.clear();
            }
            data.addAll(plist);
            refresh();
        }
    }

    @Override
    public int getCount() {
        return data.size();
    }

    public void refresh() {
        notifyDataSetChanged();
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
            convertView = mInflater.inflate(R.layout.list_index_item, null);
            holder.title = (TextView) convertView.findViewById(R.id.title);
            holder.code = (TextView) convertView.findViewById(R.id.code);
            holder.price = (TextView) convertView.findViewById(R.id.price);
            holder.useddate = (TextView) convertView.findViewById(R.id.useddate);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        model = data.get(position);
        holder.title.setText(model.getTitle());
        holder.code.setText(model.getCode());
        holder.price.setText(Utils.AddMoney(model.getClearingprice()));

        holder.useddate.setText(model.getUsedate());
        //Log.d("lilei",model.getUsedate()+"");
        return convertView;
    }

    static class ViewHolder {
        public TextView title;
        public TextView code;
        public TextView price;
        public TextView useddate;

    }
}
