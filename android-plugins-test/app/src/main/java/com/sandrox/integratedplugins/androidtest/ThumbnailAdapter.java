package com.sandrox.integratedplugins.androidtest;

import android.content.Context;
import android.graphics.Color;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.view.ViewCompat;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.sandrox.levixel.LevixelMediaItem;
import com.sandrox.levixel.LevixelSharedElementNames;
import com.sandrox.levixel.LevixelSourceViewRegistry;

import java.util.List;

public class ThumbnailAdapter extends RecyclerView.Adapter<ThumbnailAdapter.ThumbnailViewHolder> {
    public interface OnThumbnailClickListener {
        void onClick(int position, ImageView imageView);
    }

    private final List<LevixelMediaItem> items;
    private final OnThumbnailClickListener onThumbnailClickListener;

    public ThumbnailAdapter(List<LevixelMediaItem> items, OnThumbnailClickListener onThumbnailClickListener) {
        this.items = items;
        this.onThumbnailClickListener = onThumbnailClickListener;
    }

    @NonNull
    @Override
    public ThumbnailViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        Context context = parent.getContext();
        int size = dp(context, 132);
        FrameLayout root = new FrameLayout(context);
        RecyclerView.LayoutParams layoutParams = new RecyclerView.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                size
        );
        int margin = dp(context, 6);
        layoutParams.setMargins(margin, margin, margin, margin);
        root.setLayoutParams(layoutParams);
        root.setBackgroundColor(Color.WHITE);

        ImageView imageView = new ImageView(context);
        imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
        imageView.setLayoutParams(new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
        ));
        root.addView(imageView);

        TextView badge = new TextView(context);
        badge.setText("VIDEO");
        badge.setTextColor(Color.WHITE);
        badge.setTextSize(TypedValue.COMPLEX_UNIT_SP, 11);
        badge.setBackgroundColor(Color.parseColor("#99000000"));
        badge.setPadding(dp(context, 6), dp(context, 3), dp(context, 6), dp(context, 3));
        FrameLayout.LayoutParams badgeParams = new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT
        );
        badgeParams.gravity = Gravity.TOP | Gravity.END;
        badgeParams.topMargin = dp(context, 6);
        badgeParams.rightMargin = dp(context, 6);
        badge.setLayoutParams(badgeParams);
        root.addView(badge);

        return new ThumbnailViewHolder(root, imageView, badge);
    }

    @Override
    public void onBindViewHolder(@NonNull ThumbnailViewHolder holder, int position) {
        LevixelMediaItem item = items.get(position);
        String sourceKey = LevixelSharedElementNames.forItem(item);
        holder.sourceKey = sourceKey;
        registerSourceViewWhenReady(holder, sourceKey);
        Glide.with(holder.imageView)
                .load(item.getThumbnailUrl())
                .dontTransform()
                .dontAnimate()
                .into(holder.imageView);
        holder.videoBadge.setVisibility(item.getMediaType() == LevixelMediaItem.MediaType.VIDEO ? View.VISIBLE : View.GONE);
        holder.imageView.setOnClickListener(v -> onThumbnailClickListener.onClick(holder.getBindingAdapterPosition(), holder.imageView));
    }

    @Override
    public void onViewRecycled(@NonNull ThumbnailViewHolder holder) {
        super.onViewRecycled(holder);
        holder.sourceKey = null;
        LevixelSourceViewRegistry.unregisterView(holder.imageView);
        Glide.with(holder.imageView.getContext().getApplicationContext()).clear(holder.imageView);
    }

    private void registerSourceViewWhenReady(@NonNull ThumbnailViewHolder holder, @NonNull String sourceKey) {
        ImageView imageView = holder.imageView;
        if (isSourceViewReady(imageView)) {
            LevixelSourceViewRegistry.register(sourceKey, imageView);
            return;
        }

        imageView.post(() -> {
            if (sourceKey.equals(holder.sourceKey) && isSourceViewReady(imageView)) {
                LevixelSourceViewRegistry.register(sourceKey, imageView);
            }
        });

        imageView.addOnLayoutChangeListener(new View.OnLayoutChangeListener() {
            @Override
            public void onLayoutChange(
                    View view,
                    int left,
                    int top,
                    int right,
                    int bottom,
                    int oldLeft,
                    int oldTop,
                    int oldRight,
                    int oldBottom
            ) {
                if (!sourceKey.equals(holder.sourceKey)) {
                    imageView.removeOnLayoutChangeListener(this);
                    return;
                }
                if (isSourceViewReady(imageView)) {
                    LevixelSourceViewRegistry.register(sourceKey, imageView);
                    imageView.removeOnLayoutChangeListener(this);
                }
            }
        });
    }

    private boolean isSourceViewReady(@NonNull ImageView imageView) {
        return ViewCompat.isAttachedToWindow(imageView)
                && imageView.getWidth() > 0
                && imageView.getHeight() > 0;
    }

    @Override
    public int getItemCount() {
        return items.size();
    }

    static class ThumbnailViewHolder extends RecyclerView.ViewHolder {
        final ImageView imageView;
        final TextView videoBadge;
        @Nullable
        String sourceKey;

        ThumbnailViewHolder(@NonNull View itemView, ImageView imageView, TextView videoBadge) {
            super(itemView);
            this.imageView = imageView;
            this.videoBadge = videoBadge;
        }
    }

    private static int dp(Context context, int value) {
        return (int) TypedValue.applyDimension(
                TypedValue.COMPLEX_UNIT_DIP,
                value,
                context.getResources().getDisplayMetrics()
        );
    }
}
