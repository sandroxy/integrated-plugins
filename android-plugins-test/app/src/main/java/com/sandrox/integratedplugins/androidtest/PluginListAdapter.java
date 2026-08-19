package com.sandrox.integratedplugins.androidtest;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.List;

final class PluginListAdapter extends ArrayAdapter<PluginEntry> {
    PluginListAdapter(Context context, List<PluginEntry> entries) {
        super(context, android.R.layout.simple_list_item_2, entries);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View row = convertView;
        if (row == null) {
            row = LayoutInflater.from(getContext()).inflate(
                    R.layout.item_plugin_entry,
                    parent,
                    false
            );
        }

        PluginEntry entry = getItem(position);
        ImageView iconView = row.findViewById(R.id.plugin_icon);
        TextView titleView = row.findViewById(R.id.plugin_title);
        TextView descriptionView = row.findViewById(R.id.plugin_description);
        if (entry != null) {
            iconView.setImageResource(entry.getIconResourceId());
            titleView.setText(entry.getTitle(getContext()));
            descriptionView.setText(entry.getDescription(getContext()));
        } else {
            iconView.setImageDrawable(null);
            titleView.setText("");
            descriptionView.setText("");
        }
        return row;
    }
}
