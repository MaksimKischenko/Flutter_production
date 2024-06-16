// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komplat_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _KomplatApi implements KomplatApi {
  _KomplatApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PsTpOInformationResponseWrapper> informationRequest(
      PsTpOInformationRequestWrapper body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json; charset=UTF-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOInformationResponseWrapper>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json; charset=UTF-8',
    )
            .compose(
              _dio.options,
              '/online.request',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PsTpOInformationResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpOClaimsListResponseWrapper> claimsListRequest(
      PsTpOClaimsListRequestWrapper body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json; charset=UTF-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOClaimsListResponseWrapper>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json; charset=UTF-8',
    )
            .compose(
              _dio.options,
              '/online.request',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PsTpOClaimsListResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpODeleteClaimResponseWrapper> deleteClaimRequest(
      PsTpODeleteClaimRequestWrapper body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json; charset=UTF-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpODeleteClaimResponseWrapper>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json; charset=UTF-8',
    )
            .compose(
              _dio.options,
              '/online.request',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PsTpODeleteClaimResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpOAddClaimResponseWrapper> addClaimRequest(
      PsTpOAddClaimRequestWrapper body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json; charset=UTF-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOAddClaimResponseWrapper>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json; charset=UTF-8',
    )
            .compose(
              _dio.options,
              '/online.request',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PsTpOAddClaimResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpOPaymentsListResponseWrapper> paymentsListRequest(
      PsTpOPaymentsListRequestWrapper body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json; charset=UTF-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOPaymentsListResponseWrapper>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json; charset=UTF-8',
    )
            .compose(
              _dio.options,
              '/online.request',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PsTpOPaymentsListResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpOServicesListResponseWrapper> servicesListRequest(
      PsTpOServicesListRequestWrapper body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json; charset=UTF-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOServicesListResponseWrapper>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json; charset=UTF-8',
    )
            .compose(
              _dio.options,
              '/online.request',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PsTpOServicesListResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PsTpOAlgorithmListResponseWrapper> algorithmListRequest(
      PsTpOAlgorithmListRequestWrapper body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json; charset=UTF-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PsTpOAlgorithmListResponseWrapper>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json; charset=UTF-8',
    )
            .compose(
              _dio.options,
              '/online.request',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
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

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
