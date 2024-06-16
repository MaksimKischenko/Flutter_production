import 'package:helppay_payform_app/data/data.dart';

class NodeScreenParams {
  final Service? node;
  final int? nodeId;
  final int? nodeType;

  const NodeScreenParams({
    required this.node,
    this.nodeId,
    this.nodeType,
  });
}
