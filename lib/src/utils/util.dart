part of starlight_epub_viewer;

class _StarlightEpubViewerUtil {
  static String getHexFromColor(Color color) {
    return '#${color.toString().replaceAll('ColorSwatch(', '').replaceAll('Color(0xff', '').replaceAll('MaterialColor(', '').replaceAll('MaterialAccentColor(', '').replaceAll('primary value: Color(0xff', '').replaceAll('primary', '').replaceAll('value:', '').replaceAll(')', '').trim()}';
  }

  static String getDirection(StarlightEpubViewerScrollDirection direction) {
    switch (direction) {
      case StarlightEpubViewerScrollDirection.VERTICAL:
        return 'vertical';
      case StarlightEpubViewerScrollDirection.HORIZONTAL:
        return 'horizontal';
      case StarlightEpubViewerScrollDirection.ALLDIRECTIONS:
        return 'alldirections';
      default:
        return 'alldirections';
    }
  }

  static Future<File> getFileFromAsset(String asset) async {
    ByteData data = await rootBundle.load(asset);
    String dir = (await getTemporaryDirectory()).path;
    String path = '$dir/${basename(asset)}';
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
