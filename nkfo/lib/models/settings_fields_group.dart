import 'models.dart';

class SettingsFieldsGroup {
  final String category;
  final List<SettingsFieldsField> fields;

  SettingsFieldsGroup({
    required this.category,
    required this.fields,
  });

  int get selectedFieldsCount => fields.fold<int>(0, (previousValue, element) => element.selected ? previousValue + 1 : previousValue);
}
