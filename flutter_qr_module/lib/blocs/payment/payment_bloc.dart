

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_qr_module/data/data.dart';
import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/utils/date_helper.dart';
import 'package:fl_qr_module/utils/qr_erip.dart';
import 'package:tuple/tuple.dart';

part 'payment_event.dart';
part 'payment_state.dart';


class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final DataManager dataManager;

  PaymentBloc({required this.dataManager}) : super(PaymentLoading()) {
    on<PaymentEvent>(_onEvent);
  }

  Future<void>? _onEvent(
    PaymentEvent event,
    Emitter<PaymentState> emit,
  ) {
    //RunOperationRequest
    if (event is PaymentGetInfo) return _onPaymentGetInfo(event, emit);
    if (event is PaymentInputFieldsFinished) {
      return _onPaymentInputFieldsFinished(event, emit);
    }
    if (event is PaymentRunOperation) {
      return _onPaymentRunOperation(event, emit);
    }
    return null;
  }

  Future<void> _onPaymentGetInfo(
    PaymentGetInfo event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());

    var doWhileGetPayListTypeIsOne = true;

    if(event.data.accNum == null) {
      emit(PaymentAdditionInfo(
        data: event.data
      ));
    } else {
        try {
          final primaryResponse = await dataManager.getPayListRequest(
              diType: 9120,
              payCode: 0,
              filter: FilterQr(attrRecordQr: [
                AttrRecordQr(attrCode: '314', value: event.data.eripCode),
              ]));

          var dymanicPayCode = primaryResponse.payRecord?.first.code;

          if (primaryResponse.errorCode == 0) {
            if (primaryResponse.payRecord?.first.getPayListType == 2) {
              do {
                final confirmResponse = await dataManager.getPayListRequest(
                    payCode: dymanicPayCode,
                    diType: primaryResponse.payRecord?.first.diType ?? 0,
                    filter: FilterQr(attrRecordQr: [
                      AttrRecordQr(attrCode: '314', value: event.data.eripCode),
                    ]));

                dymanicPayCode = confirmResponse.payRecord?.first.code;

                if (confirmResponse.payRecord?.first.getPayListType == 1) {
                  final finalResponseWithoutAttrRecords =
                      await dataManager.getPayListRequest(
                    diType: confirmResponse.payRecord?.first.diType ?? 0,
                    payCode: confirmResponse.payRecord?.first.code,
                  );

                  //Из последнего ответа с getPayListType = 1 вытягиваем AttrRecordsRequest
                  final attrRecordsRequest = <AttrRecordRequest>[];

                  finalResponseWithoutAttrRecords.payRecord?.first.attrRecord
                      ?.forEach((element) {
                    attrRecordsRequest.add(AttrRecordRequest(
                        code: element.code ?? 0,
                        codeOut: element.codeOut,
                        value: (element.code == 0 && element.codeOut == 1001)
                            ? event.data.accNum
                            : element.value,
                        name: element.name,
                        change: element.edit == 1 ? 1 : element.change));
                  });
                  final finalResponseWithAttrRecords =
                      await dataManager.getPayListRequest(
                          diType: confirmResponse.payRecord?.first.diType ?? 0,
                          payCode: confirmResponse.payRecord?.first.code,
                          attrRecord: attrRecordsRequest);

                  final service = finalResponseWithAttrRecords.payRecord;
                  final finishAttrRecord = finalResponseWithAttrRecords
                      .payRecord?.first.attrRecord
                      ?.firstWhere((element) => element.code == 305);

                  if (service == null) {
                    emit(PaymentError(
                      error: finalResponseWithAttrRecords.errorText ?? '')); 
                  } 
                  else {

                    if(finalResponseWithAttrRecords
                      .payRecord?.first.edit == 0) {
                      emit(PaymentSkipInputAndConfirmation(
                          service: service.first,
                          attrs: service.first.attrRecord?.map(
                          (attr) => AttrRecordRequest(
                            code: attr.code ?? 0,
                            codeOut: attr.codeOut,
                            value: attr.value.toString(),
                            change: 0,
                          ),
                        ).toList() ?? []
                      ));
                    } else {
                      emit(
                        PaymentInputFields(
                          payCode: service.first.code,
                          service: service.first,
                          attrRecord: finishAttrRecord,
                          finishedAttrs: const [],
                        ),
                      );
                    }
                  }
                  doWhileGetPayListTypeIsOne = false;
                  break;
                }
              } while (doWhileGetPayListTypeIsOne);
            }
          } else {
            emit(PaymentErrorKomplat(
                errorCode: primaryResponse.errorCode,
                errorMessage: primaryResponse.errorText));
          }
        } catch (error) {
          emit(PaymentError(error: error));
        }
    }
  }

  Future<void> _onPaymentInputFieldsFinished(
    PaymentInputFieldsFinished event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());

    try {
      if (event.service.getPayListType == 0) {
        final finishedAttrsList = [
          ...event.finishedAttrs,
          ..._getFinishedAttrsListFromService(
            event.service,
            attrsEdited: event.attrsEdited
          )
        ];
        emit(PaymentResult(
            service: event.service.copy(
              summa: event.sum,
            ),
            lastAttrs: event.attrsEdited,
            finishedAttrs: finishedAttrsList));
      }
    } catch (error) {
      emit(PaymentErrorDialog(error: error));
    }
  }

  Future<void> _onPaymentRunOperation(
    PaymentRunOperation event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
    
      final _pan = dataManager.nativeHostPayData?.pan;
      final typePan = dataManager.nativeHostPayData?.typePan ?? '';

      if (_pan == null) {
        throw Exception(
          t.exceptions.emtyMainProduct
        );
      }

      final response = await dataManager.runOperationRequest(
          service: event.service,
          diType: event.service.diType,
          pan: Pan(evalue: _pan), //TODO with cards 
          typePan: TypePan(evalue: typePan), 
          kioskReceipt: DateTime.now().millisecondsSinceEpoch * 1000,
          attrs: event.attrs,
          payDate: DateTime.now().toStringFormattedQR()
      );

      if ((response.errorCode ?? 0) == 0) {
        final checkList = <String>[];

        final checkHeader = response.payRecord?.check?.checkHeader?.checkLine
            .map((e) => e.evalue)
            .toList();
        final checkFooter = response.payRecord?.check?.checkFooter?.checkLine
            .map((e) => e.evalue)
            .toList();

        checkHeader?.forEach((value) {
          if (value?.isNotEmpty ?? false) checkList.add(value!);
        });
        checkFooter?.forEach((value) {
          if (value?.isNotEmpty ?? false) checkList.add(value!);
        });

        // _log('formed check: $checkList');
        final confirmResponse = await dataManager.confirmRequest(
            service: response.payRecord!, diType: event.service.diType!);

        if (confirmResponse.errorCode == 0) {
          // final checkBody = response.payRecord?.check;

          emit(PaymentCheckInitial(
            checkBody: checkList,
            service: event.service,
          ));
        } else {
          emit(PaymentErrorKomplat(
              errorCode: confirmResponse.errorCode,
              errorMessage: confirmResponse.errorText));
        }
      } else {
        emit(PaymentErrorKomplat(
            errorCode: response.errorCode, errorMessage: response.errorText));
      }
    } catch (error) {
      emit(PaymentError(error: error));
    }
  }

  List<Tuple2<String, dynamic>> _getFinishedAttrsListFromService(
      PayRecordResponse service,
      {required List<AttrRecordRequest> attrsEdited}) {
    final _finalList = <Tuple2<String, dynamic>>[];

    for (final attr in attrsEdited) {
      AttrRecordResponse? tempAttr;
      final _index = service.attrRecord
              ?.indexWhere((element) => element.codeOut == attr.codeOut) ?? -1;
      if (_index > -1) tempAttr = service.attrRecord?[_index];
      if (tempAttr != null && _filter(tempAttr)) {
        _finalList.add(Tuple2<String, String?>(tempAttr.name ?? '', attr.value));
      }
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
