package com.starlight.starlight_epub_viewer;

import android.provider.BaseColumns;

public final class LocatorScheme {
    private LocatorScheme() {
    }

    public static class LocatorEntry implements BaseColumns {
        public static final String TABLE = "locator";
        public static final String ID = "_id";
        public static final String BOOK = "bookId";
        public static final String TITLE = "title";
        public static final String HREF = "href";
        public static final String LOCATIONS = "locations";
        public static final String CREATED = "created";

    }
}
