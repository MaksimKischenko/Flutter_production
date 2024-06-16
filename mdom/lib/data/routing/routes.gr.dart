// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i28;
import 'package:bpc/data/data.dart' as _i30;
import 'package:bpc/models/models.dart' as _i33;
import 'package:bpc/screens/about_app/about_app_screen.dart' as _i1;
import 'package:bpc/screens/auth/auth_screen.dart' as _i2;
import 'package:bpc/screens/change_password/change_password_screen.dart' as _i3;
import 'package:bpc/screens/claim_info/claim_info_screen.dart' as _i4;
import 'package:bpc/screens/claim_payments/claim_payments_screen.dart' as _i5;
import 'package:bpc/screens/claims/claims_screen.dart' as _i6;
import 'package:bpc/screens/features/features_screen.dart' as _i7;
import 'package:bpc/screens/help/help_screen.dart' as _i8;
import 'package:bpc/screens/main_mobile/main_screen.dart' as _i9;
import 'package:bpc/screens/payment_info/payment_info_screen.dart' as _i10;
import 'package:bpc/screens/payments/payments_screen.dart' as _i11;
import 'package:bpc/screens/poll/poll_screen.dart' as _i14;
import 'package:bpc/screens/poll_add/poll_add_screen.dart' as _i12;
import 'package:bpc/screens/poll_members/poll_members_screen.dart' as _i13;
import 'package:bpc/screens/poll_statistics/poll_statistics_screen.dart'
    as _i16;
import 'package:bpc/screens/poll_statistics_question/poll_statistics_question_screen.dart'
    as _i15;
import 'package:bpc/screens/polls_list/polls_list_screen.dart' as _i18;
import 'package:bpc/screens/polls_list_filters/polls_list_filters_screen.dart'
    as _i17;
import 'package:bpc/screens/profile/profile_screen.dart' as _i19;
import 'package:bpc/screens/qr_cam/qr_cam_screen.dart' as _i20;
import 'package:bpc/screens/registration/registration_screen.dart' as _i23;
import 'package:bpc/screens/registration_code/registration_code_screen.dart'
    as _i21;
import 'package:bpc/screens/registration_params/registration_params_screen.dart'
    as _i22;
import 'package:bpc/screens/registration_success/registration_success_screen.dart'
    as _i24;
import 'package:bpc/screens/services_qr/services_qr_screen.dart' as _i25;
import 'package:bpc/screens/settings/settings_screen.dart' as _i26;
import 'package:bpc/screens/splash/splash_screen.dart' as _i27;
import 'package:flutter/cupertino.dart' as _i29;
import 'package:flutter/foundation.dart' as _i31;
import 'package:flutter/material.dart' as _i32;

abstract class $Routes extends _i28.RootStackRouter {
  $Routes({super.navigatorKey});

