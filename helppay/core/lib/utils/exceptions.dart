import 'package:helppay_core/generated/translations.g.dart';

class OnlyIndividualException implements Exception {
  String getErrorMessage() => t.exceptions.onlyIndividuals;
}
