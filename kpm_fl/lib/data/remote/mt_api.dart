import 'package:dio/dio.dart';
import 'package:kpm_fl/data/data.dart';
// import 'package:retrofit/retrofit.dart';

// abstract class KomplatApi {
//   factory KomplatApi(Dio dio, {String baseUrl}) = _KomplatApi;

//   @POST('/online.request')
//   Future<PsEripListPopularResponseWrapper> listPopularRequest(
//     @Body() PsEripListPopularRequestWrapper body
//   );

//   @POST('/online.request')
//   Future<PsEripGetPayListResponseWrapper> getPayListRequest(
//     @Body() PsEripGetPayListRequestWrapper body
//   );

//   @POST('/online.request')
//   Future<PsEripRunOperationResponseWrapper> runOperationRequest(
//     @Body() PsEripRunOperationRequestWrapper body
//   );

//   @POST('/online.request')
//   Future<PsEripUserProfileResponseWrapper> getUserProfileRequest(
//     @Body() PsEripGetUserProfileRequestWrapper body
//   );

// }

class MtApi {
  final Dio _dio;

  MtApi(this._dio);

  Future<PsMtCheckConnectResponseWrapper> checkConnectionRequest({
    required String baseUrl,
    required PsMtCheckConnectRequestWrapper body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{}
      ..addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsMtCheckConnectResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl)));
    final value = PsMtCheckConnectResponseWrapper.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