  @override
  final Map<String, _i28.PageFactory> pagesMap = {
    AboutAppRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AboutAppScreen(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AuthScreen(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordRouteArgs>(
          orElse: () => const ChangePasswordRouteArgs());
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.ChangePasswordScreen(controller: args.controller),
      );
    },
    ClaimInfoRoute.name: (routeData) {
      final args = routeData.argsAs<ClaimInfoRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.ClaimInfoScreen(
          service: args.service,
          claim: args.claim,
          key: args.key,
        ),
      );
    },
    ClaimPaymentsRoute.name: (routeData) {
      final args = routeData.argsAs<ClaimPaymentsRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ClaimPaymentsScreen(
          key: args.key,
          data: args.data,
        ),
      );
    },
    ClaimsRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ClaimsScreen(),
      );
    },
    FeaturesRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.FeaturesScreen(),
      );
    },
    HelpRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.HelpScreen(),
      );
    },
    MainRouteMobile.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.MainScreenMobile(),
      );
    },
    PaymentInfoRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentInfoRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.PaymentInfoScreen(
          key: args.key,
          payment: args.payment,
        ),
      );
    },
    PaymentsRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.PaymentsScreen(),
      );
    },
    PollAddRoute.name: (routeData) {
      final args = routeData.argsAs<PollAddRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.PollAddScreen(
          key: args.key,
          poll: args.poll,
        ),
      );
    },
    PollMembersRoute.name: (routeData) {
      final args = routeData.argsAs<PollMembersRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.PollMembersScreen(
          key: args.key,
          participantsCount: args.participantsCount,
          confirmedCount: args.confirmedCount,
          poll: args.poll,
        ),
      );
    },
    PollRoute.name: (routeData) {
      final args = routeData.argsAs<PollRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.PollScreen(
          key: args.key,
          participantsCount: args.participantsCount,
          confirmedCount: args.confirmedCount,
          poll: args.poll,
        ),
      );
    },
    PollStatisticsQuestionRoute.name: (routeData) {
      final args = routeData.argsAs<PollStatisticsQuestionRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.PollStatisticsQuestionScreen(
          key: args.key,
          question: args.question,
          pollId: args.pollId,
        ),
      );
    },
    PollStatisticsRoute.name: (routeData) {
      final args = routeData.argsAs<PollStatisticsRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.PollStatisticsScreen(
          key: args.key,
          participantsCount: args.participantsCount,
          confirmedCount: args.confirmedCount,
          poll: args.poll,
        ),
      );
    },
    PollsListFiltersRoute.name: (routeData) {
      final args = routeData.argsAs<PollsListFiltersRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.PollsListFiltersScreen(
          key: args.key,
          initialFilters: args.initialFilters,
        ),
      );
    },
    PollsListRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.PollsListScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.ProfileScreen(),
      );
    },
    QrCamRoute.name: (routeData) {
      final args = routeData.argsAs<QrCamRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.QrCamScreen(initialDateFrom: args.initialDateFrom),
      );
    },
    RegistrationCodeRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationCodeRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.RegistrationCodeScreen(codeType: args.codeType),
      );
    },
    RegistrationParamsRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationParamsRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.RegistrationParamsScreen(
          key: args.key,
          params: args.params,
        ),
      );
    },
    RegistrationRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.RegistrationScreen(),
      );
    },
    RegistrationSuccessRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.RegistrationSuccessScreen(),
      );
    },
    ServicesQrRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.ServicesQrScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.SettingsScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AboutAppScreen]
