import 'dart:convert';
import 'dart:js' as js;

import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/reports_types.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/utils/utils.dart';

import 'report_generator.dart';

class FormWordReports implements ReportGenerator {
  final InfoReportsUseCase useCase;
  FormWordReports(): useCase = InfoReportsUseCase(); 
  static const _emptyReportString = '"________________"';

  @override
  Future<Either<Failure, String>> generateReports(FormReportsInit event) async{
    if(event.reportsType == ReportsTypes.paymentSearchProtocol) {
        try {
          _paymentSearchProtocolToJSGenerator(event);
          return const Right(''); 
        } on Exception catch (error, _) {
          return Left(FormReportFailure(error: error));
        }          
    } else if(event.reportsType == ReportsTypes.infoPayments) {
        try {
          for (var i = 0; i < event.payments.length; i++) {
            await Future.delayed(const Duration(milliseconds: 100));
            final resultJson = await _attrsJsonRemoteLoading(event, i);
            final _resultAttrs = parsingAttrsFromJson(resultJson.$1);
            _infoPaymentsToJSGenerator(
              event: event,
              i: i,
              currencyAttr: resultJson.$2,
              attrs: _resultAttrs
            );         
          }
          return const Right(''); 
        } on Exception catch (error, _) {
          return Left(FormReportFailure(error: error));
        }   
    } else if(event.reportsType == ReportsTypes.aboutSearching) {
        try {
          _aboutSearchingToJSGenerator(event);
          return const Right('');  
        } on Exception catch (error, _) {
          return Left(FormReportFailure(error: error));
        }   
    } else {
      return 
       Left(FormReportFailure(error: Exception('Неизвестная ошибка')));
     }
  }  

  void _infoPaymentsToJSGenerator({
     required FormReportsInit event,
     required int i,
     required String currencyAttr,
     required (String, String, String) attrs
  }) {
      final documentName = attrs.$1;
      final documentPlace = attrs.$2;
      final adress = attrs.$3;      

      final dateTimeReport = js.JsObject.jsify([DateTime.now().toStringFormatted()]);
      final name = js.JsObject.jsify([event.payments[i].payerFullName ?? _emptyReportString]);
      final passportSeria = js.JsObject.jsify([event.payments[i].payerDoc?.substring(0,2) ?? _emptyReportString]);
      final passportNumber = js.JsObject.jsify([event.payments[i].payerDoc?.substring(2) ?? _emptyReportString]);
      final passportIn = js.JsObject.jsify([event.payments[i].payerId ?? _emptyReportString]);
      final payDate = js.JsObject.jsify([event.payments[i].payDate?.toStringFormatted()]);
      final dateFrom = js.JsObject.jsify([event.requestData.dateFrom?.toStringFormatted() ?? _emptyReportString]);
      final dateTo = js.JsObject.jsify([event.requestData.dateTo?.toStringFormatted() ?? _emptyReportString]);
      final deptFilial = js.JsObject.jsify([event.payments[i].deptFilial ?? '_']);
      final terminalDept = js.JsObject.jsify([event.payments[i].terminalDept ?? '_']);
      final supplierName = js.JsObject.jsify([event.payments[i].supplierName ?? _emptyReportString]);
      final supplierAccount = js.JsObject.jsify([event.payments[i].supplierAccount ?? _emptyReportString]);
      final bankBik = js.JsObject.jsify([event.payments[i].bankBik ?? _emptyReportString]);
      final paySumm = js.JsObject.jsify([event.payments[i].paySum ?? 0]);
      final paySummWithString = js.JsObject.jsify([currencyAttr.replaceAll('"', '')]);
      final serviceName = js.JsObject.jsify([event.payments[i].serviceName ?? _emptyReportString] );
      js.context.callMethod(
          'infoPaymentsReference', [
          dateTimeReport, name, documentName, passportSeria, passportNumber, documentPlace, passportIn,
          adress, payDate, dateFrom, dateTo, deptFilial, terminalDept, supplierName, supplierAccount,
          bankBik, paySumm, paySummWithString, serviceName 
      ]);  
  }

