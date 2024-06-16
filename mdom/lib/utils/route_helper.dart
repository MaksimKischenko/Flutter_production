class RouteHelper {
  /// if url starts with /#/ set to true
  static bool _isHashStrategy = false; //kReleaseMode? true : false;
  /// if you web app is not at root set as example: '/app'
  static String _urlAppend = '';

  RouteHelper({bool isHashStrategy = false, String urlAppend = ''}) {
    _isHashStrategy = isHashStrategy;
    _urlAppend = urlAppend;
  }

  static MapEntry<String, String> parsePathWithStringParams(String value,
      {bool? isHashStrategy}) {
    // print('full url: $value');
    final uri = Uri.parse(value);
    if (isHashStrategy ?? _isHashStrategy) {
      final newUri = Uri.parse(uri.fragment);

      return MapEntry(
          newUri.path,
          newUri.query.isEmpty
              ? newUri.path
              : '${newUri.path}?${newUri.query}');
    } else {
      return MapEntry(
        uri.path.substring(_urlAppend.length),
        uri.query.isEmpty
            ? uri.path.substring(_urlAppend.length)
            : '${uri.path.substring(_urlAppend.length)}?${uri.query}',
      );
    }
  }
}
