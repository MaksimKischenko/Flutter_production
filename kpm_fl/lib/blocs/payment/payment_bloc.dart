// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/models/models.dart';
import 'package:tuple/tuple.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final DataManager dataManager;

  PaymentBloc({
    required this.dataManager,
  }) : super(PaymentLoading()) {
    on<PaymentEvent>(_onEvent);
  }

  String get kioskReceipt => dataManager.kioskReceipt!;

  void _onEvent(
    PaymentEvent event,
    Emitter<PaymentState> emit
  ) {
    if (event is PaymentGetInfo) return _onPaymentGetInfo(event, emit);
    if (event is PaymentInputFieldsFinished) return _onPaymentInputFieldsFinished(event, emit);
    if (event is PaymentFinish) return _onPaymentFinish(event, emit);
  }

  String? serviceName;
  String? accNumName;

  void _onPaymentGetInfo(
    PaymentGetInfo event,
    Emitter<PaymentState> emit
  ) async {
    emit(PaymentLoading());

    try {
      final response = await dataManager.getPayListRequest(
        payCode: event.code
      );
      if ((response.errorCode ?? 0) == 0) {
        final service = response.payRecord?.first;

        if (service == null) {
          emit(const PaymentError(
            error: 'Не удалось получить информацию об услуге'
          ));
        } else {
          serviceName = service.name;
          accNumName = service.attrRecord?.firstOrNullWhere((e) => e.codeOut == 10001)?.name;

          emit(PaymentInputFields(
            payCode: event.code,
            service: service,
            finishedAttrs: const [],
            properties: getProperties(service.claims)
          ));
        }
      } else {
        emit(PaymentErrorKomplat(
          request: RequestType.getPayList,
          errorCode: response.errorCode,
          errorText: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(PaymentError(error: error));
    }
  }

  void _onPaymentInputFieldsFinished(
    PaymentInputFieldsFinished event,
    Emitter<PaymentState> emit
  ) async {
    final tempState = state;
    emit(PaymentLoading());

    try {
      if (event.service.getPayListType == 0) {
        // runOperation
        // var response = await _dataManager.runOperationRequest(service: null, attrs: null)

        // navigate to serviceResult
        // final finishedAttrsList = event.finishedAttrs ?? [];
        final finishedAttrsList = [...event.finishedAttrs, ..._getFinishedAttrsListFromService(
          event.service,
          attrsEdited: event.attrsEdited
        )];

        emit(PaymentResult(
          service: event.service.copyWith(
            summa: event.sum,
          ),
          lastAttrs: event.attrsEdited,
          finishedAttrs: finishedAttrsList,
          properties: event.properties
          // properties: getProperties(event.service.claims)
        ));
      }
      if (event.service.getPayListType == 1) {
        // getPayList
        final response = await dataManager.getPayListRequest(
          payCode: event.payCode,
          sessionId: event.service.sessionId,
          attrRecord: event.attrsEdited,
          sum: event.sum,
          currency: event.service.currency,
          properties: event.properties.map((e) => RequestProperty(
            idx: e.idx,
            evalue: e.evalue,
          )).toList()
        );
        if ((response.errorCode ?? 0) == 0) {
          final service = response.payRecord?.first;
          if (service == null) {
            emit(const PaymentError(
              error: 'Не удалось получить информацию об услуге'
            ));
          } else {
            if (service.attrRecord?.isEmpty ?? true && (service.view ?? 0) == 0) {
              emit(const PaymentError(
                error: 'Не удалось получить информацию об услуге'
              ));
            } else {
              // final finishedAttrsList = event.finishedAttrs ?? List<Tuple2<String, dynamic>>();
              final finishedAttrsList = [...event.finishedAttrs, ..._getFinishedAttrsListFromService(
                event.service,
                attrsEdited: event.attrsEdited
              )];

              emit(PaymentInputFields(
                payCode: event.payCode,
                service: service,
                finishedAttrs: finishedAttrsList,
                properties: getProperties(service.claims)
              ));
            }
          }
        } else {
          emit(PaymentErrorKomplatDialog(
            request: RequestType.getPayList,
            errorCode: response.errorCode,
            errorText: response.errorText
          ));
          emit(tempState);
        }
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(PaymentErrorDialog(error: error));
      emit(tempState);
    }
  }

  void _onPaymentFinish(
    PaymentFinish event,
    Emitter<PaymentState> emit
  ) async {
    if (state is PaymentResult) {
      final currentState = state as PaymentResult;
      emit(PaymentLoading());

      late PayRecordResponse runOperationResponsePayRecord;
      // String? runOperationKioskReceipt;
      // final checkList = <String>[];

      try {
        final runOperationResponse = await dataManager.runOperationRequest(
          service: currentState.service,
          attrs: currentState.lastAttrs,
          kioskReceipt: kioskReceipt,
          properties: currentState.properties.map((e) => RequestProperty(
            idx: e.idx,
            evalue: e.evalue,
          )).toList()
        );
        if ((runOperationResponse.errorCode ?? 0) == 0) {
          // increase payments in basket count
          dataManager.paymentsCount++;
          runOperationResponsePayRecord = runOperationResponse.payRecord!.first;
          // runOperationKioskReceipt = runOperationResponse.kioskReceipt;

          // final checkHeader = runOperationResponse.payRecord?.check?.checkHeader?.checkLine?.map((e) => e.evalue).toList();
          // final checkFooter = runOperationResponse.payRecord?.check?.checkFooter?.checkLine?.map((e) => e.evalue).toList();

          // checkHeader?.forEach((value) {
          //   if (value?.isNotEmpty ?? false) checkList.add(value!);
          // });
          // checkFooter?.forEach((value) {
          //   if (value?.isNotEmpty ?? false) checkList.add(value!);
          // });

          emit(PaymentSuccess(
            payment: runOperationResponsePayRecord,
            serviceName: serviceName ?? 'Услуга',
            accNumName: accNumName ?? 'Счет'
            // paymentId: runOperationResponse.payRecord?.paymentID ?? -1,
            // checkList: checkList
          ));
        } else {
          emit(PaymentErrorKomplatDialog(
            request: RequestType.runOperation,
            errorCode: runOperationResponse.errorCode,
            errorText: runOperationResponse.errorText
          ));
          emit(currentState);
        }
      // ignore: avoid_catches_without_on_clauses
      } catch(error, _) {
        emit(PaymentErrorDialog(error: error));
        emit(currentState);
      }
    }
  }

  List<ResponseClaimProperty> getProperties(List<ResponseClaim>? claims) {
    final properties = <ResponseClaimProperty>[];
    
    for (final claim in claims ?? <ResponseClaim?>[]) {
      if (claim != null) {
        for (final property in claim.properties ?? <ResponseClaimProperty?>[]) {
          if (property != null) properties.add(property);
        }
      }
    }

    return properties;
  }

  List<Tuple2<String, dynamic>> _getFinishedAttrsListFromService(
    PayRecordResponse service,
    {required List<AttrRecordRequest> attrsEdited}
  ) {
    final _finalList = <Tuple2<String, String?>>[];
    // var _finalList = [];

    for (final attr in attrsEdited) {
      AttrRecordResponse? tempAttr;
      final _index = service.attrRecord?.indexWhere((element) => element.code == attr.code) ?? -1;
      if (_index > -1) tempAttr = service.attrRecord?[_index];
      if (tempAttr != null && _filter(tempAttr)) _finalList.add(Tuple2<String, String?>(tempAttr.name!, attr.value));
    }

    return _finalList;
  }

  /// filter visible elements
  bool _filter(AttrRecordResponse attr) {
    if ((attr.view ?? 0) == 0) return false;
    if ((attr.edit ?? 0) == 0) return false;
    return true;
  }
}