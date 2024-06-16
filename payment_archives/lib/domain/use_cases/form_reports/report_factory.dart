import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/domain/use_cases/form_reports/form_excel_reports.dart';
import 'package:payment_tracking_module/domain/use_cases/form_reports/form_word_reports.dart';
import 'package:payment_tracking_module/domain/use_cases/form_reports/report_generator.dart';

class ReportFactory {
   ReportGenerator createReportGenerator(ReportsTypes reportsTypes) {
    switch (reportsTypes) {
      case ReportsTypes.paymentSearchProtocol:
      case ReportsTypes.infoPayments:  
      case ReportsTypes.aboutSearching:           
        return FormWordReports();
      case ReportsTypes.excelReport:
        return FormExcelReports();
    }
  }
}