
import 'package:equatable/equatable.dart';
import 'package:kpm_fl/data/data.dart';

import 'erip_service_type.dart';

class EripService extends Equatable {
  final EripServiceType type;
  final int code;
  final String name;
  // AllServicesNodeBloc? nodeBloc;

  const EripService({
    required this.type,
    required this.code,
    required this.name,
    // this.nodeBloc
  });

  @override
  List<Object?> get props => [type, code, name, /*nodeBloc*/];

  factory EripService.fromPayRecord(PayRecordResponse payRecord) {
    final type = (payRecord.getPayListType ?? -1) == 2 ? EripServiceType.node : EripServiceType.service;
    final code = payRecord.code ?? -1;
    return EripService(
      type: type,
      code: code,
      name: payRecord.name ?? 'Сервис ${payRecord.code}',
      // nodeBloc: type == EripServiceType.node ? AllServicesNodeBloc(
      //   dataManager: InjectionComponent.getDependency<DataManager>(),
      //   payCode: code,
      //   diType: diType
      // ) : null
    );
  }

}
