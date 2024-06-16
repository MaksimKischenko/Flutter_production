part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
  
  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {}

class SettingsInitial extends SettingsState {
  final List<SuppliersSort> supplierItems;
  final List<UsersSort> userItems;
  final List<AuditSort> auditItems;
  final List<ServerMessageSort> serverMessageItems;
  final List<UnassignedTasksSort> unassignedTasksItems;
  final List<TasksPartSort> tasksPartItems;
  final List<TasksPartParamSort> tasksPartParamItems;
  final bool isChangePasswordAvailable;
  final bool isStartMessageAvailable;


  const SettingsInitial({
    required this.supplierItems,
    required this.userItems,
    required this.auditItems,
    required this.serverMessageItems,
    required this.unassignedTasksItems,
    required this.tasksPartItems,
    required this.tasksPartParamItems,
    this.isChangePasswordAvailable = true,
    this.isStartMessageAvailable = true
  });

  @override
  List<Object> get props => [supplierItems, userItems, auditItems, serverMessageItems, 
    unassignedTasksItems, tasksPartItems, tasksPartParamItems, isChangePasswordAvailable,
    isStartMessageAvailable
  ];

  

  SettingsInitial copyWith({
    List<SuppliersSort>? supplierItems,
    List<UsersSort>? userItems,
    List<AuditSort>? auditItems,
    List<ServerMessageSort>? serverMessageItems,
    List<UnassignedTasksSort>? unassignedTasksItems,
    List<TasksPartSort>? tasksPartItems,
    List<TasksPartParamSort>? tasksPartParamItems,
    
  }) => SettingsInitial(
      supplierItems: supplierItems ?? this.supplierItems,
      userItems: userItems ?? this.userItems,
      auditItems: auditItems ?? this.auditItems,
      serverMessageItems: serverMessageItems ?? this.serverMessageItems,
      unassignedTasksItems: unassignedTasksItems ?? this.unassignedTasksItems,
      tasksPartItems: tasksPartItems ?? this.tasksPartItems,
      tasksPartParamItems: tasksPartParamItems ?? this.tasksPartParamItems,
    );
}
