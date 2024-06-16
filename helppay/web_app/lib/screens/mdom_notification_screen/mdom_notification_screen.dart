
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/injection_component.dart';
import 'package:helppay_web_app/screens/mdom_notification_screen/main_widgets/mdom_notifications_screen_body.dart';

@RoutePage()
class MdomNotificationsScreen extends StatelessWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/notifications');

  static const pageRoute = '/notifications';
  final int supplierId;
  final String? supplierTitle;

  const MdomNotificationsScreen({
    @PathParam('id') required this.supplierId,
    @PathParam('title') required this.supplierTitle,
  });

  @override
  Widget build(BuildContext context) => BlocProvider<MdomNotificationsBloc>(
        create: (context) => MdomNotificationsBloc(
            dataManager: InjectionComponent.getDependency<DataManager>(),
            supplierId: supplierId),
        child: MdomNotificationsScreenBody(
          supplierTitle: !supplierTitle!.contains('%')
              ? supplierTitle ?? ''
              : Uri.decodeComponent(supplierTitle ?? ''),
          supplierId: supplierId,
        ),
      );
}
