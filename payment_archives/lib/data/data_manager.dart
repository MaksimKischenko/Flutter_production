import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/utils/utils.dart';

class DataManager {   
  DataManager();

  String? accessToken;
  String? refreshToken;
  String login = '';
  TokenBodyData? tokendata;
  String get authHeader => 'Bearer $accessToken';
  String passwordCrypter(String value) => value.toSha256();
}
