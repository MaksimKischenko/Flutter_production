// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i21;
import 'package:flutter/material.dart' as _i23;
import 'package:payment_tracking_module/data/data.dart' as _i22;
import 'package:payment_tracking_module/presentation/screens/administration/audit_log/audit_log_screen.dart'
    as _i4;
import 'package:payment_tracking_module/presentation/screens/administration/rule_allocation_add/rule_allocation_add_screen.dart'
    as _i8;
import 'package:payment_tracking_module/presentation/screens/administration/rule_allocation_edit/rule_allocation_edit_screen.dart'
    as _i3;
import 'package:payment_tracking_module/presentation/screens/administration/rule_allocations/rule_allocations_screen.dart'
    as _i7;
import 'package:payment_tracking_module/presentation/screens/administration/user_add/user_add_screen.dart'
    as _i5;
import 'package:payment_tracking_module/presentation/screens/administration/user_edit/user_edit_screen.dart'
    as _i9;
import 'package:payment_tracking_module/presentation/screens/administration/users/users_screen.dart'
    as _i6;
import 'package:payment_tracking_module/presentation/screens/auth/auth_screen.dart'
    as _i2;
import 'package:payment_tracking_module/presentation/screens/manage_archives/archive_avail_loc/available_archive_location_screen.dart'
    as _i11;
import 'package:payment_tracking_module/presentation/screens/manage_archives/archive_dir/archives_directory_screen.dart'
    as _i10;
import 'package:payment_tracking_module/presentation/screens/manage_archives/archive_location/archive_location_screen.dart'
    as _i18;
import 'package:payment_tracking_module/presentation/screens/manage_archives/archive_location_add/archive_location_add_screen.dart'
    as _i13;
import 'package:payment_tracking_module/presentation/screens/manage_archives/archive_location_edit/archive_location_edit_screen.dart'
    as _i16;
import 'package:payment_tracking_module/presentation/screens/manage_archives/archive_part/archive_part_screen.dart'
    as _i12;
import 'package:payment_tracking_module/presentation/screens/manage_archives/archive_status/archive_status_screen.dart'
    as _i15;
import 'package:payment_tracking_module/presentation/screens/manage_archives/data_source_add/data_source_add_screen.dart'
    as _i20;
import 'package:payment_tracking_module/presentation/screens/manage_archives/data_source_dir/data_source_directory_screen.dart'
    as _i17;
import 'package:payment_tracking_module/presentation/screens/manage_archives/data_source_edit/data_source_edit_screen.dart'
    as _i19;
import 'package:payment_tracking_module/presentation/screens/manage_archives/map_allocation/map_allocation_screen.dart'
    as _i14;
import 'package:payment_tracking_module/presentation/screens/payments/payments_screen.dart'
    as _i1;

abstract class $Routes extends _i21.RootStackRouter {
  $Routes({super.navigatorKey});

