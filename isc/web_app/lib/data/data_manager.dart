// ignore_for_file: unnecessary_import

import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:isc_web_app/config.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/models/models.dart';


abstract class DataManager {
  final KomplatISCApi _komplatISCApi;
  final Dio dio;

  DataManager(this.dio)
      : _komplatISCApi = KomplatISCApi(dio, baseUrl: AppConfig.komplatISCApi);

  int get key => DateTime.now().millisecondsSinceEpoch;

  KomplatISCApi get komplatISCApi => _komplatISCApi;

  Future<String> get lang async =>
      (await PreferencesHelper.read(PrefsKeys.language))!;

  List<MdomResponseParam>? userParams = [];
  String? email;
  String get username {
    final name =
        userParams?.firstOrNullWhere((param) => param.id == 13)?.evalue;
    final surname =
        userParams?.firstOrNullWhere((param) => param.id == 12)?.evalue;
    return "${name ?? ''} ${surname ?? ''}";
  }

  String token = '';
  String terminalId = '';
  int versionKomplat = 4;
  final int version = 1;
  String versionReg = '1';
  final String mdomTpInfoVersion = '1';
  final String mdomTpIntVersion = '1';



  Future<MdomLoginResponse> loginRequest(
      {String? login, String? password, int? code});


  Future<ClaimsListResponse> claimsListRequest({
    required DateTime from,
    required DateTime to,
    required ClaimStatus status,
    int? claimId,
    String? accNum,
    int? count,
    int? lastClaimId,
  });

  Future<AddClaimResponse> addClaimRequest(AddClaimRequest claim);

  Future<PaymentsListResponse> paymentListRequest({
    required DateTime from,
    required DateTime to,
    required PaymentStatus status,    
    required PaymentDateType dateType,   
    String? accNum,
    int? claimId,
    int? count,
    int? lastPaymentId,
  });

  Future<RegisterPaymentOfClaimResponse> registerPaymentOfClaimRequest({
    required int claimId,
    required String memNumber, 
    required DateTime memDate,
    required double paySum,
    required String account,
  });
}
