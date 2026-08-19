package com.sandrox.integratedplugins.androidtest;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;

final class PluginEntry {
    private final int iconResourceId;
    private final int titleResourceId;
    private final int descriptionResourceId;
    private final Class<? extends Activity> activityClass;

    PluginEntry(
            int iconResourceId,
            int titleResourceId,
            int descriptionResourceId,
            Class<? extends Activity> activityClass
    ) {
        this.iconResourceId = iconResourceId;
        this.titleResourceId = titleResourceId;
        this.descriptionResourceId = descriptionResourceId;
        this.activityClass = activityClass;
    }

    int getIconResourceId() {
        return iconResourceId;
    }

    String getTitle(Context context) {
        return context.getString(titleResourceId);
    }

    String getDescription(Context context) {
        return context.getString(descriptionResourceId);
    }

    Intent createIntent(Context context) {
        return new Intent(context, activityClass);
    }
}
