import 'package:json_annotation/json_annotation.dart';

part 'komplat_general_elements.g.dart';

@JsonSerializable()
class Pan {

  @JsonKey(name: 'evalue')
  final String evalue;

  Pan({
    required this.evalue,
  });

  factory Pan.fromJson(Map<String, dynamic> json) => _$PanFromJson(json);

  Map<String, dynamic> toJson() => _$PanToJson(this);
  
}

@JsonSerializable()
class TypePan {

  @JsonKey(name: 'evalue')
  final String evalue;

  TypePan({
    required this.evalue,
  });

  factory TypePan.fromJson(Map<String, dynamic> json) => _$TypePanFromJson(json);

  Map<String, dynamic> toJson() => _$TypePanToJson(this);
  
}

@JsonSerializable()
class Lang {

  @JsonKey(name: 'evalue')
  final String evalue;

  Lang({
    required this.evalue,
  });

  factory Lang.fromJson(Map<String, dynamic> json) => _$LangFromJson(json);

  Map<String, dynamic> toJson() => _$LangToJson(this);
  
}