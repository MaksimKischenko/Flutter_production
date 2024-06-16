import 'package:dio/dio.dart' hide Headers;
import 'package:fl_qr_module/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'komplat_qr_api.g.dart';

@RestApi()
abstract class KomplatQrApi {
  factory KomplatQrApi(Dio dio, {String baseUrl}) = _KomplatQrApi;

  @GET('/')
  Future<PsHelppayGetPrimarySecretKeyResponseWrapper>
      getPrimarySecretKeyRequest({
    @Query('terminalId') required String terminalId,
  });

  @POST('/')
  @Headers(<String, dynamic>{
    'Content-Type': 'text/plain; charset=UTF-8',
  })
  Future<HttpResponse<String>> getSecretKeyRequest({
    @Header('TerminalId') required String terminalId,
    @Header('RequestTime') required String operationTime,
    @Body() required String body,
  });

  @POST('')
  @Headers(<String, dynamic>{
    'Content-Type': 'text/plain; charset=UTF-8',
  })
  Future<HttpResponse<String>> getQrRequest({
    @Header('TerminalId') required String terminalId,
    @Header('RequestTime') required String operationTime,
    @Body() required String body,
  });

  @POST('')
  @Headers(<String, dynamic>{
    'Content-Type': 'text/plain; charset=UTF-8',
  })
  Future<HttpResponse<String>> confirmQrPaymentRequest({
    @Header('TerminalId') required String terminalId,
    @Header('RequestTime') required String operationTime,
    @Body() required String body,
  });

  @POST('/')
  @Headers(<String, dynamic>{
    'Content-Type': 'text/plain; charset=UTF-8',
  })
  Future<HttpResponse<String>> getQROperationRequest({
    @Header('TerminalId') required String terminalId,
    @Header('RequestTime') required String operationTime,
    @Body() required String body,
  });

  @POST('/')
  @Headers(<String, dynamic>{
    'Content-Type': 'text/plain; charset=UTF-8',
  })
  Future<HttpResponse<String>> getQRCheckDuplicateRequest({
    @Header('TerminalId') required String terminalId,
    @Header('RequestTime') required String operationTime,
    @Body() required String body,
  });

  @POST('/')
  @Headers(<String, dynamic>{
    'Content-Type': 'text/plain; charset=UTF-8',
  })
  Future<HttpResponse<String>> getRequestStatusRequest({
    @Header('TerminalId') required String terminalId,
    @Header('RequestTime') required String operationTime,
    @Body() required String body,
  });

  @POST('/')
  @Headers(<String, dynamic>{
    'Content-Type': 'text/plain; charset=UTF-8',
  })
  Future<HttpResponse<String>> registerPaymentRequest({
    @Header('TerminalId') required String terminalId,
    @Header('RequestTime') required String operationTime,
    @Body() required String body,
  });

  @POST('/')
  @Headers(<String, dynamic>{
    'Content-Type': 'text/plain; charset=UTF-8',
  })
  Future<HttpResponse<String>> registerPaymentMethodRequest({
    @Header('TerminalId') required String terminalId,
    @Header('RequestTime') required String operationTime,
    @Body() required String body,
  });

  @POST('/')
  @Headers(<String, dynamic>{
    'Content-Type': 'text/plain; charset=UTF-8',
  })
  Future<HttpResponse<String>> confirmPaymentMethodRequest({
    @Header('TerminalId') required String terminalId,
    @Header('RequestTime') required String operationTime,
    @Body() required String body,
  });
}
