package com.starlight.starlight_epub_viewer;

import android.graphics.Color;

import com.folioreader.Config;

public class ReaderConfig {

    public Config config;

    public ReaderConfig(String themeColor,
            String scrollDirection, boolean setShowRemainingIndicator, boolean showTts, boolean nightMode) {
        config = new Config();
        if (scrollDirection.equals("vertical")) {
            config.setAllowedDirection(Config.AllowedDirection.ONLY_VERTICAL);
        } else if (scrollDirection.equals("horizontal")) {
            config.setAllowedDirection(Config.AllowedDirection.ONLY_HORIZONTAL);
        } else {
            config.setAllowedDirection(Config.AllowedDirection.VERTICAL_AND_HORIZONTAL);
        }
        config.setThemeColorInt(Color.parseColor(themeColor));
        config.setNightThemeColorInt(Color.parseColor(themeColor));
        config.setShowRemainingIndicator(setShowRemainingIndicator);
        config.setShowTts(showTts);
        config.setNightMode(nightMode);
    }
}
