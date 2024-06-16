
import 'dart:io';

import 'package:bpc_nkfo/config.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:local_auth/local_auth.dart';

import 'data.dart';

abstract class DataManager {
  final KomplatApi _komplatApi;
  final Dio dio;

  DataManager(this.dio) : _komplatApi = KomplatApi(dio, baseUrl: AppConfig.komplatApiUrl);

  KomplatApi get komplatApi => _komplatApi;

  final int minPasswordLength = 6;
  final int version = 1;
  String token = '';

  InformationResponse? informationResponse;

  //todo(set List, not mutable)
  List<Service> servicesList = <Service>[];

  Service? currentService;
  late String currentDateFrom;
  late String currentDateTo;

  int get key => DateTime.now().millisecondsSinceEpoch;

  bool get availableFeatures => informationResponse?.confirmStatus == 1 && servicesList.firstOrNull != null;

  bool isCredentialsSaveChecked = false;

  bool get isAvailableBiometricAuth => availableBiometrics.isNotEmpty;
  List<BiometricType> availableBiometrics = <BiometricType>[];
  bool authWithBiometricsFlag = false;
  KomplatBiometricType get komplatBiometricType {
    var temp = KomplatBiometricType.biometric;
    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        temp = KomplatBiometricType.touchid;
      } else if (availableBiometrics.contains(BiometricType.face)) {
        temp = KomplatBiometricType.faceid;
      }
    }
    return temp;
  }
  bool safeViewVisible = false;
  bool needCheckPin = false;

  //private val compositeDisposable = CompositeDisposable()

  Future<TokenResponse> tokenRequest(String login, String password);

  Future<DeleteTokenResponse> deleteTokenRequest(String token);

  Future<InformationResponse> informationRequest();

  Future<ClaimsListResponse> claimsListRequest({
    required int code,
    required String from, required String to, int? status,
    String? accNum,
    RowCountClaims? rowCount
  });

  Future<DeleteClaimResponse> deleteClaimRequest(int id);

  Future<AddClaimResponse> addClaimRequest(AddClaimRequest claim);

  Future<SupplierStatusResponse> supplierStatusRequest();

  Future<PaymentsListResponse> paymentListRequest({
    required int serviceCode,
    required int dateType,
    required String from,
    required String to,
    String? accNum,
    int? status,
    int? claimId,
    RowCountPayments? rowCount
  });

  Future<ServicesListResponse> servicesListRequest();

  Future<AlgorithmListResponse> algorithmListRequest(int code);

  Future loadServicesList();
}