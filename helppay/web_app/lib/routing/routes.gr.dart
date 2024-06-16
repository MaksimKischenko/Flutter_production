// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i30;
import 'package:flutter/cupertino.dart' as _i33;
import 'package:flutter/material.dart' as _i32;
import 'package:helppay_core/helppay_core.dart' as _i31;
import 'package:helppay_web_app/screens/account_info/account_info_screen.dart'
    as _i1;
import 'package:helppay_web_app/screens/account_info/edit_account_name_screen.dart'
    as _i6;
import 'package:helppay_web_app/screens/auth/auth_screen.dart' as _i3;
import 'package:helppay_web_app/screens/auth_change_password_screen/auth_change_password_screen.dart'
    as _i2;
import 'package:helppay_web_app/screens/card_info/card_info_screen.dart' as _i4;
import 'package:helppay_web_app/screens/card_info/edit_card_name_screen.dart'
    as _i7;
import 'package:helppay_web_app/screens/change_password/change_password_screen.dart'
    as _i5;
import 'package:helppay_web_app/screens/mdom_account_info/mdom_account_info_screen.dart'
    as _i9;
import 'package:helppay_web_app/screens/mdom_account_info_payments_screen/mdom_account_info_payments_screen.dart'
    as _i8;
import 'package:helppay_web_app/screens/mdom_accruals/mdom_accruals_screen.dart'
    as _i10;
import 'package:helppay_web_app/screens/mdom_notification_screen/mdom_notification_screen.dart'
    as _i11;
import 'package:helppay_web_app/screens/mdom_poll/mdom_poll_screen.dart'
    as _i12;
import 'package:helppay_web_app/screens/mdom_poll_statistics/mdom_poll_statistics_screen.dart'
    as _i14;
import 'package:helppay_web_app/screens/mdom_poll_statistics_question/mdom_poll_statistics_question_screen.dart'
    as _i13;
import 'package:helppay_web_app/screens/mdom_polls_list/mdom_polls_list_screen.dart'
    as _i16;
import 'package:helppay_web_app/screens/mdom_polls_list_filters/mdom_polls_list_filters_screen.dart'
    as _i15;
import 'package:helppay_web_app/screens/notification_method/select_notification_method_screen.dart'
    as _i28;
import 'package:helppay_web_app/screens/payments_history/payments_history_screen.dart'
    as _i18;
import 'package:helppay_web_app/screens/payments_history_filters/payments_history_filters_screen.dart'
    as _i17;
import 'package:helppay_web_app/screens/product_add/product_add_screen.dart'
    as _i19;
import 'package:helppay_web_app/screens/products/products_screen.dart' as _i20;
import 'package:helppay_web_app/screens/profile/profile_screen.dart' as _i22;
import 'package:helppay_web_app/screens/profile_edit/profile_edit_screen.dart'
    as _i21;
import 'package:helppay_web_app/screens/registration/registration_screen.dart'
    as _i25;
import 'package:helppay_web_app/screens/registration_code/registration_code_screen.dart'
    as _i23;
import 'package:helppay_web_app/screens/registration_params/registration_params_screen.dart'
    as _i24;
import 'package:helppay_web_app/screens/registration_success/registration_success_screen.dart'
    as _i26;
import 'package:helppay_web_app/screens/select_language/select_language_screen.dart'
    as _i27;
import 'package:helppay_web_app/screens/splash/splash_screen.dart' as _i29;

abstract class $Routes extends _i30.RootStackRouter {
  $Routes({super.navigatorKey});

