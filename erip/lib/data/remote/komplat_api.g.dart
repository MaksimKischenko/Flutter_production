// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komplat_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _KomplatApi implements KomplatApi {
  _KomplatApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<String> testRequest() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/online.request',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<PsTpOTokenResponseWrapper> tokenRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOTokenResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PsTpOTokenResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpODeleteTokenResponseWrapper> deleteTokenRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpODeleteTokenResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PsTpODeleteTokenResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpOInformationResponseWrapper> informationRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOInformationResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PsTpOInformationResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpOClaimsListResponseWrapper> claimsListRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOClaimsListResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PsTpOClaimsListResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpODeleteClaimResponseWrapper> deleteClaimRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpODeleteClaimResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PsTpODeleteClaimResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpOAddClaimResponseWrapper> addClaimRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOAddClaimResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PsTpOAddClaimResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpOSupplierStatusResponseWrapper> supplierStatusRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOSupplierStatusResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PsTpOSupplierStatusResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpOPaymentsListResponseWrapper> paymentsListRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOPaymentsListResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PsTpOPaymentsListResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpOServicesListResponseWrapper> servicesListRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOServicesListResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PsTpOServicesListResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpOAlgorithmListResponseWrapper> algorithmListRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOAlgorithmListResponseWrapper>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/online.request',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PsTpOAlgorithmListResponseWrapper.fromJson(_result.data!);
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