  void _paymentSearchProtocolToJSGenerator(FormReportsInit event) {
    final dateTimeReport = js.JsObject.jsify([DateTime.now().toStringFormattedGetOperationHistory()]);
    final dateFrom = js.JsObject.jsify([event.requestData.dateFrom?.toStringFormatted() ?? '']);
    final dateTo = js.JsObject.jsify([event.requestData.dateTo?.toStringFormatted() ?? '']);
    final paymentId = js.JsObject.jsify([event.requestData.paymentId ?? -1]);
    final paymentIds = js.JsObject.jsify([event.requestData.ids?.toString().replaceAll(RegExp(r'[\[\]]'), '') ?? '']);    
    final payerName = js.JsObject.jsify([event.requestData.payerName ?? '']);
    final paymentNames = js.JsObject.jsify([event.requestData.names?.toString().replaceAll(RegExp(r'[\[\]]'), '') ?? '']);
    final payerIn = js.JsObject.jsify([event.requestData.payerIn ?? '']);
    final payerDoc = js.JsObject.jsify([event.requestData.payerDoc ?? '']);
    final payerAddress = js.JsObject.jsify([event.requestData.payerAddress ?? '']);
    final payerAccount = js.JsObject.jsify([event.requestData.payerAccount ?? '']);
    final supplierName = js.JsObject.jsify([event.requestData.supplierName ?? '']);
    final supplierAccount = js.JsObject.jsify([event.requestData.supplierAccount ?? '']);
    final bik = js.JsObject.jsify([event.requestData.bik ?? '']);
    final supplierUnp = js.JsObject.jsify([event.requestData.supplierUnp ?? '']);
    final budgetCode = js.JsObject.jsify([event.requestData.budgetCode ?? -1]);
    final serviceName = js.JsObject.jsify([event.requestData.serviceName ?? '']);
    final paySumMin = js.JsObject.jsify([event.requestData.paySumMin ?? -1]);
    final paySumMax = js.JsObject.jsify([event.requestData.paySumMax ?? -1]);
    final receiptNo = js.JsObject.jsify([event.requestData.receiptNo ?? '']);
    final systemPaymentId = js.JsObject.jsify([event.requestData.systemPaymentId ?? '']);
    final name = js.JsObject.jsify(event.payments.map((e) => e.payerFullName ?? _emptyReportString).toList());
    final payDate = js.JsObject.jsify(event.payments.map((e) => e.payDate?.toStringFormatted() ?? '').toList());
    final payTime = js.JsObject.jsify(event.payments.map((e) => e.payDate?.toStringFormattedHoursOnly() ?? '').toList());
    final paySumm = js.JsObject.jsify(event.payments.map((e) => e.paySum ?? 0).toList());
    final pemaltySum = js.JsObject.jsify(event.payments.map((e) => e.penaltySum ?? 0).toList());
    final deptFilial = js.JsObject.jsify(event.payments.map((e) => e.deptFilial ?? '_').toList());
    final terminalDept = js.JsObject.jsify(event.payments.map((e) => e.terminalDept ?? '_').toList());
    final externalSystemPayerId = js.JsObject.jsify(event.payments.map((e) => e.externalSystemPayerId ?? _emptyReportString).toList());
    final supplierNameResponse = js.JsObject.jsify(event.payments.map((e) => e.supplierName ?? _emptyReportString).toList());
    final supplierUnpResponse = js.JsObject.jsify(event.payments.map((e) => e.supplierUnp ?? _emptyReportString).toList());
    final supplierAccountResponse = js.JsObject.jsify(event.payments.map((e) => e.supplierAccount ?? _emptyReportString).toList());
    final bankBik = js.JsObject.jsify(event.payments.map((e) => e.bankBik ?? _emptyReportString).toList());
    final serviceNameResponse = js.JsObject.jsify(event.payments.map((e) => e.serviceName ?? _emptyReportString).toList());
    final payerAccountResponse = js.JsObject.jsify(event.payments.map((e) => e.payerAccount ?? _emptyReportString).toList());
    final externalSystemPaymentId = js.JsObject.jsify(event.payments.map((e) => e.externalSystemPaymentId ?? _emptyReportString).toList());
    final consolidatedDocId = js.JsObject.jsify(event.payments.map((e) => e.consolidatedDocId ?? '_').toList());
    final consolidatedDocDate = js.JsObject.jsify(event.payments.map((e) => e.consolidatedDocDate?.toLocal() ?? _emptyReportString).toList());    
    final consolidatedDocSum = js.JsObject.jsify(event.payments.map((e) => e.consolidatedDocSum ?? 0).toList());
    final consolidatedDocPayString = js.JsObject.jsify(event.payments.map((e) => e.consolidatedDocPayString ?? _emptyReportString).toList());  
    js.context.callMethod(
      'paymentSearchProtocol', [
      dateTimeReport, dateFrom, dateTo, paymentId, paymentIds, payerName, paymentNames, payerIn,
      payerDoc, payerAddress, payerAccount, supplierName, supplierAccount,
      bik, supplierUnp, budgetCode, serviceName, paySumMin, paySumMax, receiptNo, systemPaymentId,
      event.payments.length, name, payDate, payTime, paySumm, pemaltySum, terminalDept, deptFilial,
      externalSystemPayerId, supplierNameResponse, supplierUnpResponse,
      supplierAccountResponse, bankBik, serviceNameResponse, payerAccountResponse, externalSystemPaymentId, 
      consolidatedDocId, consolidatedDocDate, consolidatedDocSum, consolidatedDocPayString
    ]);  
  }

