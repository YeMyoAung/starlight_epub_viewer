part of starlight_epub_viewer;

const MethodChannel _channel = const MethodChannel('starlight_epub');

class StarlightEpubViewer {
  const StarlightEpubViewer._();

  @deprecated
  Future<void> get init => _init();

  /// Initializing
  /// Being initialize viewer will create a database for you
  @deprecated
  static Future<void> _init() async {
    try {
      final Directory _application = await getApplicationDocumentsDirectory();
      final File _db = File("${_application.path}/database");
      if (Platform.isIOS && !_db.existsSync()) {
        final ByteData _data = await rootBundle.load("assets/db/database");
        _db.writeAsBytesSync(_data.buffer.asUint8List());
      }
    } catch (e) {
      ///
    }
  }

  /// Configure Viewer's with available values
  ///
  /// themeColor is the color of the reader
  /// if nightMode is true,reader will open with night mode
  /// scrollDirection uses the [StarlightEpubViewerScrollDirection] enum
  /// if allowSharing is true,epub file can be share!
  /// enableTts is an option to enable the inbuilt Text-to-Speech
  /// if setShowRemainingIndicator is true,indicator will show bottom of reader
  static Future<void> setConfig({
    Color themeColor = Colors.blue,
    bool nightMode = false,
    StarlightEpubViewerScrollDirection scrollDirection =
        StarlightEpubViewerScrollDirection.ALLDIRECTIONS,
    bool allowSharing = false,
    bool enableTts = false,
    bool setShowRemainingIndicator = true,
  }) async {
    Map<String, dynamic> agrs = {
      "themeColor": _StarlightEpubViewerUtil.getHexFromColor(themeColor),
      "scrollDirection": _StarlightEpubViewerUtil.getDirection(scrollDirection),
      "allowSharing": allowSharing,
      'enableTts': enableTts,
      'nightMode': nightMode,
      'setShowRemainingIndicator': setShowRemainingIndicator
    };
    await _channel.invokeMethod('setConfig', agrs);
  }

  /// bookPath should be a local file.
  static Future<void> open(String bookPath) async {
    Map<String, dynamic> agrs = {"bookPath": bookPath};
    await _channel.invokeMethod('open', agrs);
  }

  /// bookPath should be an asset file path.
  static Future openAsset(String bookPath) async {
    if (extension(bookPath) == '.epub') {
      Map<String, dynamic> agrs = {
        "bookPath":
            (await _StarlightEpubViewerUtil.getFileFromAsset(bookPath)).path,
      };
      await _channel.invokeMethod('open', agrs);
    } else {
      throw _StarlightEpubViewerException(
        error: '${extension(bookPath)} cannot be opened.',
        message:
            "File extension must be .epub.Check your file and if not epub,use an epub file.",
      );
    }
  }
}
