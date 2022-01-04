part of starlight_epub_viewer;

class _StarlightEpubViewerException implements Exception {
  final String _error;
  final String _message;

  const _StarlightEpubViewerException({
    required String error,
    required String message,
  })  : _error = error,
        _message = message;

  @override
  String toString() {
    return '''
    Starlight Studio Package
    ════════════════════════════════════════════════════════
    Error: $_error
    How To Fix: $_message
    Contact Us: 
    https://www.facebook.com/starlightstudio.of/
    Phone No: +959959165151
    Starlight Team Email: starlightstudio.team@gmail.com
    Developer Email: yemyo994@gmail.com
    For More Packages
    https://github.com/YeMyoAung
    
    ════════════════════════════════════════════════════════
    ''';
  }
}
