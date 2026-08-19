package com.sandrox.integratedplugins.androidtest;

import android.app.Activity;
import android.os.Bundle;
import android.widget.ListView;

import java.util.List;

public final class MainActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_plugin_list);

        List<PluginEntry> entries = PluginCatalog.getEntries();
        ListView pluginListView = findViewById(R.id.plugin_list);
        pluginListView.setAdapter(new PluginListAdapter(this, entries));
        pluginListView.setOnItemClickListener((parent, view, position, id) -> {
            PluginEntry entry = entries.get(position);
            startActivity(entry.createIntent(this));
        });
    }
}