  void _aboutSearchingToJSGenerator(FormReportsInit event) {
      final dateFrom = js.JsObject.jsify([event.requestData.dateFrom?.toStringFormatted() ?? _emptyReportString]);
      final dateTo = js.JsObject.jsify([event.requestData.dateTo?.toStringFormatted() ?? _emptyReportString]);
      final name = js.JsObject.jsify(event.payments.map((e) => e.payerFullName ?? _emptyReportString).toList());
      final payDate = js.JsObject.jsify(event.payments.map((e) => e.payDate!.toStringFormatted()).toList());
      final payTime = js.JsObject.jsify(event.payments.map((e) => e.payDate!.toStringFormattedHoursOnly()).toList());
      final paySumm = js.JsObject.jsify(event.payments.map((e) => e.paySum ?? 0).toList());
      final pemaltySum = js.JsObject.jsify(event.payments.map((e) => e.penaltySum ?? 0).toList());
      final deptFilial = js.JsObject.jsify(event.payments.map((e) => e.deptFilial ?? '_').toList());
      final terminalDept = js.JsObject.jsify(event.payments.map((e) => e.terminalDept ?? '_').toList());
      final externalSystemPayerId = js.JsObject.jsify(event.payments.map((e) => e.externalSystemPayerId ?? _emptyReportString).toList());
      final supplierName = js.JsObject.jsify(event.payments.map((e) => e.supplierName ?? _emptyReportString).toList());
      final supplierUnp = js.JsObject.jsify(event.payments.map((e) => e.supplierUnp ?? _emptyReportString).toList());
      final supplierAccount = js.JsObject.jsify(event.payments.map((e) => e.supplierAccount ?? _emptyReportString).toList());
      final bankBik = js.JsObject.jsify(event.payments.map((e) => e.bankBik ?? _emptyReportString).toList());
      final consolidatedDocPayString = js.JsObject.jsify(event.payments.map((e) => e.consolidatedDocPayString ?? _emptyReportString).toList());
      final payerAccount = js.JsObject.jsify(event.payments.map((e) => e.payerAccount ?? _emptyReportString).toList());
      final externalSystemPaymentId = js.JsObject.jsify(event.payments.map((e) => e.externalSystemPaymentId ?? _emptyReportString).toList());
      js.context.callMethod(
          'aboutSearchingPayments', [
          event.payments.length, dateFrom, dateTo, name, payDate, 
          payTime, paySumm, pemaltySum, terminalDept, deptFilial,
          externalSystemPayerId, supplierName, supplierUnp,
          supplierAccount, bankBik, consolidatedDocPayString,
          payerAccount, externalSystemPaymentId  
      ]); 
  }

  (String, String, String) parsingAttrsFromJson(String jsonAtrrs) {
      var _documentName = _emptyReportString;
      var _documentPlace = _emptyReportString;    
      var _adress = _emptyReportString;   

      if((json.decode(jsonAtrrs) as Map<String, dynamic>?) != null) {
       if((json.decode(jsonAtrrs) as Map<String, dynamic>).containsKey('attr855')
        && (json.decode(jsonAtrrs) as Map<String, dynamic>).containsKey('attr788')
        && (json.decode(jsonAtrrs) as Map<String, dynamic>).containsKey('attr781')
      ) {
        _documentName = ((json.decode(jsonAtrrs) as Map<String, dynamic>)['attr855']['value'] as String?) ?? '';
        _documentPlace = ((json.decode(jsonAtrrs) as Map<String, dynamic>)['attr788']['value'] as String?) ?? '';
        _adress = ((json.decode(jsonAtrrs) as Map<String, dynamic>)['attr781']['value'] as String?) ?? '';
      }
    }   
    return (_documentName, _documentPlace, _adress);
  }


  Future<(String, String)> _attrsJsonRemoteLoading(FormReportsInit event, int i) async {
    var _paymentsAttr = '';
    var _currency = '';
    final resultPayment = await useCase.getPaymentsAttr(
      request: PaymentAtrrRequest(
        sourceId: event.payments[i].sourceId ?? 0, 
        paymentId: event.payments[i].paymentId ?? 0, 
      )
    );
    await resultPayment.fold((failure) {
      Left(failure);
    }, (right) async {
      _paymentsAttr = resultPayment.right.data;
    });
    final resultCurrency = await useCase.getCurrences(             
      request: CurrencyRequest(
        paySumm: event.payments[i].paySum ?? 0, 
        payCurrency: event.payments[i].currency ?? 0,
      )
    );
    await resultCurrency.fold((failure) {
      Left(failure);
    }, (right) async {
      _currency = resultCurrency.right.data;
    });
  return (_paymentsAttr, _currency);
 }  
}

