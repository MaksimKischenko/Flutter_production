import 'package:helppay_core/data/data.dart';

class ProfileEditScreenArgs {
  final List<MdomResponseParam> userParams;
  final MdomLookup? lookups;

  const ProfileEditScreenArgs({
    required this.userParams,
    this.lookups,
  });
}
