import 'package:helppay_core/utils/utils.dart';

enum CardIssuerType { visa, mastercard, maestro, americanExpress, undefined }

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'card_issuer_type');

extension CardIssuerTypeExtenson on CardIssuerType {
  static const Map<String, CardIssuerType> _mapFirstNumberToType = {
    '4': CardIssuerType.visa,
    '5': CardIssuerType.mastercard,
    '6': CardIssuerType.maestro,
    '3': CardIssuerType.americanExpress,
  };

  static CardIssuerType fromCardNumber(String value) {
    _log('From card number - ${value}');
    return _mapFirstNumberToType[value] ?? CardIssuerType.undefined;
  }

  String logo({bool isMain = false}) {
    late String name;
    switch (this) {
      case CardIssuerType.visa:
        name = isMain ? 'card_visa_light' : 'card_visa';
        break;
      case CardIssuerType.mastercard:
        name = 'card_mastercard';
        break;
      case CardIssuerType.maestro:
        name = 'card_maestro';
        break;
      case CardIssuerType.americanExpress:
        name = 'card_american_express';
        break;
      default:
        name = 'card_american_express';
    }
    return name;
  }
}
