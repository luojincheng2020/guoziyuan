package com.abmm.sh.abmm.adapter;

import android.app.Activity;
import android.content.Context;
import android.support.v4.view.PagerAdapter;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.abmm.sh.abmm.R;
import com.abmm.sh.abmm.activity.Statistical.CodeDetailActivity;

import org.xutils.image.ImageOptions;
import org.xutils.x;

import java.util.ArrayList;

/**
 * 图片Adapter
 */
public class ImagePlayerAdapter extends PagerAdapter {
    private ArrayList imageURL = new ArrayList<String>();
    private ArrayList titleList1 = new ArrayList<String>();
    private ArrayList titleList2 = new ArrayList<String>();
    private ArrayList viewList = new ArrayList<View>();
    private ImageOptions imageOptions;


    public ImagePlayerAdapter(Context ctx, ArrayList ImageURL, ArrayList TitleList1, ArrayList TitleList2) {


        try {
            Activity activity = (Activity) ctx;

            if (activity instanceof CodeDetailActivity) {
                imageOptions = new ImageOptions.Builder()
                        //.setSize(DensityUtil.dip2px(500), DensityUtil.dip2px(160))
                        //.setRadius(DensityUtil.dip2px(5))
                        // 如果ImageView的大小不是定义为wrap_content, 不要crop.
                        //.setCrop(true) // 很多时候设置了合适的scaleType也不需要它.
                        // 加载中或错误图片的ScaleType
                        //.setPlaceholderScaleType(ImageView.ScaleType.MATRIX)
                        .setImageScaleType(ImageView.ScaleType.FIT_XY)
                        .setLoadingDrawableId(R.drawable.codepic)
                        .setFailureDrawableId(R.drawable.codepic)
                        .build();
            } else {
                imageOptions = new ImageOptions.Builder()
                        //.setSize(DensityUtil.dip2px(500), DensityUtil.dip2px(160))
                        //.setRadius(DensityUtil.dip2px(5))
                        // 如果ImageView的大小不是定义为wrap_content, 不要crop.
                        //.setCrop(true) // 很多时候设置了合适的scaleType也不需要它.
                        // 加载中或错误图片的ScaleType
                        //.setPlaceholderScaleType(ImageView.ScaleType.MATRIX)
                        .setImageScaleType(ImageView.ScaleType.FIT_XY)
                        .setLoadingDrawableId(R.drawable.goodpic)
                        .setFailureDrawableId(R.drawable.goodpic)
                        .build();
            }


        } catch (Exception e) {
            e.printStackTrace();
            imageOptions = new ImageOptions.Builder()
                    //.setSize(DensityUtil.dip2px(500), DensityUtil.dip2px(160))
                    //.setRadius(DensityUtil.dip2px(5))
                    // 如果ImageView的大小不是定义为wrap_content, 不要crop.
                    //.setCrop(true) // 很多时候设置了合适的scaleType也不需要它.
                    // 加载中或错误图片的ScaleType
                    //.setPlaceholderScaleType(ImageView.ScaleType.MATRIX)
                    .setImageScaleType(ImageView.ScaleType.FIT_XY)
                    .setLoadingDrawableId(R.drawable.codepic)
                    .setFailureDrawableId(R.drawable.codepic)
                    .build();
        }


        this.imageURL = ImageURL;
        this.titleList1 = TitleList1;
        this.titleList2 = TitleList2;
        View view;
        TextView t1;
        TextView t2;
        for (int i = 0; i < imageURL.size(); i++) {
            view = LayoutInflater.from(ctx).inflate(R.layout.image_player, null);
            x.image().bind((ImageView) view.findViewById(R.id.img_pic), imageURL.get(i).toString(), imageOptions);
            t1 = (TextView) view.findViewById(R.id.tx_title1);
            t2 = (TextView) view.findViewById(R.id.tx_title2);
            t1.setText(titleList1.get(i).toString());
            t2.setText(titleList2.get(i).toString());
            viewList.add(view);
        }


    }


    @Override
    public boolean isViewFromObject(View arg0, Object arg1) {

        return arg0 == arg1;
    }

    @Override
    public int getCount() {

        return viewList.size();
    }

    @Override
    public void destroyItem(ViewGroup container, int position,
                            Object object) {
        container.removeView((View) viewList.get(position));

    }

    @Override
    public int getItemPosition(Object object) {

        return super.getItemPosition(object);
    }

    @Override
    public CharSequence getPageTitle(int position) {

        return "";
    }

    @Override
    public Object instantiateItem(ViewGroup container, int position) {
        container.addView((View) viewList.get(position));

        return viewList.get(position);
    }
}
