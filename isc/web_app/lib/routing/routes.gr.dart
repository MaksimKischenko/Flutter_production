// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:isc_web_app/data/data.dart' as _i12;
import 'package:isc_web_app/screens/auth/auth_screen.dart' as _i4;
import 'package:isc_web_app/screens/claim_info/claim_info_screen.dart' as _i6;
import 'package:isc_web_app/screens/claims/claims_screen.dart' as _i9;
import 'package:isc_web_app/screens/payment_info/payment_info_screen.dart'
    as _i7;
import 'package:isc_web_app/screens/payments/payments_screen.dart' as _i2;
import 'package:isc_web_app/screens/profile/profile_screen.dart' as _i5;
import 'package:isc_web_app/screens/register_payment_claim/register_payment_claim_screen.dart'
    as _i8;
import 'package:isc_web_app/screens/settings/settings_screen.dart' as _i1;
import 'package:isc_web_app/screens/splash/splash_screen.dart' as _i3;

abstract class $Routes extends _i10.RootStackRouter {
  $Routes({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    SettingsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.SettingsScreen(),
      );
    },
    PaymentsISCRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PaymentsISCScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SplashScreen(),
      );
    },
    AuthRoute.name: (routeData) {
      final args =
          routeData.argsAs<AuthRouteArgs>(orElse: () => const AuthRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.AuthScreen(
          next: args.next,
          key: args.key,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ProfileScreen(),
      );
    },
    ClaimInfoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ClaimInfoRouteArgs>(
          orElse: () => ClaimInfoRouteArgs(claimId: pathParams.optInt('id')));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.ClaimInfoScreen(
          claimId: args.claimId,
          claim: args.claim,
          key: args.key,
        ),
      );
    },
    PaymentInfoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PaymentInfoRouteArgs>(
          orElse: () =>
              PaymentInfoRouteArgs(paymentId: pathParams.optInt('id')));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.PaymentInfoScreen(
          key: args.key,
          paymentId: args.paymentId,
          payment: args.payment,
        ),
      );
    },
    RegisterPaymentClaimRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RegisterPaymentClaimRouteArgs>(
          orElse: () =>
              RegisterPaymentClaimRouteArgs(claimId: pathParams.optInt('id')));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.RegisterPaymentClaimScreen(
          claimId: args.claimId,
          key: args.key,
        ),
      );
    },
    ClaimsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ClaimsScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.SettingsScreen]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PaymentsISCScreen]
class PaymentsISCRoute extends _i10.PageRouteInfo<void> {
  const PaymentsISCRoute({List<_i10.PageRouteInfo>? children})
      : super(
          PaymentsISCRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentsISCRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SplashScreen]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AuthScreen]
class AuthRoute extends _i10.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    String? next,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          AuthRoute.name,
          args: AuthRouteArgs(
            next: next,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i10.PageInfo<AuthRouteArgs> page =
      _i10.PageInfo<AuthRouteArgs>(name);
}

class AuthRouteArgs {
  const AuthRouteArgs({
    this.next,
    this.key,
  });

  final String? next;

  final _i11.Key? key;

  @override
  String toString() {
    return 'AuthRouteArgs{next: $next, key: $key}';
  }
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ClaimInfoScreen]
class ClaimInfoRoute extends _i10.PageRouteInfo<ClaimInfoRouteArgs> {
  ClaimInfoRoute({
    int? claimId,
    _i12.Claim? claim,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          ClaimInfoRoute.name,
          args: ClaimInfoRouteArgs(
            claimId: claimId,
            claim: claim,
            key: key,
          ),
          rawPathParams: {'id': claimId},
          initialChildren: children,
        );

  static const String name = 'ClaimInfoRoute';

  static const _i10.PageInfo<ClaimInfoRouteArgs> page =
      _i10.PageInfo<ClaimInfoRouteArgs>(name);
}

class ClaimInfoRouteArgs {
  const ClaimInfoRouteArgs({
    this.claimId,
    this.claim,
    this.key,
  });

  final int? claimId;

  final _i12.Claim? claim;

  final _i11.Key? key;

  @override
  String toString() {
    return 'ClaimInfoRouteArgs{claimId: $claimId, claim: $claim, key: $key}';
  }
}

/// generated route for
/// [_i7.PaymentInfoScreen]
class PaymentInfoRoute extends _i10.PageRouteInfo<PaymentInfoRouteArgs> {
  PaymentInfoRoute({
    _i11.Key? key,
    int? paymentId,
    _i12.PaymentISC? payment,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          PaymentInfoRoute.name,
          args: PaymentInfoRouteArgs(
            key: key,
            paymentId: paymentId,
            payment: payment,
          ),
          rawPathParams: {'id': paymentId},
          initialChildren: children,
        );

  static const String name = 'PaymentInfoRoute';

  static const _i10.PageInfo<PaymentInfoRouteArgs> page =
      _i10.PageInfo<PaymentInfoRouteArgs>(name);
}

class PaymentInfoRouteArgs {
  const PaymentInfoRouteArgs({
    this.key,
    this.paymentId,
    this.payment,
  });

  final _i11.Key? key;

  final int? paymentId;

  final _i12.PaymentISC? payment;

  @override
  String toString() {
    return 'PaymentInfoRouteArgs{key: $key, paymentId: $paymentId, payment: $payment}';
  }
}

/// generated route for
/// [_i8.RegisterPaymentClaimScreen]
class RegisterPaymentClaimRoute
    extends _i10.PageRouteInfo<RegisterPaymentClaimRouteArgs> {
  RegisterPaymentClaimRoute({
    int? claimId,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          RegisterPaymentClaimRoute.name,
          args: RegisterPaymentClaimRouteArgs(
            claimId: claimId,
            key: key,
          ),
          rawPathParams: {'id': claimId},
          initialChildren: children,
        );

  static const String name = 'RegisterPaymentClaimRoute';

  static const _i10.PageInfo<RegisterPaymentClaimRouteArgs> page =
      _i10.PageInfo<RegisterPaymentClaimRouteArgs>(name);
}

class RegisterPaymentClaimRouteArgs {
  const RegisterPaymentClaimRouteArgs({
    this.claimId,
    this.key,
  });

  final int? claimId;

  final _i11.Key? key;

  @override
  String toString() {
    return 'RegisterPaymentClaimRouteArgs{claimId: $claimId, key: $key}';
  }
}

/// generated route for
/// [_i9.ClaimsScreen]
class ClaimsRoute extends _i10.PageRouteInfo<void> {
  const ClaimsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ClaimsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClaimsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
