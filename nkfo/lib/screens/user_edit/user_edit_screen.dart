import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

import 'widgets/widgets.dart';

// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'edit_screen_form_fields');

class UserEditScreen extends StatefulWidget {
  static const pageName = 'Редактирование пользователя';

  @override
  _UserEditScreenState createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  User? _user;
  final _userUpdate = UserUpdateRequest();
  late bool isSaveAvailable = false;
  late List<int> listOFSelectedItemIds;
  double width = 800;

  @override
  void initState() {
    super.initState();
    isSaveAvailable = false;
    listOFSelectedItemIds = [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CommonAppBar(
                title: 'Редактирование пользователя',
              ),
              const Divider(),
              Expanded(
                child: BlocConsumer<UserUpdateBloc, UserUpdateState>(
                  listener: (context, state) {
                    if (state is UserUpdateInitial) {
                      _user = state.user;

                      _userUpdate.blocked = state.user.blocked;

                      _nameController.text = state.user.name ?? '';
                      _emailController.text = state.user.email ?? '';
                      _phoneController.text = state.user.phoneNumber ?? '';
                    } else if (state is UserUpdateSuccess) {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop<User>(state.user);
                      } else {
                        Navigation.toOrganizations();
                      }
                      Multiplatform.showMessage(
                          context: context,
                          title: 'Успешно',
                          message: 'Пользователь отредактирован',
                          type: DialogType.success);
                    } else if (state is UserUpdateError) {
                      RequestUtil.catchNetworkError(
                          context: context, obj: state.error);
                    }
                  },
                  buildWhen: (prev, next) {
                    if (next is UserUpdateInitial) return true;
                    if (next is UserUpdateInitLoading) return true;
                    if (next is UserUpdateInitError) return true;
                    return false;
                  },
                  builder: (context, state) {
                    Widget body = Container();
                    if (state is UserUpdateInitError) {
                      body = const UserEditErrorWidget();
                    } else if (state is UserUpdateInitLoading) {
                      body = const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: double.maxFinite),
                          LoadingIndicator()
                        ],
                      );
                    } else if (state is UserUpdateInitial) {
                      listOFSelectedItemIds = state.selectedRoles ?? [];
                      body = SingleChildScrollView(
                        child: Center(
                          child: ResponsiveBuilder(
                            builder: (context, sizingInformation) {
                              if (sizingInformation.isMobile ||
                                  sizingInformation.isTablet) {
                                width = sizingInformation.screenSize.width;
                              }
                              return SizedBox(
                                width: width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 32,
                                  ),
                                  child: EditScreenFormField(
                                    user: _user,
                                    userUpdate: _userUpdate,
                                    nameController: _nameController,
                                    emailController: _emailController,
                                    phoneController: _phoneController,
                                    formKey: _formKey,
                                    state: state,
                                    enableSave: (bool enableSave) {
                                      setState(() {
                                        isSaveAvailable = enableSave;
                                      });
                                    },
                                    listOfSelectedItemIds:
                                        listOFSelectedItemIds,
                                    comparisonList: state.comparisonList ?? [],
                                    changeRole: (List<int> listOfIds) {
                                      setState(() {
                                        listOFSelectedItemIds = listOfIds;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                    return body;
                  },
                ),
              ),
              const Divider(),
              UserEditScreenActionButtons(
                emailController: _emailController,
                phoneController: _phoneController,
                formKey: _formKey,
                isSaveAvailable: isSaveAvailable,
                user: _user,
                userUpdate: _userUpdate,
                listOFSelectedItemIds: listOFSelectedItemIds,
              ),
            ],
          ),
        ),
      );
}
