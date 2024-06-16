import 'package:json_annotation/json_annotation.dart';


enum PaymentMethodModel {
  @JsonValue(null)
  all('Все', null),

  @JsonValue(0)
  middle('Наличный', 0),
  
  @JsonValue(1)
  huge('Безналичный', 1);
  
  const PaymentMethodModel(this.name, this.dbCode);
  final String name;
  final int? dbCode;
}
