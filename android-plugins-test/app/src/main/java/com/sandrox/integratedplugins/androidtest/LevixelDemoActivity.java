package com.sandrox.integratedplugins.androidtest;

import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.FrameLayout;
import android.widget.ImageView;

import androidx.activity.OnBackPressedCallback;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.core.view.WindowInsetsControllerCompat;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.sandrox.levixel.LevixelMediaItem;
import com.sandrox.levixel.LevixelSharedElementNames;
import com.sandrox.levixel.LevixelSourceViewRegistry;
import com.sandrox.levixel.LevixelViewerOverlayView;

import java.util.List;

public final class LevixelDemoActivity extends AppCompatActivity {
    private FrameLayout rootView;
    private RecyclerView recyclerView;
    private ThumbnailAdapter thumbnailAdapter;
    private List<LevixelMediaItem> items;
    @Nullable
    private LevixelViewerOverlayView overlayView;
    private OnBackPressedCallback overlayBackCallback;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        configureEdgeToEdgeWindow();
        if (getSupportActionBar() != null) {
            getSupportActionBar().hide();
        }
        items = SampleMedia.create();

        rootView = new FrameLayout(this);
        rootView.setLayoutParams(new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
        ));
        rootView.setBackgroundColor(Color.WHITE);

        recyclerView = new RecyclerView(this);
        recyclerView.setLayoutParams(new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
        ));
        recyclerView.setBackgroundColor(Color.WHITE);
        recyclerView.setClipToPadding(false);
        int contentPadding = dp(8);
        recyclerView.setPadding(contentPadding, contentPadding, contentPadding, contentPadding);
        recyclerView.setLayoutManager(new GridLayoutManager(this, 2));
        thumbnailAdapter = new ThumbnailAdapter(items, this::openViewer);
        recyclerView.setAdapter(thumbnailAdapter);
        rootView.addView(recyclerView);
        ViewCompat.setOnApplyWindowInsetsListener(rootView, (view, windowInsets) -> {
            Insets systemBars = windowInsets.getInsets(WindowInsetsCompat.Type.systemBars());
            recyclerView.setPadding(
                    systemBars.left + contentPadding,
                    systemBars.top + contentPadding,
                    systemBars.right + contentPadding,
                    systemBars.bottom + contentPadding
            );
            return windowInsets;
        });

        setContentView(rootView);
        ViewCompat.requestApplyInsets(rootView);
        overlayBackCallback = new OnBackPressedCallback(false) {
            @Override
            public void handleOnBackPressed() {
                if (overlayView != null) {
                    overlayView.requestClose();
                }
            }
        };
        getOnBackPressedDispatcher().addCallback(this, overlayBackCallback);
    }

    @Override
    protected void onDestroy() {
        if (overlayView != null) {
            overlayView.dismissImmediately();
            overlayView = null;
        }
        super.onDestroy();
    }

    private void configureEdgeToEdgeWindow() {
        Window window = getWindow();
        WindowCompat.setDecorFitsSystemWindows(window, false);
        window.setStatusBarColor(Color.TRANSPARENT);
        window.setNavigationBarColor(Color.TRANSPARENT);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            window.setStatusBarContrastEnforced(false);
            window.setNavigationBarContrastEnforced(false);
        }
        WindowInsetsControllerCompat controller = WindowCompat.getInsetsController(window, window.getDecorView());
        controller.setAppearanceLightStatusBars(false);
        controller.setAppearanceLightNavigationBars(false);
    }

    private void openViewer(int position, View sourceView) {
        if (position < 0 || position >= items.size()) {
            return;
        }
        if (overlayView != null) {
            return;
        }
        if (sourceView instanceof ImageView) {
            LevixelSourceViewRegistry.register(
                    LevixelSharedElementNames.forItem(items.get(position)),
                    (ImageView) sourceView
            );
        }
        overlayView = new LevixelViewerOverlayView(
                this,
                items,
                position,
                false,
                null,
                new LevixelViewerOverlayView.Listener() {
                    @Override
                    public void onOverlayDismissed() {
                        overlayView = null;
                        overlayBackCallback.setEnabled(false);
                    }

                    @Override
                    public void onOverlayIndexChange(int index) {
                    }
                }
        );
        rootView.addView(overlayView);
        overlayBackCallback.setEnabled(true);
    }

    private int dp(int value) {
        return (int) TypedValue.applyDimension(
                TypedValue.COMPLEX_UNIT_DIP,
                value,
                getResources().getDisplayMetrics()
        );
    }
}
