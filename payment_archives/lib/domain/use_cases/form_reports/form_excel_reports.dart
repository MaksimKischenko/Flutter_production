

// ignore: implementation_imports
import 'package:either_dart/src/either.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/use_cases/form_reports/report_generator.dart';
import 'package:payment_tracking_module/presentation/bloc/form_reports/form_reports_bloc.dart';
import 'package:payment_tracking_module/utils/utils.dart';

class FormExcelReports implements ReportGenerator {
  @override
  Future<Either<Failure, String>> generateReports(FormReportsInit event) async{
    try {
     final result = _createExcelFile(event.payments);
      return Right(result);
    } on Exception catch (error, _) {
      return Left(FormReportFailure(error: error));
    }   
  }

  String _createExcelFile(List<Payment> payments) {
    final excel = Excel.createExcel();
    final sheetName = 'Отчет по платежам от ${DateFormat('dd-MM-yyyy').format(DateTime.now())}';
    excel.rename('Sheet1', sheetName);
    final headers = PaymentTableColumns.values.map((e) => e.name.replaceAll('\n', '  ')).toList();
    excel[sheetName].insertRowIterables(headers, 0);

    final headerCellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center, bold: true, underline: Underline.Single, /*textWrapping: TextWrapping.WrapText*/);
    final headerCells = excel[sheetName].selectRange(CellIndex.indexByString('A1'), end: CellIndex.indexByString('Z1'));
    headerCells.first?.forEach((cell) {
      cell?.cellStyle = headerCellStyle;
    });

    payments.forEachIndexed((e, i) {
      excel[sheetName].insertRowIterables(<dynamic>[
        e.payerFullName ?? '', e.payerAddress ?? '', e.fullNameDepositor ?? '', e.depositorAddress ?? '',
        e.supplierName ?? '', e.serviceName ?? '', e.supplierAccount ?? '', e.bankName ?? '', e.bankBik ?? '',
        e.budgetCode.toString().replaceAll('null', ''), (e.paySum ?? 0.0).toString(), 
        (e.commissionSum ?? 0.0).toString(), (e.penaltySum ?? 0.0).toString(), e.terminalId ?? '',
        e.terminalDept?.toString().replaceAll('null', '') ?? '', e.deptFilial?.toString().replaceAll('null', '')  ?? '',
        e.terminaLocation ?? '', e.receiptNo ?? '', e.externalSystemPaymentId.toString().replaceAll('null', ''),
        e.payDate?.toStringFormatted() ?? '', e.consolidatedDocDate?.toStringFormatted() ?? '',
        e.consolidatedDocId?.toString().replaceAll('null', '')  ?? '', e.consolidatedDocPayString ?? '',
        e.consolidatedExportFileName ?? '', e.region ?? '', e.cardNumber ?? ''
      ], 
      i + 1);
    });

    for (var i = 0; i < 26; i++) {
      excel[sheetName].setColWidth(i, 25);
    }
    // idk why, but w/o this it doesn't work
    excel[sheetName].setColWidth(26, 25);
    excel.save(fileName: '$sheetName.xlsx');

    return sheetName;
  }
}