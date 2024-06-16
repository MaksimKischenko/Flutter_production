part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsInit extends SettingsEvent {}

class SettingsChanged extends SettingsEvent {
  final SuppliersSort? supplierItem;
  final UsersSort? userItem;
  final AuditSort? auditItem;
  final ServerMessageSort? serverMessageItem;
  final UnassignedTasksSort? tasks;
  final TasksPartSort? tasksPart;
  final TasksPartParamSort? tasksPartParam;
  final bool value;

  const SettingsChanged({
    required this.value,
    this.supplierItem,
    this.userItem,
    this.auditItem,
    this.serverMessageItem,
    this.tasks,
    this.tasksPart,
    this.tasksPartParam,
  });

  @override
  List<Object?> get props => [supplierItem, userItem, auditItem, serverMessageItem, tasks, tasksPart, tasksPartParam, value];
}
