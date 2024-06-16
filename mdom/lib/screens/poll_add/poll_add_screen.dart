import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/injection_component.dart';
import 'package:bpc/screens/poll_add/main_widgets/poll_add_screen_builder.dart';
import 'package:bpc/screens/poll_add/main_widgets/poll_add_web_screen_builder.dart';
import 'package:bpc/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


@RoutePage()
class PollAddScreen extends StatelessWidget {
  // static const pageRouteAdd = '/polls/add';
  static const pageRouteAdd = '${PollsListScreen.pageRoute}/:add';
  static const pageRouteEdit = '/polls/edit';

  final Poll? poll;

  const PollAddScreen({
    Key? key,
    required this.poll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<AddPollBloc>(
        create: (context) => AddPollBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
          poll: poll,
        ),
        child: kIsWeb
            ? PolAddWebScreenBuilder(poll: poll)
            : PolAddScreenBuilder(
                poll: poll,
              ),
      );
}
