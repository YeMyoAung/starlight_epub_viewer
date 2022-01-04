package com.starlight.starlight_epub_viewer;

import android.content.Context;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import androidx.annotation.NonNull;

/** EpubReaderPlugin */
public class EpubViewerPlugin implements MethodCallHandler, FlutterPlugin, ActivityAware {

  private Reader reader;
  private ReaderConfig config;
  private Context context;
  private static final String channelName = "starlight_epub";

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    context = binding.getApplicationContext();
    MethodChannel channel = new MethodChannel(binding.getFlutterEngine().getDartExecutor(), channelName);
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // TODO: your plugin is no longer attached to a Flutter experience.
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
    activityPluginBinding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {

  }

  @Override
  public void onDetachedFromActivity() {
  }

  @Override
  public void onMethodCall(MethodCall call, @NonNull Result result) {

    switch (call.method) {
      case "setConfig": {
        String themeColor = call.argument("themeColor");
        String scrollDirection = call.argument("scrollDirection");
        boolean setShowRemainingIndicator = call.argument("setShowRemainingIndicator");
        boolean nightMode = call.argument("nightMode");
        boolean enableTts = call.argument("enableTts");
        config = new ReaderConfig(themeColor,
            scrollDirection == null ? "" : scrollDirection, setShowRemainingIndicator, enableTts, nightMode);

        break;
      }
      case "open": {
        String bookPath = call.argument("bookPath");
        reader = new Reader(context, config);
        reader.open(bookPath);
        break;
      }
      case "close":
        reader.close();
        break;
      default:
        result.notImplemented();
        break;
    }
  }
}
