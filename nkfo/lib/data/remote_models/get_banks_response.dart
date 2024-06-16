import 'package:json_annotation/json_annotation.dart';

part 'get_banks_response.g.dart';

@JsonSerializable()
class Bank {

  @JsonKey(name: 'bank_id')
  final int id;

  @JsonKey(name: 'bank_name')
  final String name;

  @JsonKey(name: 'bank_bic')
  final String bic;

  Bank({
    required this.id,
    required this.name,
    required this.bic,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  Map<String, dynamic> toJson() => _$BankToJson(this);
  
}
