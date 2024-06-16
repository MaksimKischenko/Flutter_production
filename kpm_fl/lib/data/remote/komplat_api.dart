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

class KomplatApi {
  final Dio _dio;

  KomplatApi(this._dio);

  Future<PsEripListPopularResponseWrapper> listPopularRequest({
    required String baseUrl,
    required PsEripListPopularRequestWrapper body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{}
      ..addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsEripListPopularResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl)));
    final value = PsEripListPopularResponseWrapper.fromJson(_result.data!);
    return value;
  }

  Future<PsEripGetPayListResponseWrapper> getPayListRequest({
    required String baseUrl,
    required PsEripGetPayListRequestWrapper body
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{}
      ..addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsEripGetPayListResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl)));
    final value = PsEripGetPayListResponseWrapper.fromJson(_result.data!);
    return value;
  }

  Future<PsEripRunOperationResponseWrapper> runOperationRequest({
    required String baseUrl,
    required PsEripRunOperationRequestWrapper body
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{}
      ..addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsEripRunOperationResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl)));
    final value = PsEripRunOperationResponseWrapper.fromJson(_result.data!);
    return value;
  }

  Future<PsEripUserProfileResponseWrapper> getUserProfileRequest({
    required String baseUrl,
    required PsEripGetUserProfileRequestWrapper body
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{}
      ..addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsEripUserProfileResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl)));
    final value = PsEripUserProfileResponseWrapper.fromJson(_result.data!);
    return value;
  }

  Future<PsEripOpenBasketResponseWrapper> openBasketRequest({
    required String baseUrl,
    required PsEripOpenBasketRequestWrapper body
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{}
      ..addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsEripOpenBasketResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl)));
    final value = PsEripOpenBasketResponseWrapper.fromJson(_result.data!);
    return value;
  }

  Future<PsEripCloseBasketResponseWrapper> closeBasketRequest({
    required String baseUrl,
    required PsEripCloseBasketRequestWrapper body
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{}
      ..addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsEripCloseBasketResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl)));
    final value = PsEripCloseBasketResponseWrapper.fromJson(_result.data!);
    return value;
  }

  Future<PsEripConfirmResponseWrapper> confirmRequest({
    required String baseUrl,
    required PsEripConfirmRequestWrapper body
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{}
      ..addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsEripConfirmResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl)));
    final value = PsEripConfirmResponseWrapper.fromJson(_result.data!);
    return value;
  }

  Future<PsEripSearchBasketResponseWrapper> searchBasketRequest({
    required String baseUrl,
    required PsEripSearchBasketRequestWrapper body
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{}
      ..addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsEripSearchBasketResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl)));
    final value = PsEripSearchBasketResponseWrapper.fromJson(_result.data!);
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
