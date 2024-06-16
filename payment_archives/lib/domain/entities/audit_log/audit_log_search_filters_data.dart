// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuditLogSearchFiltersData {
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? userName;

  const AuditLogSearchFiltersData({
    this.dateFrom,
    this.dateTo,
    this.userName,
  });

  factory AuditLogSearchFiltersData.empty() =>  const AuditLogSearchFiltersData();
}
