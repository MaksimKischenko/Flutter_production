import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  DataManager dataManager;

  SettingsBloc() : dataManager = InjectionComponent.getDependency<DataManager>(), 
  super(SettingsLoading());

  bool _isChangePasswordAvailable = true;
  bool _isStartMessageAvailable = true;

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is SettingsInit) {
      yield* _mapSettingsInitToState(event);
    } else if (event is SettingsChanged) {
      yield* _mapSettingsChangedToState(event);
    }
  }

  Stream<SettingsState> _mapSettingsInitToState(
    SettingsInit event
  ) async* {
    yield SettingsLoading();
    
    if(dataManager.userRights.rights.isNotEmpty) {
      _isChangePasswordAvailable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.changePassword);
      _isStartMessageAvailable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.startMessage);
    }
    final supplierItems = await PreferencesHelper.getSupplierItems();
    final userItems = await PreferencesHelper.getUserItems();
    final auditItems = await PreferencesHelper.getAuditItems();
    final serverMessageItems = await PreferencesHelper.getServerMessageItems();
    final unassignedTasksItems = await PreferencesHelper.getUnassignedTasksItems();
    final tasksPartItems = await PreferencesHelper.getTasksPartItems();
    final tasksPartParamItems = await PreferencesHelper.getTasksPartParamItems();

    yield SettingsInitial(
      supplierItems: supplierItems,
      userItems: userItems,
      auditItems: auditItems,
      serverMessageItems: serverMessageItems,
      unassignedTasksItems:unassignedTasksItems,
      tasksPartItems: tasksPartItems,
      tasksPartParamItems:tasksPartParamItems,
      isChangePasswordAvailable: _isChangePasswordAvailable,
      isStartMessageAvailable: _isStartMessageAvailable
    );
  }

  Stream<SettingsState> _mapSettingsChangedToState(
    SettingsChanged event
  ) async* {
    if (state is SettingsInitial) {
      final tempState = state as SettingsInitial;
      yield SettingsLoading();
      if (event.supplierItem != null) {
        final supplierItems = List<SuppliersSort>.from(tempState.supplierItems);
        if (event.value) {
          supplierItems.add(event.supplierItem!);
        } else {
          supplierItems.remove(event.supplierItem);
        }

        await PreferencesHelper.setSupplierItems(supplierItems);
        
        yield tempState.copyWith(
          supplierItems: supplierItems.sortedBy((e) => e.index)
        );
      } else if (event.userItem != null) {
        final userItems = List<UsersSort>.from(tempState.userItems);
        if (event.value) {
          userItems.add(event.userItem!);
        } else {
          userItems.remove(event.userItem);
        }

        await PreferencesHelper.setUserItems(userItems);
        
        yield tempState.copyWith(
          userItems: userItems.sortedBy((e) => e.index)
        );
      } else if (event.auditItem != null) {
        final auditItems = List<AuditSort>.from(tempState.auditItems);
        if (event.value) {
          auditItems.add(event.auditItem!);
        } else {
          auditItems.remove(event.auditItem);
        }

        await PreferencesHelper.setAuditItems(auditItems);
        
        yield tempState.copyWith(
          auditItems: auditItems.sortedBy((e) => e.index)
        );
      } else if (event.serverMessageItem != null) {
        final serverMessageItems = List<ServerMessageSort>.from(tempState.serverMessageItems);
        if (event.value) {
          serverMessageItems.add(event.serverMessageItem!);
        } else {
          serverMessageItems.remove(event.serverMessageItem);
        }

        await PreferencesHelper.setServerMessageItems(serverMessageItems);
        
        yield tempState.copyWith(
          serverMessageItems: serverMessageItems.sortedBy((e) => e.index)
        );
      } else if (event.tasks != null) {
        final tasks = List<UnassignedTasksSort>.from(tempState.unassignedTasksItems);
        if (event.value) {
          tasks.add(event.tasks!);
        } else {
          tasks.remove(event.tasks);
        }

        await PreferencesHelper.setUnassignedTasksItems(tasks);
        
        yield tempState.copyWith(
          unassignedTasksItems: tasks.sortedBy((e) => e.index)
        );
      } else if (event.tasksPart != null) {
        final tasksPart = List<TasksPartSort>.from(tempState.tasksPartItems);
        if (event.value) {
          tasksPart.add(event.tasksPart!);
        } else {
          tasksPart.remove(event.tasksPart);
        }

        await PreferencesHelper.setTasksPartItems(tasksPart);
        
        yield tempState.copyWith(
          tasksPartItems: tasksPart.sortedBy((e) => e.index)
        );
      } else if (event.tasksPartParam != null) {
        final tasksPartParam = List<TasksPartParamSort>.from(tempState.tasksPartParamItems);
        if (event.value) {
          tasksPartParam.add(event.tasksPartParam!);
        } else {
          tasksPartParam.remove(event.tasksPartParam);
        }

        await PreferencesHelper.setTasksPartParamItems(tasksPartParam);
        
        yield tempState.copyWith(
          tasksPartParamItems: tasksPartParam.sortedBy((e) => e.index)
        );
      }
    }
  }
}
