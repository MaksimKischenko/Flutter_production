import 'package:helppay_core/data/data.dart';

class RegistrationParamsScreenArgs {
  final List<MdomResponseParam> params;
  final List<MdomLookupItem>? lookUps;
  final String? phone;

  const RegistrationParamsScreenArgs({
    required this.params,
    this.lookUps,
    this.phone,
  });
}
