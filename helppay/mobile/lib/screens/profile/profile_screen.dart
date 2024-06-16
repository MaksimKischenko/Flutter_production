import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';

import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'profile_screen');

class ProfileScreen extends StatefulWidget {
  static const pageRoute = '/profile';

  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController _hideBottomNavController;

  var _isVisible = true;

  // final _titleKey = GlobalKey();

  double get titleSize => 70;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      _hideBottomNavController.hasClients &&
      _hideBottomNavController.offset - titleSize > 0;

  @override
  void initState() {
    super.initState();
    _hideBottomNavController = ScrollController();
    _hideBottomNavController.addListener(
      () {
        if (_isTitleVisible != _showTitle) {
          setState(() {
            _isTitleVisible = !_isTitleVisible;
          });
        }
        if (_hideBottomNavController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_isVisible) {
            _isVisible = false;
            context.read<MenuBloc>().add(MenuHide());
          }
        }
        if (_hideBottomNavController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!_isVisible) {
            _isVisible = true;
            context.read<MenuBloc>().add(MenuShow());
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _hideBottomNavController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _log('screen height - ${MediaQuery.of(context).size.height}');

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogOutSuccess) {
          Navigation.toAuth();
        }
      },
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text(
            context.t.mobileScreens.profile.title,
            style: const TextStyle(color: AppStyles.mainColorDark),
          ),
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: [EditButton()],
        ),
        body: Padding(
          padding: MediaQuery.of(context).size.height < 740
              ? const EdgeInsets.symmetric(vertical: 35.0)
              : EdgeInsets.zero,
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: CustomScrollView(
              controller: _hideBottomNavController,
              slivers: <Widget>[
                // SliverPersistentHeader(
                //   floating: true,
                //   delegate: _SliverDelegate(
                //     minHeight: 0,
                //     maxHeight: 50,
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 14.0),
                //       child: Text(
                //         context.t.mobileScreens.profile.title,
                //         style: const TextStyle(
                //           color: Color(0xff383A51),
                //           fontSize: 32,
                //           fontWeight: FontWeight.w600,
                //           letterSpacing: -1.4,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    child: UserTitle(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: UserParams(),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
                SliverToBoxAdapter(
                  child: SettingsItem(),
                ),
                SliverToBoxAdapter(
                  child: LogOutItem(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      SizedBox.expand(child: child);

  @override
  bool shouldRebuild(_SliverDelegate oldDelegate) =>
      maxHeight != oldDelegate.maxHeight ||
      minHeight != oldDelegate.minHeight ||
      child != oldDelegate.child;
}
