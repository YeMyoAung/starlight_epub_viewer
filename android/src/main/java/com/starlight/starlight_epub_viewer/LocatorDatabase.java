package com.starlight.starlight_epub_viewer;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class LocatorDatabase extends SQLiteOpenHelper {

    private static final String SQL_CREATE_ENTRIES = "CREATE TABLE " + LocatorScheme.LocatorEntry.TABLE + " (" +
            LocatorScheme.LocatorEntry.ID + " TEXT PRIMARY KEY," +
            LocatorScheme.LocatorEntry.TABLE + " TEXT," +
            LocatorScheme.LocatorEntry.BOOK + " TEXT," +
            LocatorScheme.LocatorEntry.TITLE + " TEXT," +
            LocatorScheme.LocatorEntry.HREF + " TEXT," +
            LocatorScheme.LocatorEntry.LOCATIONS + " TEXT," +
            LocatorScheme.LocatorEntry.CREATED + " DATETIME)";

    private static final String SQL_DELETE_ENTRIES = "DROP TABLE IF EXISTS " + LocatorScheme.LocatorEntry.TABLE;

    public static final int VERSION = 1;
    public static final String NAME = "epub.db";

    public LocatorDatabase(Context context) {
        super(context, NAME, null, VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(SQL_CREATE_ENTRIES);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL(SQL_DELETE_ENTRIES);
        onCreate(db);
    }

    @Override
    public void onDowngrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        onUpgrade(db, oldVersion, newVersion);
    }

    @Override
    public void onOpen(SQLiteDatabase db) {
        super.onOpen(db);
    }
}
