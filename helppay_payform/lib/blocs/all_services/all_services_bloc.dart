// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_payform_app/config.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/injection_component.dart';
import 'package:helppay_payform_app/models/models.dart';

part 'all_services_event.dart';
part 'all_services_state.dart';

class AllServicesBloc extends Bloc<AllServicesEvent, AllServicesState> {
  final DataManager dataManager;
  
  AllServicesBloc({
    required this.dataManager
  }) : super(AllServicesLoading()) {
    on<AllServicesEvent>(_onEvent);
  }

  // name filter
  int _filterNameMaxLength = 99;
  // all filters
  List<ServiceFilter>? _filters;

  void _onEvent(
    AllServicesEvent event,
    Emitter<AllServicesState> emit
  ) {
    if (event is AllServicesInit) return _onAllServicesInit(event, emit);
  }

  void _onAllServicesInit(
    AllServicesInit event,
    Emitter<AllServicesState> emit
  ) async {
    emit(AllServicesLoading());

    try {
      if (_filters == null) {
        final response = await dataManager.getPayListFiltersRequest();
        if ((response.errorCode ?? 0) == 0) {
          final nameFilterItem = response.filters?.firstOrNullWhere((e) => e.code == AppConfig.filterNameId);
          if (nameFilterItem == null) throw Exception('Filter error: item with code ${AppConfig.filterNameId} not found');
          _filterNameMaxLength = nameFilterItem.maxLength ?? 99;
          _filters = response.filters ?? [];
          // remove name item
          _filters?.removeWhere((e) => e.code == AppConfig.filterNameId);
        } else {
          emit(AllServicesErrorKomplat(
          request: RequestType.filters,
          errorCode: response.errorCode,
          errorText: response.errorText
        ));
        }
      }

      final requestFilters = <FilterAttrRecord>[];
      if (event.name?.isNotEmpty ?? false) {
        requestFilters.add(FilterAttrRecord(
          code: AppConfig.filterNameId,
          value: event.name!
        ));
      }
      // filters when value is not empty
      final eventUsedFilters = event.filters?.where((e) => e.value?.isNotEmpty ?? false).toList() ?? [];
      if (eventUsedFilters.isNotEmpty) {
        requestFilters.addAll(eventUsedFilters);
      }
      
      final response = await dataManager.getPayListRequest(
        payCode: InjectionComponent.getDependency<DynamicConfig>().allServicesCode,
        diType: AppConfig.diTypeNode,
        filters: requestFilters.isNotEmpty ? requestFilters : null
      );
      if ((response.errorCode ?? 0) == 0) {
        emit(AllServicesLoaded(
          nameMaxLength: _filterNameMaxLength,
          availableFilters: _filters ?? [],
          appliedFilters: event.filters ?? [],
          services: response.payRecord?.map((e) => EripService.fromPayRecord(e)).toList() ?? []
        ));
      } else {
        if (response.errorCode == 502) {
          // empty list
          emit(AllServicesLoaded(
            nameMaxLength: _filterNameMaxLength,
            availableFilters: _filters ?? [],
            appliedFilters: event.filters ?? [],
            services: const []
          ));
        } else {
          emit(AllServicesErrorKomplat(
            request: RequestType.getPayList,
            errorCode: response.errorCode,
            errorText: response.errorText
          ));
        }
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(AllServicesError(
        error: error
      ));
    }
  }
}
