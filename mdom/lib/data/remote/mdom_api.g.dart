// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mdom_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _MdomApi implements MdomApi {
  _MdomApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<MdomCreateResponseWrapper> createRequest(
      MdomCreateRequestWrapper body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json; charset=UTF-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MdomCreateResponseWrapper>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json; charset=UTF-8',
    )
            .compose(
              _dio.options,
              '/user/online.request',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = MdomCreateResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MdomEditUserResponseWrapper> editUserRequest(
      MdomEditUserRequestWrapper body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json; charset=UTF-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MdomEditUserResponseWrapper>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json; charset=UTF-8',
    )
            .compose(
              _dio.options,
              '/user/online.request',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = MdomEditUserResponseWrapper.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MdomLoginResponseWrapper> loginRequest(
      MdomLoginRequestWrapper body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json; charset=UTF-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MdomLoginResponseWrapper>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json; charset=UTF-8',
    )
            .compose(
              _dio.options,
              '/user/online.request',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = MdomLoginResponseWrapper.fromJson(_result.data!);
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
