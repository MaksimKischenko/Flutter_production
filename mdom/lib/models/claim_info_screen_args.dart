import 'package:bpc/data/data.dart';

class ClaimInfoScreenArgs {
  final Claim claim;
  final Service service;

  const ClaimInfoScreenArgs({
    required this.claim,
    required this.service,
  });
}