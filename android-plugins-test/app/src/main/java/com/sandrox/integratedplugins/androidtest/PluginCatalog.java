package com.sandrox.integratedplugins.androidtest;

import java.util.Collections;
import java.util.List;

final class PluginCatalog {
    private static final List<PluginEntry> ENTRIES = Collections.singletonList(
            new PluginEntry(
                    R.drawable.ic_levixel,
                    R.string.levixel_entry_title,
                    R.string.levixel_entry_description,
                    LevixelDemoActivity.class
            )
    );

    private PluginCatalog() {
    }

    static List<PluginEntry> getEntries() {
        return ENTRIES;
    }
}
