// ignore_for_file: always_put_required_named_parameters_first

import 'package:dio/dio.dart';

import 'data.dart';

class FakeDataManager extends DataManager {
  FakeDataManager(Dio dio) : super(dio);

  Future<void> get _delay => Future<void>.delayed(const Duration(milliseconds: 200));

  @override
  Future<ListPopularResponse> listPopularRequest({
    required int count
  }) async {
    await _delay;
    return const ListPopularResponse(
      payRecord: [
        ListPopularResponsePayRecord(
          code: 123,
          name: 'blabla',
          recordType: 0
        )
      ]
    );
  }

  @override
  Future<GetPayListResponse> getPayListRequest({
    required int payCode,
    String? sessionId,
    List<AttrRecordRequest>? attrRecord,
    double? sum,
    int? currency,
    List<RequestProperty>? properties
  }) async {
    await _delay;
    return const GetPayListResponse(
      // TODO: add fake payRecords
      payRecord: [
        PayRecordResponse(

        )
      ]
    );
  }

  @override
  Future<GetUserProfileResponse> getUserProfileRequest() async {
    await _delay;
    return const GetUserProfileResponse(
      // TODO: add screens data
      screens: []
    );
  }

  @override
  Future<RunOperationResponse> runOperationRequest({
    required PayRecordResponse service,
    required List<AttrRecordRequest> attrs,
    required String kioskReceipt,
    List<RequestProperty>? properties
  }) async {
    await _delay;
    // TODO: add normal mock
    return RunOperationResponse(
      errorCode: 1,
      errorText: 'Unimplemented'
    );
  }

  @override
  Future<OpenBasketResponse> openBasketRequest() async {
    await _delay;
    // TODO: add normal mock
    return const OpenBasketResponse(
      errorCode: 1,
      errorText: 'Unimplemented'
    );
  }

  @override
  Future<CloseBasketResponse> closeBasketRequest({
    required String barcode
  }) async {
    await _delay;
    // TODO: add normal mock
    return const CloseBasketResponse(
      errorCode: 1,
      errorText: 'Unimplemented'
    );
  }

  @override
  Future<ConfirmResponse> confirmRequest({
    required PayRecordResponse service,
    bool isCanceled = false
  }) async {
    await _delay;
    // TODO: add normal mock
    return const ConfirmResponse(
      errorCode: 1,
      errorText: 'Unimplemented'
    );
  }

  @override
  Future<SearchBasketResponse> searchBasket({
    required String barcode,
  }) async {
    await _delay;
    // TODO: add normal mock
    return const SearchBasketResponse(
      errorCode: 1,
      errorText: 'Unimplemented'
    );
  }

  @override
  Future<String> getIpAddress() async {
    await _delay;
    return '127.0.0.1';
  }

  @override
  Future<CheckConnectResponse> checkConnectRequest({
    required String ipAddress
  }) async {
    await _delay;
    // TODO: add normal mock
    return const CheckConnectResponse(
      errorCode: 1,
      errorText: 'Unimplemented'
    );
  }

}