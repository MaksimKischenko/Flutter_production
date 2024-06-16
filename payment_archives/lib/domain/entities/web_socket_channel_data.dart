// ignore_for_file: public_member_api_docs, sort_constructors_first
class WebSocketChannelData {
  String uri;
  String channelName;

  WebSocketChannelData({
    required this.uri,
    required this.channelName,
 
  });

  @override
  String toString() => 'WebSocketChannelData(uri: $uri, channelName: $channelName)';
}

