enum PeriodStatus {
  once, isMinute, isDay, isWeek, isMonth
}

extension PeriodStatusExtension on PeriodStatus {
  static const Map<PeriodStatus, String> _names = {
    PeriodStatus.once: 'Однократно',
    PeriodStatus.isMinute: 'Ежеминутно',
    PeriodStatus.isDay: 'Ежедневно',
    PeriodStatus.isWeek: 'Еженедельно',
    PeriodStatus.isMonth: 'Ежемесячно'
  };

  String get name => _names[this] ?? 'Неизвестно';

}