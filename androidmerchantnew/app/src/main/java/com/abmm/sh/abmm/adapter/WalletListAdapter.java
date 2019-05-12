package com.abmm.sh.abmm.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.UtilityClass.Utils;
import com.abmm.sh.abmm.model.WalletModel;

import java.util.List;

/**
 * 钱包余额adapter
 */
public class WalletListAdapter extends BaseAdapter {
    private LayoutInflater mInflater = null;
    private List<WalletModel> data;
    private WalletModel model;


    public WalletListAdapter(Context context, List<WalletModel> listdata) {
        //根据context上下文加载布局，这里的是Demo17Activity本身，即this
        this.mInflater = LayoutInflater.from(context);
        this.data = listdata;

    }


    //刷新数据，如果clear=true,清空数据，clear=false,继续加载数据
    public void changeData(List<WalletModel> plist, boolean clear) {
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
            convertView = mInflater.inflate(R.layout.financial_wallet_list_item, null);
            holder.tx_title = (TextView) convertView.findViewById(R.id.tx_title);
            holder.useddate = (TextView) convertView.findViewById(R.id.useddate);
            holder.price = (TextView) convertView.findViewById(R.id.price);
            holder.tx_number = (TextView) convertView.findViewById(R.id.tx_number);
            holder.tx_balance = (TextView) convertView.findViewById(R.id.tx_balance);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        model = data.get(position);
        if (model.getContent() != null) {
            String[] content;
            holder.tx_number.setVisibility(View.VISIBLE);
            if (model.getContent().contains("收货 ")) {
                content = model.getContent().split("收货 ");
                holder.tx_title.setText(content[0] + "收货 ");
                holder.tx_number.setText(content[1]);
            } else if (model.getContent().contains("订单号:")) {
                content = model.getContent().split("订单号:");
                holder.tx_title.setText(content[0] + "订单号:");
                holder.tx_number.setText(content[1]);
            } else if (model.getContent().contains("订单号: ")) {
                content = model.getContent().split("使用");
                holder.tx_title.setText(content[0] + "使用");
                holder.tx_number.setText(content[1]);
            } else {
                holder.tx_title.setText(model.getContent());
                holder.tx_number.setVisibility(View.GONE);
            }
        }
        holder.tx_balance.setText("余额:" + model.getBalance());
        holder.price.setText(Utils.AddMoney(model.getAmt()));
        if (model.getDateline() != null) {
            holder.useddate.setText(model.getDateline());
        }
        return convertView;
    }


    static class ViewHolder {
        public TextView useddate;
        public TextView tx_title;
        public TextView price;
        public TextView tx_number;
        public TextView tx_balance;

    }
}
