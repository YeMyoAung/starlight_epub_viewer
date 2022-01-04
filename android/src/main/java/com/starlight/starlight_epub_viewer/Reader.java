package com.starlight.starlight_epub_viewer;

import android.content.Context;
import android.content.ContentValues;
import android.database.Cursor;
import android.util.Log;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.folioreader.FolioReader;
import com.folioreader.model.HighLight;
import com.folioreader.model.locators.ReadLocator;
import com.folioreader.util.OnHighlightListener;
import com.folioreader.util.ReadLocatorListener;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reader implements OnHighlightListener, ReadLocatorListener, FolioReader.OnClosedListener {

    private final ReaderConfig readerConfig;
    public FolioReader folioReader;
    private final Context context;
    private ReadLocator read_locator;
    private static String path;
    private static LocatorDatabase locatorDatabase;

    Reader(Context context, ReaderConfig config) {
        this.context = context;
        locatorDatabase = new LocatorDatabase(context);
        this.readerConfig = config;
        getHighlightsAndSave();
        this.folioReader = FolioReader.get()
                .setOnHighlightListener(this)
                .setReadLocatorListener(this)
                .setOnClosedListener(this);
    }

    public void open(String bookPath) {
        path = bookPath;
        new Thread(() -> {
            try {
                final Cursor _data = locatorDatabase.getReadableDatabase().rawQuery("SELECT * "
                        + "FROM " + LocatorScheme.LocatorEntry.TABLE + " WHERE `" + LocatorScheme.LocatorEntry.ID
                        + "` = ?", new String[] { path.split("/")[path.split("/").length - 1] });
                if (_data.moveToLast()) {
                    ReadLocator readLocator = ReadLocator.fromJson(
                            "{\"bookId\":\"" + _data.getString(_data.getColumnIndex("bookId")) + "\",\"href\":\""
                                    + _data.getString(_data.getColumnIndex("href")) + "\",\"created\":\""
                                    + _data.getString(_data.getColumnIndex("created")) + "\",\"locations\":{\"cfi\":\""
                                    + _data.getString(_data.getColumnIndex("locations")) + "\"},\"title\":\"\"}");
                    folioReader.setReadLocator(readLocator);
                }
                _data.close();
                folioReader
                        .setConfig(readerConfig.config, true)
                        .openBook(path);
                // folioReader.openBook(path);

            } catch (Exception e) {
                Log.i("EPUB OPEN ERROR", e.toString());
                Log.i("EPUB OPEN ERROR", e.getLocalizedMessage());
                Log.i("EPUB OPEN ERROR", e.getMessage());
                Log.i("EPUB OPEN ERROR", Arrays.toString(e.getStackTrace()));
                e.printStackTrace();
            }
        }).start();
    }

    public void close() {
        Log.i("epubReader", "close");
        folioReader.close();
    }

    private void getHighlightsAndSave() {
        new Thread(() -> {
            ArrayList<HighLight> highlightList = null;
            ObjectMapper objectMapper = new ObjectMapper();
            try {
                highlightList = objectMapper.readValue(
                        loadAssetTextAsString(),
                        new TypeReference<List<HighlightData>>() {
                        });
            } catch (IOException e) {
                Log.i("EPUB HIGHLIGHT ERROR", e.toString());
                Log.i("EPUB HIGHLIGHT ERROR", e.getLocalizedMessage());
                Log.i("EPUB HIGHLIGHT ERROR", e.getMessage());
                Log.i("EPUB HIGHLIGHT ERROR", Arrays.toString(e.getStackTrace()));
                Log.i("EPUB HIGHLIGHT ERROR", Arrays.toString(e.getStackTrace()));
                e.printStackTrace();
            }

            if (highlightList != null) {
                folioReader.saveReceivedHighLights(highlightList, () -> {

                    // You can do anything on successful saving highlight list
                });
            }
        }).start();
    }

    private String loadAssetTextAsString() {
        BufferedReader in = null;
        try {
            StringBuilder buf = new StringBuilder();
            InputStream is = context.getAssets().open("highlights/highlights_data.json");
            in = new BufferedReader(new InputStreamReader(is));

            String str;
            boolean isFirst = true;
            while ((str = in.readLine()) != null) {
                if (isFirst)
                    isFirst = false;
                else
                    buf.append('\n');
                buf.append(str);
            }
            return buf.toString();
        } catch (IOException e) {
            Log.e("EPUB LOAD ASSET ERROR", "Error opening asset " + "highlights/highlights_data.json");
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                    Log.e("EPUB LOAD ASSET ERROR", "Error closing asset " + "highlights/highlights_data.json");
                }
            }
        }
        return null;
    }

    @Override
    public void onFolioReaderClosed() {
        final ContentValues _value = new ContentValues();
        _value.put(LocatorScheme.LocatorEntry.ID, path.split("/")[path.split("/").length - 1]);
        _value.put(LocatorScheme.LocatorEntry.BOOK, read_locator.getBookId());
        _value.put(LocatorScheme.LocatorEntry.TITLE, read_locator.getTitle());
        _value.put(LocatorScheme.LocatorEntry.HREF, read_locator.getHref());
        _value.put(LocatorScheme.LocatorEntry.LOCATIONS, read_locator.getLocations().getCfi());
        _value.put(LocatorScheme.LocatorEntry.CREATED, read_locator.getCreated());
        final Cursor _data = locatorDatabase.getReadableDatabase().rawQuery("SELECT * "
                + "FROM " + LocatorScheme.LocatorEntry.TABLE + " WHERE `" + LocatorScheme.LocatorEntry.ID + "` = ?",
                new String[] { path.split("/")[path.split("/").length - 1] });

        if (_data.moveToLast()) {
            locatorDatabase.getWritableDatabase().update(LocatorScheme.LocatorEntry.TABLE, _value,
                    LocatorScheme.LocatorEntry.ID + " = ?",
                    new String[] { path.split("/")[path.split("/").length - 1] });
        } else {
            locatorDatabase.getWritableDatabase().insert(LocatorScheme.LocatorEntry.TABLE, null, _value);
        }
        _data.close();
    }

    @Override
    public void onHighlight(HighLight highlight, HighLight.HighLightAction type) {
    }

    @Override
    public void saveReadLocator(ReadLocator readLocator) {
        read_locator = readLocator;
    }

}
