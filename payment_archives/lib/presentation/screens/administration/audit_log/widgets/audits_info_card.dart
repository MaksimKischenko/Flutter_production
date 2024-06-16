// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/widgets/filter_info_card.dart';
import 'package:payment_tracking_module/utils/date_helper.dart';


class AuditsInfoCard extends StatelessWidget {

  final AuditLogSearchFiltersData? auditLogData;
  
  const AuditsInfoCard({
    Key? key,
    this.auditLogData,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) => Wrap(
    children: [
      FilterInfoCard(
        title: AuditLogActionFieldNames.dateFrom.message,
        subtitle: auditLogData?.dateFrom?.toStringFormattedGetOperationHistory()
      ),
      FilterInfoCard(
        title: AuditLogActionFieldNames.dateTo.message,
        subtitle: auditLogData?.dateTo?.toStringFormattedGetOperationHistory()
      ),
      FilterInfoCard(
        title: AuditLogActionFieldNames.userName.message,
        subtitle: auditLogData?.userName
      ),                          
    ]
  );
}