  @override
  final Map<String, _i30.PageFactory> pagesMap = {
    AccountInfoRoute.name: (routeData) {
      final args = routeData.argsAs<AccountInfoRouteArgs>(
          orElse: () => const AccountInfoRouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AccountInfoScreen(account: args.account),
      );
    },
    AuthChangePasswordRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AuthChangePasswordScreen(),
      );
    },
    AuthRoute.name: (routeData) {
      final args =
          routeData.argsAs<AuthRouteArgs>(orElse: () => const AuthRouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.AuthScreen(
          next: args.next,
          key: args.key,
        ),
      );
    },
    CardInfoRoute.name: (routeData) {
      final args = routeData.argsAs<CardInfoRouteArgs>(
          orElse: () => const CardInfoRouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.CardInfoScreen(card: args.card),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ChangePasswordScreen(),
      );
    },
    EditAccountNameRoute.name: (routeData) {
      final args = routeData.argsAs<EditAccountNameRouteArgs>(
          orElse: () => const EditAccountNameRouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.EditAccountNameScreen(
          pan: args.pan,
          nameParam: args.nameParam,
        ),
      );
    },
    EditCardNameRoute.name: (routeData) {
      final args = routeData.argsAs<EditCardNameRouteArgs>(
          orElse: () => const EditCardNameRouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.EditCardNameScreen(
          pan: args.pan,
          nameParam: args.nameParam,
        ),
      );
    },
    MdomAccountInfoPaymentsRoute.name: (routeData) {
      final args = routeData.argsAs<MdomAccountInfoPaymentsRouteArgs>();
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.MdomAccountInfoPaymentsScreen(
          key: args.key,
          paymentsList: args.paymentsList,
        ),
      );
    },
    MdomAccountInfoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MdomAccountInfoRouteArgs>(
          orElse: () => MdomAccountInfoRouteArgs(
                supplierId: pathParams.optInt('id'),
                supplierTitle: pathParams.optString('title'),
              ));
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.MdomAccountInfoScreen(
          key: args.key,
          supplierId: args.supplierId,
          supplierTitle: args.supplierTitle,
          account: args.account,
        ),
      );
    },
    MdomAccrualsRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.MdomAccrualsScreen(),
      );
    },
    MdomNotificationsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MdomNotificationsRouteArgs>(
          orElse: () => MdomNotificationsRouteArgs(
                supplierId: pathParams.getInt('id'),
                supplierTitle: pathParams.optString('title'),
              ));
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.MdomNotificationsScreen(
          supplierId: args.supplierId,
          supplierTitle: args.supplierTitle,
        ),
      );
    },
    MdomPollRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MdomPollRouteArgs>(
          orElse: () => MdomPollRouteArgs(
                participantsCount: pathParams.optInt('count'),
                supplierTitle: pathParams.optString('title'),
              ));
      return _i30.AutoRoutePage<_i31.Poll>(
        routeData: routeData,
        child: _i12.MdomPollScreen(
          key: args.key,
          participantsCount: args.participantsCount,
          supplierTitle: args.supplierTitle,
          poll: args.poll,
        ),
      );
    },
    MdomPollStatisticsQuestionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MdomPollStatisticsQuestionRouteArgs>(
          orElse: () => MdomPollStatisticsQuestionRouteArgs(
              pollId: pathParams.optInt('id')));
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.MdomPollStatisticsQuestionScreen(
          key: args.key,
          pollId: args.pollId,
          question: args.question,
        ),
      );
    },
    MdomPollStatisticsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MdomPollStatisticsRouteArgs>(
          orElse: () => MdomPollStatisticsRouteArgs(
              participantsCount: pathParams.optInt('count')));
      return _i30.AutoRoutePage<_i31.Poll>(
        routeData: routeData,
        child: _i14.MdomPollStatisticsScreen(
          key: args.key,
          participantsCount: args.participantsCount,
          poll: args.poll,
        ),
      );
    },
    MdomPollsListFiltersRoute.name: (routeData) {
      final args = routeData.argsAs<MdomPollsListFiltersRouteArgs>();
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.MdomPollsListFiltersScreen(
          key: args.key,
          initialFilters: args.initialFilters,
        ),
      );
    },
    MdomPollsListRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MdomPollsListRouteArgs>(
          orElse: () => MdomPollsListRouteArgs(
                supplierId: pathParams.optInt('id'),
                accountsCount: pathParams.optInt('count'),
                supplierTitle: pathParams.optString('title'),
              ));
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.MdomPollsListScreen(
          supplierId: args.supplierId,
          accountsCount: args.accountsCount,
          supplierTitle: args.supplierTitle,
        ),
      );
    },
    PaymentsHistoryFiltersRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentsHistoryFiltersRouteArgs>();
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.PaymentsHistoryFiltersScreen(data: args.data),
      );
    },
    PaymentsHistoryRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.PaymentsHistoryScreen(),
      );
    },
    ProductAddRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.ProductAddScreen(),
      );
    },
    ProductsRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.ProductsScreen(),
      );
    },
    ProfileEditRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileEditRouteArgs>(
          orElse: () => const ProfileEditRouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.ProfileEditScreen(
          key: args.key,
          params: args.params,
          lookups: args.lookups,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.ProfileScreen(),
      );
    },
    RegistrationCodeRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationCodeRouteArgs>(
          orElse: () => const RegistrationCodeRouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.RegistrationCodeScreen(codeType: args.codeType),
      );
    },
    RegistrationParamsRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationParamsRouteArgs>(
          orElse: () => const RegistrationParamsRouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.RegistrationParamsScreen(
          params: args.params,
          lookups: args.lookups,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    RegistrationRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.RegistrationScreen(),
      );
    },
    RegistrationSuccessRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.RegistrationSuccessScreen(),
      );
    },
    SelectLanguageRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.SelectLanguageScreen(),
      );
    },
    SelectNotificationMethodRoute.name: (routeData) {
      final args = routeData.argsAs<SelectNotificationMethodRouteArgs>();
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.SelectNotificationMethodScreen(
          currentNotificationMethodName: args.currentNotificationMethodName,
          key: args.key,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AccountInfoScreen]
class AccountInfoRoute extends _i30.PageRouteInfo<AccountInfoRouteArgs> {
  AccountInfoRoute({
    _i31.MdomLoginResponseProductsCurrent? account,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          AccountInfoRoute.name,
          args: AccountInfoRouteArgs(account: account),
          initialChildren: children,
        );

  static const String name = 'AccountInfoRoute';

  static const _i30.PageInfo<AccountInfoRouteArgs> page =
      _i30.PageInfo<AccountInfoRouteArgs>(name);
}

class AccountInfoRouteArgs {
  const AccountInfoRouteArgs({this.account});

  final _i31.MdomLoginResponseProductsCurrent? account;

  @override
  String toString() {
    return 'AccountInfoRouteArgs{account: $account}';
  }
}

/// generated route for
/// [_i2.AuthChangePasswordScreen]
class AuthChangePasswordRoute extends _i30.PageRouteInfo<void> {
  const AuthChangePasswordRoute({List<_i30.PageRouteInfo>? children})
      : super(
          AuthChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthChangePasswordRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AuthScreen]
class AuthRoute extends _i30.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    String? next,
    _i32.Key? key,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          AuthRoute.name,
          args: AuthRouteArgs(
            next: next,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i30.PageInfo<AuthRouteArgs> page =
      _i30.PageInfo<AuthRouteArgs>(name);
}

class AuthRouteArgs {
  const AuthRouteArgs({
    this.next,
    this.key,
  });

  final String? next;

  final _i32.Key? key;

  @override
  String toString() {
    return 'AuthRouteArgs{next: $next, key: $key}';
  }
}

/// generated route for
/// [_i4.CardInfoScreen]
class CardInfoRoute extends _i30.PageRouteInfo<CardInfoRouteArgs> {
  CardInfoRoute({
    _i31.MdomLoginResponseProductsCurrent? card,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          CardInfoRoute.name,
          args: CardInfoRouteArgs(card: card),
          initialChildren: children,
        );

  static const String name = 'CardInfoRoute';

  static const _i30.PageInfo<CardInfoRouteArgs> page =
      _i30.PageInfo<CardInfoRouteArgs>(name);
}

class CardInfoRouteArgs {
  const CardInfoRouteArgs({this.card});

  final _i31.MdomLoginResponseProductsCurrent? card;

  @override
  String toString() {
    return 'CardInfoRouteArgs{card: $card}';
  }
}

/// generated route for
/// [_i5.ChangePasswordScreen]
class ChangePasswordRoute extends _i30.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i30.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i6.EditAccountNameScreen]
class EditAccountNameRoute
    extends _i30.PageRouteInfo<EditAccountNameRouteArgs> {
  EditAccountNameRoute({
    String? pan,
    _i31.MdomResponseParam? nameParam,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          EditAccountNameRoute.name,
          args: EditAccountNameRouteArgs(
            pan: pan,
            nameParam: nameParam,
          ),
          initialChildren: children,
        );

  static const String name = 'EditAccountNameRoute';

  static const _i30.PageInfo<EditAccountNameRouteArgs> page =
      _i30.PageInfo<EditAccountNameRouteArgs>(name);
}

class EditAccountNameRouteArgs {
  const EditAccountNameRouteArgs({
    this.pan,
    this.nameParam,
  });

  final String? pan;

  final _i31.MdomResponseParam? nameParam;

  @override
  String toString() {
    return 'EditAccountNameRouteArgs{pan: $pan, nameParam: $nameParam}';
  }
}

/// generated route for
/// [_i7.EditCardNameScreen]
class EditCardNameRoute extends _i30.PageRouteInfo<EditCardNameRouteArgs> {
  EditCardNameRoute({
    String? pan,
    _i31.MdomResponseParam? nameParam,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          EditCardNameRoute.name,
          args: EditCardNameRouteArgs(
            pan: pan,
            nameParam: nameParam,
          ),
          initialChildren: children,
        );

  static const String name = 'EditCardNameRoute';

  static const _i30.PageInfo<EditCardNameRouteArgs> page =
      _i30.PageInfo<EditCardNameRouteArgs>(name);
}

class EditCardNameRouteArgs {
  const EditCardNameRouteArgs({
    this.pan,
    this.nameParam,
  });

  final String? pan;

  final _i31.MdomResponseParam? nameParam;

  @override
  String toString() {
    return 'EditCardNameRouteArgs{pan: $pan, nameParam: $nameParam}';
  }
}

/// generated route for
/// [_i8.MdomAccountInfoPaymentsScreen]
class MdomAccountInfoPaymentsRoute
    extends _i30.PageRouteInfo<MdomAccountInfoPaymentsRouteArgs> {
  MdomAccountInfoPaymentsRoute({
    _i32.Key? key,
    required List<_i31.PaymentBilling> paymentsList,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          MdomAccountInfoPaymentsRoute.name,
          args: MdomAccountInfoPaymentsRouteArgs(
            key: key,
            paymentsList: paymentsList,
          ),
          initialChildren: children,
        );

  static const String name = 'MdomAccountInfoPaymentsRoute';

  static const _i30.PageInfo<MdomAccountInfoPaymentsRouteArgs> page =
      _i30.PageInfo<MdomAccountInfoPaymentsRouteArgs>(name);
}

class MdomAccountInfoPaymentsRouteArgs {
  const MdomAccountInfoPaymentsRouteArgs({
    this.key,
    required this.paymentsList,
  });

  final _i32.Key? key;

  final List<_i31.PaymentBilling> paymentsList;

  @override
  String toString() {
    return 'MdomAccountInfoPaymentsRouteArgs{key: $key, paymentsList: $paymentsList}';
  }
}

/// generated route for
/// [_i9.MdomAccountInfoScreen]
class MdomAccountInfoRoute
    extends _i30.PageRouteInfo<MdomAccountInfoRouteArgs> {
  MdomAccountInfoRoute({
    _i33.Key? key,
    int? supplierId,
    String? supplierTitle,
    _i31.PropertyAccount? account,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          MdomAccountInfoRoute.name,
          args: MdomAccountInfoRouteArgs(
            key: key,
            supplierId: supplierId,
            supplierTitle: supplierTitle,
            account: account,
          ),
          rawPathParams: {
            'id': supplierId,
            'title': supplierTitle,
          },
          initialChildren: children,
        );

  static const String name = 'MdomAccountInfoRoute';

  static const _i30.PageInfo<MdomAccountInfoRouteArgs> page =
      _i30.PageInfo<MdomAccountInfoRouteArgs>(name);
}

class MdomAccountInfoRouteArgs {
  const MdomAccountInfoRouteArgs({
    this.key,
    this.supplierId,
    this.supplierTitle,
    this.account,
  });

  final _i33.Key? key;

  final int? supplierId;

  final String? supplierTitle;

  final _i31.PropertyAccount? account;

  @override
  String toString() {
    return 'MdomAccountInfoRouteArgs{key: $key, supplierId: $supplierId, supplierTitle: $supplierTitle, account: $account}';
  }
}

/// generated route for
/// [_i10.MdomAccrualsScreen]
class MdomAccrualsRoute extends _i30.PageRouteInfo<void> {
  const MdomAccrualsRoute({List<_i30.PageRouteInfo>? children})
      : super(
          MdomAccrualsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MdomAccrualsRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i11.MdomNotificationsScreen]
class MdomNotificationsRoute
    extends _i30.PageRouteInfo<MdomNotificationsRouteArgs> {
  MdomNotificationsRoute({
    required int supplierId,
    required String? supplierTitle,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          MdomNotificationsRoute.name,
          args: MdomNotificationsRouteArgs(
            supplierId: supplierId,
            supplierTitle: supplierTitle,
          ),
          rawPathParams: {
            'id': supplierId,
            'title': supplierTitle,
          },
          initialChildren: children,
        );

  static const String name = 'MdomNotificationsRoute';

  static const _i30.PageInfo<MdomNotificationsRouteArgs> page =
      _i30.PageInfo<MdomNotificationsRouteArgs>(name);
}

class MdomNotificationsRouteArgs {
  const MdomNotificationsRouteArgs({
    required this.supplierId,
    required this.supplierTitle,
  });

  final int supplierId;

  final String? supplierTitle;

  @override
  String toString() {
    return 'MdomNotificationsRouteArgs{supplierId: $supplierId, supplierTitle: $supplierTitle}';
  }
}

/// generated route for
/// [_i12.MdomPollScreen]
class MdomPollRoute extends _i30.PageRouteInfo<MdomPollRouteArgs> {
  MdomPollRoute({
    _i32.Key? key,
    int? participantsCount,
    String? supplierTitle,
    _i31.Poll? poll,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          MdomPollRoute.name,
          args: MdomPollRouteArgs(
            key: key,
            participantsCount: participantsCount,
            supplierTitle: supplierTitle,
            poll: poll,
          ),
          rawPathParams: {
            'count': participantsCount,
            'title': supplierTitle,
          },
          initialChildren: children,
        );

  static const String name = 'MdomPollRoute';

  static const _i30.PageInfo<MdomPollRouteArgs> page =
      _i30.PageInfo<MdomPollRouteArgs>(name);
}

class MdomPollRouteArgs {
  const MdomPollRouteArgs({
    this.key,
    this.participantsCount,
    this.supplierTitle,
    this.poll,
  });

  final _i32.Key? key;

  final int? participantsCount;

  final String? supplierTitle;

  final _i31.Poll? poll;

  @override
  String toString() {
    return 'MdomPollRouteArgs{key: $key, participantsCount: $participantsCount, supplierTitle: $supplierTitle, poll: $poll}';
  }
}

/// generated route for
/// [_i13.MdomPollStatisticsQuestionScreen]
class MdomPollStatisticsQuestionRoute
    extends _i30.PageRouteInfo<MdomPollStatisticsQuestionRouteArgs> {
  MdomPollStatisticsQuestionRoute({
    _i32.Key? key,
    int? pollId,
    _i31.PollListQuestion? question,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          MdomPollStatisticsQuestionRoute.name,
          args: MdomPollStatisticsQuestionRouteArgs(
            key: key,
            pollId: pollId,
            question: question,
          ),
          rawPathParams: {'id': pollId},
          initialChildren: children,
        );

  static const String name = 'MdomPollStatisticsQuestionRoute';

  static const _i30.PageInfo<MdomPollStatisticsQuestionRouteArgs> page =
      _i30.PageInfo<MdomPollStatisticsQuestionRouteArgs>(name);
}

class MdomPollStatisticsQuestionRouteArgs {
  const MdomPollStatisticsQuestionRouteArgs({
    this.key,
    this.pollId,
    this.question,
  });

  final _i32.Key? key;

  final int? pollId;

  final _i31.PollListQuestion? question;

  @override
  String toString() {
    return 'MdomPollStatisticsQuestionRouteArgs{key: $key, pollId: $pollId, question: $question}';
  }
}

/// generated route for
/// [_i14.MdomPollStatisticsScreen]
class MdomPollStatisticsRoute
    extends _i30.PageRouteInfo<MdomPollStatisticsRouteArgs> {
  MdomPollStatisticsRoute({
    _i32.Key? key,
    int? participantsCount,
    _i31.Poll? poll,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          MdomPollStatisticsRoute.name,
          args: MdomPollStatisticsRouteArgs(
            key: key,
            participantsCount: participantsCount,
            poll: poll,
          ),
          rawPathParams: {'count': participantsCount},
          initialChildren: children,
        );

  static const String name = 'MdomPollStatisticsRoute';

  static const _i30.PageInfo<MdomPollStatisticsRouteArgs> page =
      _i30.PageInfo<MdomPollStatisticsRouteArgs>(name);
}

class MdomPollStatisticsRouteArgs {
  const MdomPollStatisticsRouteArgs({
    this.key,
    this.participantsCount,
    this.poll,
  });

  final _i32.Key? key;

  final int? participantsCount;

  final _i31.Poll? poll;

  @override
  String toString() {
    return 'MdomPollStatisticsRouteArgs{key: $key, participantsCount: $participantsCount, poll: $poll}';
  }
}

/// generated route for
/// [_i15.MdomPollsListFiltersScreen]
class MdomPollsListFiltersRoute
    extends _i30.PageRouteInfo<MdomPollsListFiltersRouteArgs> {
  MdomPollsListFiltersRoute({
    _i32.Key? key,
    required _i31.PollsListFiltersData initialFilters,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          MdomPollsListFiltersRoute.name,
          args: MdomPollsListFiltersRouteArgs(
            key: key,
            initialFilters: initialFilters,
          ),
          initialChildren: children,
        );

  static const String name = 'MdomPollsListFiltersRoute';

  static const _i30.PageInfo<MdomPollsListFiltersRouteArgs> page =
      _i30.PageInfo<MdomPollsListFiltersRouteArgs>(name);
}

class MdomPollsListFiltersRouteArgs {
  const MdomPollsListFiltersRouteArgs({
    this.key,
    required this.initialFilters,
  });

  final _i32.Key? key;

  final _i31.PollsListFiltersData initialFilters;

  @override
  String toString() {
    return 'MdomPollsListFiltersRouteArgs{key: $key, initialFilters: $initialFilters}';
  }
}

/// generated route for
/// [_i16.MdomPollsListScreen]
class MdomPollsListRoute extends _i30.PageRouteInfo<MdomPollsListRouteArgs> {
  MdomPollsListRoute({
    int? supplierId,
    int? accountsCount,
    String? supplierTitle,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          MdomPollsListRoute.name,
          args: MdomPollsListRouteArgs(
            supplierId: supplierId,
            accountsCount: accountsCount,
            supplierTitle: supplierTitle,
          ),
          rawPathParams: {
            'id': supplierId,
            'count': accountsCount,
            'title': supplierTitle,
          },
          initialChildren: children,
        );

  static const String name = 'MdomPollsListRoute';

  static const _i30.PageInfo<MdomPollsListRouteArgs> page =
      _i30.PageInfo<MdomPollsListRouteArgs>(name);
}

class MdomPollsListRouteArgs {
  const MdomPollsListRouteArgs({
    this.supplierId,
    this.accountsCount,
    this.supplierTitle,
  });

  final int? supplierId;

  final int? accountsCount;

  final String? supplierTitle;

  @override
  String toString() {
    return 'MdomPollsListRouteArgs{supplierId: $supplierId, accountsCount: $accountsCount, supplierTitle: $supplierTitle}';
  }
}

/// generated route for
/// [_i17.PaymentsHistoryFiltersScreen]
class PaymentsHistoryFiltersRoute
    extends _i30.PageRouteInfo<PaymentsHistoryFiltersRouteArgs> {
  PaymentsHistoryFiltersRoute({
    required _i31.PaymentsHistoryFiltersScreenArgs? data,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          PaymentsHistoryFiltersRoute.name,
          args: PaymentsHistoryFiltersRouteArgs(data: data),
          initialChildren: children,
        );

  static const String name = 'PaymentsHistoryFiltersRoute';

  static const _i30.PageInfo<PaymentsHistoryFiltersRouteArgs> page =
      _i30.PageInfo<PaymentsHistoryFiltersRouteArgs>(name);
}

class PaymentsHistoryFiltersRouteArgs {
  const PaymentsHistoryFiltersRouteArgs({required this.data});

  final _i31.PaymentsHistoryFiltersScreenArgs? data;

  @override
  String toString() {
    return 'PaymentsHistoryFiltersRouteArgs{data: $data}';
  }
}

/// generated route for
/// [_i18.PaymentsHistoryScreen]
class PaymentsHistoryRoute extends _i30.PageRouteInfo<void> {
  const PaymentsHistoryRoute({List<_i30.PageRouteInfo>? children})
      : super(
          PaymentsHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentsHistoryRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i19.ProductAddScreen]
class ProductAddRoute extends _i30.PageRouteInfo<void> {
  const ProductAddRoute({List<_i30.PageRouteInfo>? children})
      : super(
          ProductAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductAddRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i20.ProductsScreen]
class ProductsRoute extends _i30.PageRouteInfo<void> {
  const ProductsRoute({List<_i30.PageRouteInfo>? children})
      : super(
          ProductsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i21.ProfileEditScreen]
class ProfileEditRoute extends _i30.PageRouteInfo<ProfileEditRouteArgs> {
  ProfileEditRoute({
    _i32.Key? key,
    List<_i31.MdomResponseParam>? params,
    _i31.MdomLookup? lookups,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          ProfileEditRoute.name,
          args: ProfileEditRouteArgs(
            key: key,
            params: params,
            lookups: lookups,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileEditRoute';

  static const _i30.PageInfo<ProfileEditRouteArgs> page =
      _i30.PageInfo<ProfileEditRouteArgs>(name);
}

class ProfileEditRouteArgs {
  const ProfileEditRouteArgs({
    this.key,
    this.params,
    this.lookups,
  });

  final _i32.Key? key;

  final List<_i31.MdomResponseParam>? params;

  final _i31.MdomLookup? lookups;

  @override
  String toString() {
    return 'ProfileEditRouteArgs{key: $key, params: $params, lookups: $lookups}';
  }
}

/// generated route for
/// [_i22.ProfileScreen]
class ProfileRoute extends _i30.PageRouteInfo<void> {
  const ProfileRoute({List<_i30.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i23.RegistrationCodeScreen]
class RegistrationCodeRoute
    extends _i30.PageRouteInfo<RegistrationCodeRouteArgs> {
  RegistrationCodeRoute({
    _i31.ConfirmCodeType? codeType,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          RegistrationCodeRoute.name,
          args: RegistrationCodeRouteArgs(codeType: codeType),
          initialChildren: children,
        );

  static const String name = 'RegistrationCodeRoute';

  static const _i30.PageInfo<RegistrationCodeRouteArgs> page =
      _i30.PageInfo<RegistrationCodeRouteArgs>(name);
}

class RegistrationCodeRouteArgs {
  const RegistrationCodeRouteArgs({this.codeType});

  final _i31.ConfirmCodeType? codeType;

  @override
  String toString() {
    return 'RegistrationCodeRouteArgs{codeType: $codeType}';
  }
}

/// generated route for
/// [_i24.RegistrationParamsScreen]
class RegistrationParamsRoute
    extends _i30.PageRouteInfo<RegistrationParamsRouteArgs> {
  RegistrationParamsRoute({
    List<_i31.MdomResponseParam>? params,
    List<_i31.MdomLookupItem>? lookups,
    String? phoneNumber,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          RegistrationParamsRoute.name,
          args: RegistrationParamsRouteArgs(
            params: params,
            lookups: lookups,
            phoneNumber: phoneNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'RegistrationParamsRoute';

  static const _i30.PageInfo<RegistrationParamsRouteArgs> page =
      _i30.PageInfo<RegistrationParamsRouteArgs>(name);
}

class RegistrationParamsRouteArgs {
  const RegistrationParamsRouteArgs({
    this.params,
    this.lookups,
    this.phoneNumber,
  });

  final List<_i31.MdomResponseParam>? params;

  final List<_i31.MdomLookupItem>? lookups;

  final String? phoneNumber;

  @override
  String toString() {
    return 'RegistrationParamsRouteArgs{params: $params, lookups: $lookups, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i25.RegistrationScreen]
class RegistrationRoute extends _i30.PageRouteInfo<void> {
  const RegistrationRoute({List<_i30.PageRouteInfo>? children})
      : super(
          RegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i26.RegistrationSuccessScreen]
class RegistrationSuccessRoute extends _i30.PageRouteInfo<void> {
  const RegistrationSuccessRoute({List<_i30.PageRouteInfo>? children})
      : super(
          RegistrationSuccessRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationSuccessRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i27.SelectLanguageScreen]
class SelectLanguageRoute extends _i30.PageRouteInfo<void> {
  const SelectLanguageRoute({List<_i30.PageRouteInfo>? children})
      : super(
          SelectLanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectLanguageRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i28.SelectNotificationMethodScreen]
class SelectNotificationMethodRoute
    extends _i30.PageRouteInfo<SelectNotificationMethodRouteArgs> {
  SelectNotificationMethodRoute({
    required String currentNotificationMethodName,
    _i32.Key? key,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          SelectNotificationMethodRoute.name,
          args: SelectNotificationMethodRouteArgs(
            currentNotificationMethodName: currentNotificationMethodName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectNotificationMethodRoute';

  static const _i30.PageInfo<SelectNotificationMethodRouteArgs> page =
      _i30.PageInfo<SelectNotificationMethodRouteArgs>(name);
}

class SelectNotificationMethodRouteArgs {
  const SelectNotificationMethodRouteArgs({
    required this.currentNotificationMethodName,
    this.key,
  });

  final String currentNotificationMethodName;

  final _i32.Key? key;

  @override
  String toString() {
    return 'SelectNotificationMethodRouteArgs{currentNotificationMethodName: $currentNotificationMethodName, key: $key}';
  }
}

/// generated route for
/// [_i29.SplashScreen]
class SplashRoute extends _i30.PageRouteInfo<void> {
  const SplashRoute({List<_i30.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}
