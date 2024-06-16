class RouteHelper {
  /// if url starts with /#/ set to true
  static bool _isHashStrategy = false; //kReleaseMode? true : false;
  /// if you web app is not at root set as example: '/app'
  static String _urlAppend = '';
  
  RouteHelper({
    bool isHashStrategy = false,
    String urlAppend = ''
  }) {
    _isHashStrategy = isHashStrategy;
    _urlAppend = urlAppend;
  }

  static MapEntry<String, Map<String,String>> parsePath(
    String value,
    {bool? isHashStrategy,
    String? urlAppender}
  ) {
    // print('full url: $value');
    final uri = Uri.parse(value);
    if (isHashStrategy ?? _isHashStrategy) {
      final newUri = Uri.parse(uri.fragment);
      // _print(newUri.path, newUri.queryParameters);
      return MapEntry(newUri.path, newUri.queryParameters);
    } else {
      // _print(uri.path.substring(_urlAppend.length), uri.queryParameters);
      return MapEntry(uri.path.substring(urlAppender?.length ?? _urlAppend.length), uri.queryParameters); 
    }
  }

  static MapEntry<String, String> parsePathWithStringParams(
    String value,
    {bool? isHashStrategy,
    String? urlAppender}
  ) {
    // print('full url: $value');
    final uri = Uri.parse(value);
    if (isHashStrategy ?? _isHashStrategy) {
      final newUri = Uri.parse(uri.fragment);
      // _print(newUri.path, newUri.queryParameters);
      return MapEntry(newUri.path, newUri.query.isEmpty ? newUri.path : '${newUri.path}?${newUri.query}');
    } else {
      // _print(uri.path.substring(_urlAppend.length), uri.queryParameters);
      return MapEntry(uri.path.substring(urlAppender?.length ?? _urlAppend.length), uri.query.isEmpty ? uri.path.substring(urlAppender?.length ?? _urlAppend.length) : '${uri.path.substring(urlAppender?.length ?? _urlAppend.length)}?${uri.query}');
    }
  }

  static void _print(String path, Map<String, String> params) {
    // ignore: avoid_print
    print('path $path');
    params.forEach((key, value) {
      // ignore: avoid_print
      print('$key : $value');
    });
  }
}