class AboutAppRoute extends _i28.PageRouteInfo<void> {
  const AboutAppRoute({List<_i28.PageRouteInfo>? children})
      : super(
          AboutAppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutAppRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AuthScreen]
class AuthRoute extends _i28.PageRouteInfo<void> {
  const AuthRoute({List<_i28.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ChangePasswordScreen]
class ChangePasswordRoute extends _i28.PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({
    _i29.ScrollController? controller,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          ChangePasswordRoute.name,
          args: ChangePasswordRouteArgs(controller: controller),
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i28.PageInfo<ChangePasswordRouteArgs> page =
      _i28.PageInfo<ChangePasswordRouteArgs>(name);
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({this.controller});

  final _i29.ScrollController? controller;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{controller: $controller}';
  }
}

/// generated route for
/// [_i4.ClaimInfoScreen]
class ClaimInfoRoute extends _i28.PageRouteInfo<ClaimInfoRouteArgs> {
  ClaimInfoRoute({
    required _i30.Service service,
    required _i30.Claim claim,
    _i31.Key? key,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          ClaimInfoRoute.name,
          args: ClaimInfoRouteArgs(
            service: service,
            claim: claim,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ClaimInfoRoute';

  static const _i28.PageInfo<ClaimInfoRouteArgs> page =
      _i28.PageInfo<ClaimInfoRouteArgs>(name);
}

class ClaimInfoRouteArgs {
  const ClaimInfoRouteArgs({
    required this.service,
    required this.claim,
    this.key,
  });

  final _i30.Service service;

  final _i30.Claim claim;

  final _i31.Key? key;

  @override
  String toString() {
    return 'ClaimInfoRouteArgs{service: $service, claim: $claim, key: $key}';
  }
}

/// generated route for
/// [_i5.ClaimPaymentsScreen]
class ClaimPaymentsRoute extends _i28.PageRouteInfo<ClaimPaymentsRouteArgs> {
  ClaimPaymentsRoute({
    _i32.Key? key,
    required _i33.ClaimPaymentsData data,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          ClaimPaymentsRoute.name,
          args: ClaimPaymentsRouteArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'ClaimPaymentsRoute';

  static const _i28.PageInfo<ClaimPaymentsRouteArgs> page =
      _i28.PageInfo<ClaimPaymentsRouteArgs>(name);
}

class ClaimPaymentsRouteArgs {
  const ClaimPaymentsRouteArgs({
    this.key,
    required this.data,
  });

  final _i32.Key? key;

  final _i33.ClaimPaymentsData data;

  @override
  String toString() {
    return 'ClaimPaymentsRouteArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i6.ClaimsScreen]
class ClaimsRoute extends _i28.PageRouteInfo<void> {
  const ClaimsRoute({List<_i28.PageRouteInfo>? children})
      : super(
          ClaimsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClaimsRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i7.FeaturesScreen]
class FeaturesRoute extends _i28.PageRouteInfo<void> {
  const FeaturesRoute({List<_i28.PageRouteInfo>? children})
      : super(
          FeaturesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FeaturesRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HelpScreen]
class HelpRoute extends _i28.PageRouteInfo<void> {
  const HelpRoute({List<_i28.PageRouteInfo>? children})
      : super(
          HelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i9.MainScreenMobile]
class MainRouteMobile extends _i28.PageRouteInfo<void> {
  const MainRouteMobile({List<_i28.PageRouteInfo>? children})
      : super(
          MainRouteMobile.name,
          initialChildren: children,
        );

  static const String name = 'MainRouteMobile';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i10.PaymentInfoScreen]
class PaymentInfoRoute extends _i28.PageRouteInfo<PaymentInfoRouteArgs> {
  PaymentInfoRoute({
    _i32.Key? key,
    required _i30.Payment payment,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          PaymentInfoRoute.name,
          args: PaymentInfoRouteArgs(
            key: key,
            payment: payment,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentInfoRoute';

  static const _i28.PageInfo<PaymentInfoRouteArgs> page =
      _i28.PageInfo<PaymentInfoRouteArgs>(name);
}

class PaymentInfoRouteArgs {
  const PaymentInfoRouteArgs({
    this.key,
    required this.payment,
  });

  final _i32.Key? key;

  final _i30.Payment payment;

  @override
  String toString() {
    return 'PaymentInfoRouteArgs{key: $key, payment: $payment}';
  }
}

/// generated route for
/// [_i11.PaymentsScreen]
class PaymentsRoute extends _i28.PageRouteInfo<void> {
  const PaymentsRoute({List<_i28.PageRouteInfo>? children})
      : super(
          PaymentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentsRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i12.PollAddScreen]
class PollAddRoute extends _i28.PageRouteInfo<PollAddRouteArgs> {
  PollAddRoute({
    _i29.Key? key,
    required _i30.Poll? poll,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          PollAddRoute.name,
          args: PollAddRouteArgs(
            key: key,
            poll: poll,
          ),
          initialChildren: children,
        );

  static const String name = 'PollAddRoute';

  static const _i28.PageInfo<PollAddRouteArgs> page =
      _i28.PageInfo<PollAddRouteArgs>(name);
}

class PollAddRouteArgs {
  const PollAddRouteArgs({
    this.key,
    required this.poll,
  });

  final _i29.Key? key;

  final _i30.Poll? poll;

  @override
  String toString() {
    return 'PollAddRouteArgs{key: $key, poll: $poll}';
  }
}

/// generated route for
/// [_i13.PollMembersScreen]
class PollMembersRoute extends _i28.PageRouteInfo<PollMembersRouteArgs> {
  PollMembersRoute({
    _i29.Key? key,
    required int participantsCount,
    required int confirmedCount,
    required _i30.Poll poll,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          PollMembersRoute.name,
          args: PollMembersRouteArgs(
            key: key,
            participantsCount: participantsCount,
            confirmedCount: confirmedCount,
            poll: poll,
          ),
          initialChildren: children,
        );

  static const String name = 'PollMembersRoute';

  static const _i28.PageInfo<PollMembersRouteArgs> page =
      _i28.PageInfo<PollMembersRouteArgs>(name);
}

class PollMembersRouteArgs {
  const PollMembersRouteArgs({
    this.key,
    required this.participantsCount,
    required this.confirmedCount,
    required this.poll,
  });

  final _i29.Key? key;

  final int participantsCount;

  final int confirmedCount;

  final _i30.Poll poll;

  @override
  String toString() {
    return 'PollMembersRouteArgs{key: $key, participantsCount: $participantsCount, confirmedCount: $confirmedCount, poll: $poll}';
  }
}

/// generated route for
/// [_i14.PollScreen]
class PollRoute extends _i28.PageRouteInfo<PollRouteArgs> {
  PollRoute({
    _i32.Key? key,
    required int participantsCount,
    required int confirmedCount,
    required _i30.Poll poll,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          PollRoute.name,
          args: PollRouteArgs(
            key: key,
            participantsCount: participantsCount,
            confirmedCount: confirmedCount,
            poll: poll,
          ),
          initialChildren: children,
        );

  static const String name = 'PollRoute';

  static const _i28.PageInfo<PollRouteArgs> page =
      _i28.PageInfo<PollRouteArgs>(name);
}

class PollRouteArgs {
  const PollRouteArgs({
    this.key,
    required this.participantsCount,
    required this.confirmedCount,
    required this.poll,
  });

  final _i32.Key? key;

  final int participantsCount;

  final int confirmedCount;

  final _i30.Poll poll;

  @override
  String toString() {
    return 'PollRouteArgs{key: $key, participantsCount: $participantsCount, confirmedCount: $confirmedCount, poll: $poll}';
  }
}

/// generated route for
/// [_i15.PollStatisticsQuestionScreen]
class PollStatisticsQuestionRoute
    extends _i28.PageRouteInfo<PollStatisticsQuestionRouteArgs> {
  PollStatisticsQuestionRoute({
    _i32.Key? key,
    required _i30.PollListQuestion question,
    required int pollId,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          PollStatisticsQuestionRoute.name,
          args: PollStatisticsQuestionRouteArgs(
            key: key,
            question: question,
            pollId: pollId,
          ),
          initialChildren: children,
        );

  static const String name = 'PollStatisticsQuestionRoute';

  static const _i28.PageInfo<PollStatisticsQuestionRouteArgs> page =
      _i28.PageInfo<PollStatisticsQuestionRouteArgs>(name);
}

class PollStatisticsQuestionRouteArgs {
  const PollStatisticsQuestionRouteArgs({
    this.key,
    required this.question,
    required this.pollId,
  });

  final _i32.Key? key;

  final _i30.PollListQuestion question;

  final int pollId;

  @override
  String toString() {
    return 'PollStatisticsQuestionRouteArgs{key: $key, question: $question, pollId: $pollId}';
  }
}

/// generated route for
/// [_i16.PollStatisticsScreen]
class PollStatisticsRoute extends _i28.PageRouteInfo<PollStatisticsRouteArgs> {
  PollStatisticsRoute({
    _i32.Key? key,
    required int participantsCount,
    required int confirmedCount,
    required _i30.Poll poll,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          PollStatisticsRoute.name,
          args: PollStatisticsRouteArgs(
            key: key,
            participantsCount: participantsCount,
            confirmedCount: confirmedCount,
            poll: poll,
          ),
          initialChildren: children,
        );

  static const String name = 'PollStatisticsRoute';

  static const _i28.PageInfo<PollStatisticsRouteArgs> page =
      _i28.PageInfo<PollStatisticsRouteArgs>(name);
}

class PollStatisticsRouteArgs {
  const PollStatisticsRouteArgs({
    this.key,
    required this.participantsCount,
    required this.confirmedCount,
    required this.poll,
  });

  final _i32.Key? key;

  final int participantsCount;

  final int confirmedCount;

  final _i30.Poll poll;

  @override
  String toString() {
    return 'PollStatisticsRouteArgs{key: $key, participantsCount: $participantsCount, confirmedCount: $confirmedCount, poll: $poll}';
  }
}

/// generated route for
/// [_i17.PollsListFiltersScreen]
class PollsListFiltersRoute
    extends _i28.PageRouteInfo<PollsListFiltersRouteArgs> {
  PollsListFiltersRoute({
    _i32.Key? key,
    required _i33.PollsListFiltersData initialFilters,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          PollsListFiltersRoute.name,
          args: PollsListFiltersRouteArgs(
            key: key,
            initialFilters: initialFilters,
          ),
          initialChildren: children,
        );

  static const String name = 'PollsListFiltersRoute';

  static const _i28.PageInfo<PollsListFiltersRouteArgs> page =
      _i28.PageInfo<PollsListFiltersRouteArgs>(name);
}

class PollsListFiltersRouteArgs {
  const PollsListFiltersRouteArgs({
    this.key,
    required this.initialFilters,
  });

  final _i32.Key? key;

  final _i33.PollsListFiltersData initialFilters;

  @override
  String toString() {
    return 'PollsListFiltersRouteArgs{key: $key, initialFilters: $initialFilters}';
  }
}

/// generated route for
/// [_i18.PollsListScreen]
class PollsListRoute extends _i28.PageRouteInfo<void> {
  const PollsListRoute({List<_i28.PageRouteInfo>? children})
      : super(
          PollsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'PollsListRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i19.ProfileScreen]
class ProfileRoute extends _i28.PageRouteInfo<void> {
  const ProfileRoute({List<_i28.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i20.QrCamScreen]
class QrCamRoute extends _i28.PageRouteInfo<QrCamRouteArgs> {
  QrCamRoute({
    required DateTime initialDateFrom,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          QrCamRoute.name,
          args: QrCamRouteArgs(initialDateFrom: initialDateFrom),
          initialChildren: children,
        );

  static const String name = 'QrCamRoute';

  static const _i28.PageInfo<QrCamRouteArgs> page =
      _i28.PageInfo<QrCamRouteArgs>(name);
}

class QrCamRouteArgs {
  const QrCamRouteArgs({required this.initialDateFrom});

  final DateTime initialDateFrom;

  @override
  String toString() {
    return 'QrCamRouteArgs{initialDateFrom: $initialDateFrom}';
  }
}

/// generated route for
/// [_i21.RegistrationCodeScreen]
class RegistrationCodeRoute
    extends _i28.PageRouteInfo<RegistrationCodeRouteArgs> {
  RegistrationCodeRoute({
    required _i33.ConfirmCodeType codeType,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          RegistrationCodeRoute.name,
          args: RegistrationCodeRouteArgs(codeType: codeType),
          initialChildren: children,
        );

  static const String name = 'RegistrationCodeRoute';

  static const _i28.PageInfo<RegistrationCodeRouteArgs> page =
      _i28.PageInfo<RegistrationCodeRouteArgs>(name);
}

class RegistrationCodeRouteArgs {
  const RegistrationCodeRouteArgs({required this.codeType});

  final _i33.ConfirmCodeType codeType;

  @override
  String toString() {
    return 'RegistrationCodeRouteArgs{codeType: $codeType}';
  }
}

/// generated route for
/// [_i22.RegistrationParamsScreen]
class RegistrationParamsRoute
    extends _i28.PageRouteInfo<RegistrationParamsRouteArgs> {
  RegistrationParamsRoute({
    _i32.Key? key,
    required List<_i30.MdomResponseParam> params,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          RegistrationParamsRoute.name,
          args: RegistrationParamsRouteArgs(
            key: key,
            params: params,
          ),
          initialChildren: children,
        );

  static const String name = 'RegistrationParamsRoute';

  static const _i28.PageInfo<RegistrationParamsRouteArgs> page =
      _i28.PageInfo<RegistrationParamsRouteArgs>(name);
}

class RegistrationParamsRouteArgs {
  const RegistrationParamsRouteArgs({
    this.key,
    required this.params,
  });

  final _i32.Key? key;

  final List<_i30.MdomResponseParam> params;

  @override
  String toString() {
    return 'RegistrationParamsRouteArgs{key: $key, params: $params}';
  }
}

/// generated route for
/// [_i23.RegistrationScreen]
class RegistrationRoute extends _i28.PageRouteInfo<void> {
  const RegistrationRoute({List<_i28.PageRouteInfo>? children})
      : super(
          RegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i24.RegistrationSuccessScreen]
class RegistrationSuccessRoute extends _i28.PageRouteInfo<void> {
  const RegistrationSuccessRoute({List<_i28.PageRouteInfo>? children})
      : super(
          RegistrationSuccessRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationSuccessRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i25.ServicesQrScreen]
class ServicesQrRoute extends _i28.PageRouteInfo<void> {
  const ServicesQrRoute({List<_i28.PageRouteInfo>? children})
      : super(
          ServicesQrRoute.name,
          initialChildren: children,
        );

  static const String name = 'ServicesQrRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i26.SettingsScreen]
class SettingsRoute extends _i28.PageRouteInfo<void> {
  const SettingsRoute({List<_i28.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i27.SplashScreen]
class SplashRoute extends _i28.PageRouteInfo<void> {
  const SplashRoute({List<_i28.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}
