
import 'package:equatable/equatable.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/config.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/injection_component.dart';

import 'erip_service_type.dart';

// ignore: must_be_immutable
class EripService extends Equatable {
  final EripServiceType type;
  final int code;
  final int diType;
  final String name;
  AllServicesNodeBloc? nodeBloc;

  EripService({
    required this.type,
    required this.code,
    required this.diType,
    required this.name,
    this.nodeBloc
  });

  @override
  List<Object?> get props => [type, code, name, nodeBloc];

  factory EripService.fromPayRecord(PayRecordResponse payRecord) {
    final type = (payRecord.getPayListType ?? -1) == 2 ? EripServiceType.node : EripServiceType.service;
    final code = payRecord.code ?? -1;
    final diType = payRecord.diType ?? AppConfig.diTypeNode;
    return EripService(
      type: type,
      code: code,
      diType: diType,
      name: payRecord.name ?? 'Сервис ${payRecord.code}',
      nodeBloc: type == EripServiceType.node ? AllServicesNodeBloc(
        dataManager: InjectionComponent.getDependency<DataManager>(),
        payCode: code,
        diType: diType
      ) : null
    );
  }

}
