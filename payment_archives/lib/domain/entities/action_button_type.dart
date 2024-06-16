
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

// ignore: avoid_classes_with_only_static_members
class ActionButtonType {

static final Map<String, Icon> icons = {
    ButtonNames.add.message:  const Icon(Icons.add_circle, color: AppStyles.whiteColor, size: 16),
    ButtonNames.delete.message: const Icon(Icons.delete, color: AppStyles.colorBlack, size: 16),
    ButtonNames.edit.message: const Icon(Icons.edit, color: AppStyles.colorBlack, size: 16),
    ButtonNames.search.message: const Icon(Icons.search, color: AppStyles.colorBlack, size: 16),
    ButtonNames.loadMore.message: const Icon(Icons.download_outlined, color: AppStyles.colorBlack, size: 16),
    ButtonNames.addParams.message: const Icon(Icons.library_add_outlined, color: AppStyles.colorBlack, size: 16),
    ButtonNames.openFilters.message: const Icon(Icons.filter_list, color: AppStyles.colorBlack, size: 16),
    ButtonNames.archPart.message: const Icon(Icons.archive, color: AppStyles.colorBlack, size: 16),
    ButtonNames.mapAllocationArch.message: const Icon(Icons.map_outlined, color: AppStyles.colorBlack, size: 16),
    ButtonNames.availableLocations.message: const Icon(Icons.data_saver_on, color: AppStyles.colorBlack, size: 16),
  };
}

enum ButtonNames {
  add('Добавить'),
  cancel('Отменить'),
  save('Сохранить'),
  delete('Удалить'),
  edit('Редактировать'),
  loadMore('Загрузить еще'),
  addParams('Добавить еще'),
  search('Поиск'),
  openFilters('Добавить фильтры поиска'),
  clearFilters('Очистить фильтры поиска'),
  archPart('Части архива'),
  mapAllocationArch('Карта распределения архива'),
  availableLocations('Доступные локации');


  const ButtonNames(this.message);
  final String message;
}
