import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/screens/profile/main_widgets/profile_screen_body.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/loger.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'auth_mdom_bloc');

@RoutePage()
class ProfileScreen extends StatefulWidget {
  static const pageRoute = '/profile';

  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late ScrollController scrollController;

  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    context.read<InfoBloc>().add(InfoInit());
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<InfoBloc, InfoState>(
        builder: (context, state) {
          Widget body = Container();
          PreferredSizeWidget? appBarBottom;
          if (state is InfoLoading) {
            body = Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(width: double.maxFinite),
                LoadingIndicator()
              ],
            );
          } else if (state is InfoLoaded) {
            var tabCount = 1;
            if (state.contactsList.isNotEmpty) tabCount += 1;
            if (state.servicesList.isNotEmpty) tabCount += 1;

            _tabController = TabController(length: tabCount, vsync: this);

            if (tabCount > 1) {
              appBarBottom = TabBar(
                controller: _tabController,
                tabs: [
                  const Tab(text: 'Информация'),
                  if (state.contactsList.isNotEmpty)
                    const Tab(text: 'Контакты'),
                  if (state.servicesList.isNotEmpty) const Tab(text: 'Услуги')
                ],
                indicatorColor: AppStyles.mainColor,
              );
            }

            body = ProfileScreenBody(
              state: state,
              scrollController: scrollController,
              tabController: _tabController,
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Профиль'),
              bottom: appBarBottom,
            ),
            body: body,
          );
        },
      );
}
