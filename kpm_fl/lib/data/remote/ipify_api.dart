import 'package:dio/dio.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'ipify_api.g.dart';

@RestApi(baseUrl: 'https://api.ipify.org/')
abstract class IpifyApi {
  factory IpifyApi(Dio dio, {String baseUrl}) = _IpifyApi;

  @GET('/?format=json')
  Future<IpifyResponse> getIpRequest();

}