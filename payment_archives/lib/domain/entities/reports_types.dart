import 'package:flutter/material.dart';

enum ReportsTypes {
  paymentSearchProtocol('Сформировать протокол(ы) розыска платежа', Icon(Icons.app_registration_outlined)),
  infoPayments('Сформировать справку(и) об осуществленных платежах', Icon(Icons.plagiarism_outlined)),
  aboutSearching('Сформировать отчет(ы) о розыске платежей', Icon(Icons.wysiwyg)),
  excelReport('Отчет по платежам в формате EXCEL', Icon(Icons.dataset_outlined));

  final String message;
  final Icon icon;

  const ReportsTypes(this.message,this.icon);
}