  @override
  final Map<String, _i21.PageFactory> pagesMap = {
    PaymentsRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PaymentsScreen(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AuthScreen(),
      );
    },
    RuleAllocationEditRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RuleAllocationEditRouteArgs>(
          orElse: () => RuleAllocationEditRouteArgs(
              ruleAllocationId: pathParams.optInt('id')));
      return _i21.AutoRoutePage<_i22.RuleAllocationData>(
        routeData: routeData,
        child: _i3.RuleAllocationEditScreen(
          key: args.key,
          ruleAllocationId: args.ruleAllocationId,
          ruleAllocation: args.ruleAllocation,
        ),
      );
    },
    AuditLogRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AuditLogScreen(),
      );
    },
    UserAddRoute.name: (routeData) {
      final args = routeData.argsAs<UserAddRouteArgs>(
          orElse: () => const UserAddRouteArgs());
      return _i21.AutoRoutePage<_i22.User>(
        routeData: routeData,
        child: _i5.UserAddScreen(
          key: args.key,
          selectedTypeId: args.selectedTypeId,
        ),
      );
    },
    UsersRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.UsersScreen(),
      );
    },
    RuleAlloctionsRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.RuleAlloctionsScreen(),
      );
    },
    RuleAllocationAddRoute.name: (routeData) {
      return _i21.AutoRoutePage<_i22.RuleAllocationData>(
        routeData: routeData,
        child: const _i8.RuleAllocationAddScreen(),
      );
    },
    UserEditRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserEditRouteArgs>(
          orElse: () => UserEditRouteArgs(userId: pathParams.optInt('id')));
      return _i21.AutoRoutePage<_i22.User>(
        routeData: routeData,
        child: _i9.UserEditScreen(
          key: args.key,
          userId: args.userId,
          user: args.user,
        ),
      );
    },
    ArchivesDirectoryRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ArchivesDirectoryScreen(),
      );
    },
    AvailableArchiveLocationRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AvailableArchiveLocationRouteArgs>(
          orElse: () => AvailableArchiveLocationRouteArgs(
              sourceId: pathParams.optInt('source_id')));
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.AvailableArchiveLocationScreen(
          key: args.key,
          sourceId: args.sourceId,
        ),
      );
    },
    ArchivePartRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ArchivePartRouteArgs>(
          orElse: () =>
              ArchivePartRouteArgs(archiveID: pathParams.optInt('id')));
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.ArchivePartScreen(
          key: args.key,
          archiveID: args.archiveID,
        ),
      );
    },
    ArchiveLocationAddRoute.name: (routeData) {
      return _i21.AutoRoutePage<_i22.ArchiveLocation>(
        routeData: routeData,
        child: const _i13.ArchiveLocationAddScreen(),
      );
    },
    MapAllocationRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MapAllocationRouteArgs>(
          orElse: () =>
              MapAllocationRouteArgs(archiveID: pathParams.optInt('id')));
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.MapAllocationScreen(
          key: args.key,
          archiveID: args.archiveID,
        ),
      );
    },
    ArchiveStatusRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.ArchiveStatusScreen(),
      );
    },
    ArchiveLocationEditRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ArchiveLocationEditRouteArgs>(
          orElse: () =>
              ArchiveLocationEditRouteArgs(archiveId: pathParams.optInt('id')));
      return _i21.AutoRoutePage<_i22.ArchiveLocation>(
        routeData: routeData,
        child: _i16.ArchiveLocationEditScreen(
          key: args.key,
          archiveId: args.archiveId,
          archiveLocation: args.archiveLocation,
        ),
      );
    },
    DataSourceDirectoryRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.DataSourceDirectoryScreen(),
      );
    },
    ArchiveLocationRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.ArchiveLocationScreen(),
      );
    },
    DataSourceEditRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DataSourceEditRouteArgs>(
          orElse: () =>
              DataSourceEditRouteArgs(dataSourceId: pathParams.optInt('id')));
      return _i21.AutoRoutePage<_i22.DataSource>(
        routeData: routeData,
        child: _i19.DataSourceEditScreen(
          key: args.key,
          dataSourceId: args.dataSourceId,
          dataSource: args.dataSource,
        ),
      );
    },
    DataSourceAddRoute.name: (routeData) {
      return _i21.AutoRoutePage<_i22.DataSource>(
        routeData: routeData,
        child: _i20.DataSourceAddScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.PaymentsScreen]
class PaymentsRoute extends _i21.PageRouteInfo<void> {
  const PaymentsRoute({List<_i21.PageRouteInfo>? children})
      : super(
          PaymentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentsRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AuthScreen]
class AuthRoute extends _i21.PageRouteInfo<void> {
  const AuthRoute({List<_i21.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i3.RuleAllocationEditScreen]
class RuleAllocationEditRoute
    extends _i21.PageRouteInfo<RuleAllocationEditRouteArgs> {
  RuleAllocationEditRoute({
    _i23.Key? key,
    int? ruleAllocationId,
    _i22.RuleAllocationData? ruleAllocation,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          RuleAllocationEditRoute.name,
          args: RuleAllocationEditRouteArgs(
            key: key,
            ruleAllocationId: ruleAllocationId,
            ruleAllocation: ruleAllocation,
          ),
          rawPathParams: {'id': ruleAllocationId},
          initialChildren: children,
        );

  static const String name = 'RuleAllocationEditRoute';

  static const _i21.PageInfo<RuleAllocationEditRouteArgs> page =
      _i21.PageInfo<RuleAllocationEditRouteArgs>(name);
}

class RuleAllocationEditRouteArgs {
  const RuleAllocationEditRouteArgs({
    this.key,
    this.ruleAllocationId,
    this.ruleAllocation,
  });

  final _i23.Key? key;

  final int? ruleAllocationId;

  final _i22.RuleAllocationData? ruleAllocation;

  @override
  String toString() {
    return 'RuleAllocationEditRouteArgs{key: $key, ruleAllocationId: $ruleAllocationId, ruleAllocation: $ruleAllocation}';
  }
}

/// generated route for
/// [_i4.AuditLogScreen]
class AuditLogRoute extends _i21.PageRouteInfo<void> {
  const AuditLogRoute({List<_i21.PageRouteInfo>? children})
      : super(
          AuditLogRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuditLogRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i5.UserAddScreen]
class UserAddRoute extends _i21.PageRouteInfo<UserAddRouteArgs> {
  UserAddRoute({
    _i23.Key? key,
    int? selectedTypeId,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          UserAddRoute.name,
          args: UserAddRouteArgs(
            key: key,
            selectedTypeId: selectedTypeId,
          ),
          initialChildren: children,
        );

  static const String name = 'UserAddRoute';

  static const _i21.PageInfo<UserAddRouteArgs> page =
      _i21.PageInfo<UserAddRouteArgs>(name);
}

class UserAddRouteArgs {
  const UserAddRouteArgs({
    this.key,
    this.selectedTypeId,
  });

  final _i23.Key? key;

  final int? selectedTypeId;

  @override
  String toString() {
    return 'UserAddRouteArgs{key: $key, selectedTypeId: $selectedTypeId}';
  }
}

/// generated route for
/// [_i6.UsersScreen]
class UsersRoute extends _i21.PageRouteInfo<void> {
  const UsersRoute({List<_i21.PageRouteInfo>? children})
      : super(
          UsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i7.RuleAlloctionsScreen]
class RuleAlloctionsRoute extends _i21.PageRouteInfo<void> {
  const RuleAlloctionsRoute({List<_i21.PageRouteInfo>? children})
      : super(
          RuleAlloctionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RuleAlloctionsRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i8.RuleAllocationAddScreen]
class RuleAllocationAddRoute extends _i21.PageRouteInfo<void> {
  const RuleAllocationAddRoute({List<_i21.PageRouteInfo>? children})
      : super(
          RuleAllocationAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'RuleAllocationAddRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i9.UserEditScreen]
class UserEditRoute extends _i21.PageRouteInfo<UserEditRouteArgs> {
  UserEditRoute({
    _i23.Key? key,
    int? userId,
    _i22.User? user,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          UserEditRoute.name,
          args: UserEditRouteArgs(
            key: key,
            userId: userId,
            user: user,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'UserEditRoute';

  static const _i21.PageInfo<UserEditRouteArgs> page =
      _i21.PageInfo<UserEditRouteArgs>(name);
}

class UserEditRouteArgs {
  const UserEditRouteArgs({
    this.key,
    this.userId,
    this.user,
  });

  final _i23.Key? key;

  final int? userId;

  final _i22.User? user;

  @override
  String toString() {
    return 'UserEditRouteArgs{key: $key, userId: $userId, user: $user}';
  }
}

/// generated route for
/// [_i10.ArchivesDirectoryScreen]
class ArchivesDirectoryRoute extends _i21.PageRouteInfo<void> {
  const ArchivesDirectoryRoute({List<_i21.PageRouteInfo>? children})
      : super(
          ArchivesDirectoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'ArchivesDirectoryRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i11.AvailableArchiveLocationScreen]
class AvailableArchiveLocationRoute
    extends _i21.PageRouteInfo<AvailableArchiveLocationRouteArgs> {
  AvailableArchiveLocationRoute({
    _i23.Key? key,
    int? sourceId,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          AvailableArchiveLocationRoute.name,
          args: AvailableArchiveLocationRouteArgs(
            key: key,
            sourceId: sourceId,
          ),
          rawPathParams: {'source_id': sourceId},
          initialChildren: children,
        );

  static const String name = 'AvailableArchiveLocationRoute';

  static const _i21.PageInfo<AvailableArchiveLocationRouteArgs> page =
      _i21.PageInfo<AvailableArchiveLocationRouteArgs>(name);
}

class AvailableArchiveLocationRouteArgs {
  const AvailableArchiveLocationRouteArgs({
    this.key,
    this.sourceId,
  });

  final _i23.Key? key;

  final int? sourceId;

  @override
  String toString() {
    return 'AvailableArchiveLocationRouteArgs{key: $key, sourceId: $sourceId}';
  }
}

/// generated route for
/// [_i12.ArchivePartScreen]
class ArchivePartRoute extends _i21.PageRouteInfo<ArchivePartRouteArgs> {
  ArchivePartRoute({
    _i23.Key? key,
    int? archiveID,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          ArchivePartRoute.name,
          args: ArchivePartRouteArgs(
            key: key,
            archiveID: archiveID,
          ),
          rawPathParams: {'id': archiveID},
          initialChildren: children,
        );

  static const String name = 'ArchivePartRoute';

  static const _i21.PageInfo<ArchivePartRouteArgs> page =
      _i21.PageInfo<ArchivePartRouteArgs>(name);
}

class ArchivePartRouteArgs {
  const ArchivePartRouteArgs({
    this.key,
    this.archiveID,
  });

  final _i23.Key? key;

  final int? archiveID;

  @override
  String toString() {
    return 'ArchivePartRouteArgs{key: $key, archiveID: $archiveID}';
  }
}

/// generated route for
/// [_i13.ArchiveLocationAddScreen]
class ArchiveLocationAddRoute extends _i21.PageRouteInfo<void> {
  const ArchiveLocationAddRoute({List<_i21.PageRouteInfo>? children})
      : super(
          ArchiveLocationAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'ArchiveLocationAddRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i14.MapAllocationScreen]
class MapAllocationRoute extends _i21.PageRouteInfo<MapAllocationRouteArgs> {
  MapAllocationRoute({
    _i23.Key? key,
    int? archiveID,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          MapAllocationRoute.name,
          args: MapAllocationRouteArgs(
            key: key,
            archiveID: archiveID,
          ),
          rawPathParams: {'id': archiveID},
          initialChildren: children,
        );

  static const String name = 'MapAllocationRoute';

  static const _i21.PageInfo<MapAllocationRouteArgs> page =
      _i21.PageInfo<MapAllocationRouteArgs>(name);
}

class MapAllocationRouteArgs {
  const MapAllocationRouteArgs({
    this.key,
    this.archiveID,
  });

  final _i23.Key? key;

  final int? archiveID;

  @override
  String toString() {
    return 'MapAllocationRouteArgs{key: $key, archiveID: $archiveID}';
  }
}

/// generated route for
/// [_i15.ArchiveStatusScreen]
class ArchiveStatusRoute extends _i21.PageRouteInfo<void> {
  const ArchiveStatusRoute({List<_i21.PageRouteInfo>? children})
      : super(
          ArchiveStatusRoute.name,
          initialChildren: children,
        );

  static const String name = 'ArchiveStatusRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i16.ArchiveLocationEditScreen]
class ArchiveLocationEditRoute
    extends _i21.PageRouteInfo<ArchiveLocationEditRouteArgs> {
  ArchiveLocationEditRoute({
    _i23.Key? key,
    int? archiveId,
    _i22.ArchiveLocation? archiveLocation,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          ArchiveLocationEditRoute.name,
          args: ArchiveLocationEditRouteArgs(
            key: key,
            archiveId: archiveId,
            archiveLocation: archiveLocation,
          ),
          rawPathParams: {'id': archiveId},
          initialChildren: children,
        );

  static const String name = 'ArchiveLocationEditRoute';

  static const _i21.PageInfo<ArchiveLocationEditRouteArgs> page =
      _i21.PageInfo<ArchiveLocationEditRouteArgs>(name);
}

class ArchiveLocationEditRouteArgs {
  const ArchiveLocationEditRouteArgs({
    this.key,
    this.archiveId,
    this.archiveLocation,
  });

  final _i23.Key? key;

  final int? archiveId;

  final _i22.ArchiveLocation? archiveLocation;

  @override
  String toString() {
    return 'ArchiveLocationEditRouteArgs{key: $key, archiveId: $archiveId, archiveLocation: $archiveLocation}';
  }
}

/// generated route for
/// [_i17.DataSourceDirectoryScreen]
class DataSourceDirectoryRoute extends _i21.PageRouteInfo<void> {
  const DataSourceDirectoryRoute({List<_i21.PageRouteInfo>? children})
      : super(
          DataSourceDirectoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'DataSourceDirectoryRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i18.ArchiveLocationScreen]
class ArchiveLocationRoute extends _i21.PageRouteInfo<void> {
  const ArchiveLocationRoute({List<_i21.PageRouteInfo>? children})
      : super(
          ArchiveLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ArchiveLocationRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i19.DataSourceEditScreen]
class DataSourceEditRoute extends _i21.PageRouteInfo<DataSourceEditRouteArgs> {
  DataSourceEditRoute({
    _i23.Key? key,
    int? dataSourceId,
    _i22.DataSource? dataSource,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          DataSourceEditRoute.name,
          args: DataSourceEditRouteArgs(
            key: key,
            dataSourceId: dataSourceId,
            dataSource: dataSource,
          ),
          rawPathParams: {'id': dataSourceId},
          initialChildren: children,
        );

  static const String name = 'DataSourceEditRoute';

  static const _i21.PageInfo<DataSourceEditRouteArgs> page =
      _i21.PageInfo<DataSourceEditRouteArgs>(name);
}

class DataSourceEditRouteArgs {
  const DataSourceEditRouteArgs({
    this.key,
    this.dataSourceId,
    this.dataSource,
  });

  final _i23.Key? key;

  final int? dataSourceId;

  final _i22.DataSource? dataSource;

  @override
  String toString() {
    return 'DataSourceEditRouteArgs{key: $key, dataSourceId: $dataSourceId, dataSource: $dataSource}';
  }
}

/// generated route for
/// [_i20.DataSourceAddScreen]
class DataSourceAddRoute extends _i21.PageRouteInfo<void> {
  const DataSourceAddRoute({List<_i21.PageRouteInfo>? children})
      : super(
          DataSourceAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'DataSourceAddRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}
