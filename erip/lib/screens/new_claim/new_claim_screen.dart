import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'widgets/widgets.dart';

class NewClaimScreen extends StatefulWidget {
  final ClaimsBloc bloc;
  final Service? initialService;
  final List<Service> servicesList;
  final ScrollController? scrollController;

  const NewClaimScreen({
    required this.bloc,
    required this.initialService,
    required this.servicesList,
    required this.scrollController
  });

  @override
  _NewClaimScreenState createState() => _NewClaimScreenState();
}

class _NewClaimScreenState extends State<NewClaimScreen> {
  final _newClaimFormKey = GlobalKey<FormState>();

  NewClaimData data = NewClaimData();

  //temp
  late DateTime _dueDate;
  bool isSmsNotificationChecked = false;
  bool isEmailNotificationChecked = false;
  List<Device> _devices = [];

  final _serviceController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _dueTimeController = TextEditingController();

  final _nodeAccNum = FocusNode();
  final _nodeSum = FocusNode();
  final _nodeDescription = FocusNode();
  final _nodeFirstName = FocusNode();
  final _nodeLastName = FocusNode();
  final _nodePatronymic = FocusNode();
  final _nodeAddress = FocusNode();
  final _nodeEmail = FocusNode();


  @override
  void initState() {
    super.initState();

    if (widget.initialService != null) {
      _serviceController.text = widget.initialService!.name;
      data.selectedService = widget.initialService;
    }

    final _now = DateTime.now();
    _dueDate = DateTime(_now.year, _now.month, _now.day, 23, 59, 59);
    _dueTimeController.text = _dueDate.toStringOnlyTime();
  }

  @override
  void dispose() {
    _serviceController.dispose();
    _dueDateController.dispose();
    _dueTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DismissOutside(
    child: BlocListener<ClaimsBloc, ClaimsState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is ClaimsSuccessCreate) {
          _onClaimsSuccessCreate(state.qrUrl);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Новое требование'),
            actions: [
              CreateClaimButton(
                bloc: widget.bloc,
                onPressed: () {
                  if (_newClaimFormKey.currentState?.validate() ?? false) {
                    _newClaimFormKey.currentState?.save();
                    if (isSmsNotificationChecked && isEmailNotificationChecked) {
                      data.typeNotification = 3;
                    } else {
                      if (!isSmsNotificationChecked && !isEmailNotificationChecked) {
                        data.typeNotification = 0;
                      } else {
                        data.typeNotification = isSmsNotificationChecked ? 2 : 1;
                      }
                    }
                    data.devices = _devices;
                    widget.bloc.add(ClaimsNewClaim(data));
                  }
                },
              )
            ],
          ),
          body: Scrollbar(
            child: KeyboardActions(
              config: _buildConfig(context),
              disableScroll: true,
              // tapOutsideToDismiss: true,
              // overscroll: 32,
              // autoScroll: false,
              child: FullScreen(
                topSafe: false,
                bottomSafe: false,
                controller: widget.scrollController,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Form(
                    key: _newClaimFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CategoryTitle('Атрибуты платежа'),
                        const SizedBox(height: 16),
                        ServiceField(
                          controller: _serviceController,
                          onTap: _showServicesDropDown,
                        ),
                        const SizedBox(height: 16),
                        if ((data.selectedService?.needGenerateAccNum ?? 0) == 0)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AccNumField(
                            focusNode: _nodeAccNum,
                            onSaved: (value) {
                              data.accNum = value;
                            },
                          ),
                        ),
                        SumField(
                          focusNode: _nodeSum,
                          validator: (value) {
                            if (data.selectedService?.claimSumMax != null && ((data.selectedService?.claimSumMax ?? 0.0) > 0.0)) {
                              final maxSum = data.selectedService!.claimSumMax!;
                              if (value > maxSum) return 'Максимальная сумма $maxSum';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            data.sum = value;
                          },
                        ),
                        const SizedBox(height: 16),
                        DueDateField(
                          controller: _dueDateController,
                          onTap: _showDueDatePicker,
                          onSaved: (value) {
                            data.dueDate = _dueDate;
                          },
                        ),
                        const SizedBox(height: 16),
                        DueTimeField(
                          controller: _dueTimeController,
                          onTap: _showDueTimePicker,
                          onSaved: (value) {
                            // data.dueDate = _dueDate;
                          },
                        ),
                        const SizedBox(height: 16),
                        DescriptionField(
                          focusNode: _nodeDescription,
                          onSaved: (value) {
                            data.description = value;
                          },
                        ),
                        const SizedBox(height: 40),
                        const CategoryTitle('Плательщик'),
                        const SizedBox(height: 16),
                        LastNameField(
                          focusNode: _nodeLastName,
                          onSaved: (value) {
                            data.surname = value;
                          },
                        ),
                        const SizedBox(height: 16),
                        FirstNameField(
                          focusNode: _nodeFirstName,
                          onSaved: (value) {
                            data.firstName = value;
                          },
                        ),
                        const SizedBox(height: 16),
                        PatronymicField(
                          focusNode: _nodePatronymic,
                          onSaved: (value) {
                            data.patronic = value;
                          },
                        ),
                        const SizedBox(height: 16),
                        AddressField(
                          focusNode: _nodeAddress,
                          onSaved: (value) {
                            data.address = value;
                          },
                        ),
                        const SizedBox(height: 40),
                        const CategoryTitle('Уведомления'),
                        const SizedBox(height: 16),
                        // PhoneCheckBox(
                        //   value: isSmsNotificationChecked,
                        //   onTap: (it) {
                        //     setState(() {
                        //       isSmsNotificationChecked = it;
                        //     });
                        //     if (isSmsNotificationChecked) { phoneFocus.requestFocus(); }
                        //   },
                        // ),
                        // if (isSmsNotificationChecked)
                        // Padding(
                        //   padding: EdgeInsets.only(bottom: 8),
                        //   child: PhoneField(
                        //     focusNode: phoneFocus,
                        //     validator: (value) {
                        //       if (isSmsNotificationChecked && value.length == 0) {
                        //         return "Введите номер";
                        //       }
                        //       return null;
                        //     },
                        //     onSaved: (value) {
                        //       if (isSmsNotificationChecked) {
                        //         data.phone = value;
                        //       }
                        //     },
                        //   ),
                        // ),
                        // SizedBox(height: 8),
                        EmailCheckBox(
                          value: isEmailNotificationChecked,
                          onTap: (it) {
                            setState(() {
                              isEmailNotificationChecked = it;
                            });
                            if (isEmailNotificationChecked) { _nodeEmail.requestFocus(); }
                          },
                        ),
                        if (isEmailNotificationChecked)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: EmailField(
                            focusNode: _nodeEmail,
                            validator: (email) {
                              if (isEmailNotificationChecked && email.isEmpty) {
                                return 'Введите E-mail';
                              }
                              if (!EmailValidator.validate(email)) {
                                return 'Неверный формат E-mail';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (isEmailNotificationChecked) {
                                data.email = value;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  KeyboardActionsConfig _buildConfig(BuildContext context) => AppStyles.keyboardConfig(
    context,
    actions: [
      KeyboardActionsItem(
        focusNode: _nodeAccNum,
        displayDoneButton: false,
        displayActionBar: false
      ),
      KeyboardActionsItem(
        focusNode: _nodeSum,
        displayArrows: false,
        toolbarButtons: [AppStyles.doneButton]
      ),
      KeyboardActionsItem(
        focusNode: _nodeDescription,
        displayDoneButton: false,
        displayActionBar: false
      ),
      KeyboardActionsItem(
        focusNode: _nodeLastName,
        displayDoneButton: false,
        displayActionBar: false
      ),
      KeyboardActionsItem(
        focusNode: _nodeFirstName,
        displayDoneButton: false,
        displayActionBar: false
      ),
      KeyboardActionsItem(
        focusNode: _nodePatronymic,
        displayDoneButton: false,
        displayActionBar: false
      ),
      KeyboardActionsItem(
        focusNode: _nodeAddress,
        displayDoneButton: false,
        displayActionBar: false
      ),
      // KeyboardActionsItem(
      //   focusNode: _nodePhone,
      //   displayDoneButton: false,
      // ),
    ]
  );

  // ignore: avoid_void_async
  void _showServicesDropDown() async {
    final value = await Multiplatform.showDropDown(
      context: context,
      list: widget.servicesList,
      visibleList: widget.servicesList.map((item) => item.name).toList(),
      selected: data.selectedService,
      title: 'Услуга'
    );

    if (value != null) {
      _serviceController.text = value.name;
      data.selectedService = value;
      _devices = [];
      setState(() {});
    }
  }

  // ignore: avoid_void_async
  void _showDueDatePicker() async {
    final _temp = DateTime.now();
    final now = DateTime(_temp.year, _temp.month, _temp.day);
    final pickedDate = await Multiplatform.showdatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 20000))
    );
    if (pickedDate != null) {
      _dueDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, _dueDate.hour, _dueDate.minute, _dueDate.second);
      _dueDateController.text = _dueDate.toStringFormatted();
    }
  }

  // ignore: avoid_void_async
  void _showDueTimePicker() async {
    final pickedDate = await Multiplatform.showTimePicker(
      context: context,
      initialTime: _dueDate
    );
    if (pickedDate != null) {
      _dueDate = DateTime(_dueDate.year, _dueDate.month, _dueDate.day, pickedDate.hour, pickedDate.minute, 59);
      _dueTimeController.text = _dueDate.toStringOnlyTime();
    }
  }

  // ignore: avoid_void_async
  // void _onAddDeviceTap() async {
  //   final value = await Multiplatform.showScrollableDialog<Device>(
  //     // context: context,
  //     context: Navigation.navigatorKey.currentState!.context,
  //     builder: (context, scrollController) => AddDeviceScreen(
  //       itemUnit: data.selectedService.itemUnit,
  //     )
  //   );
  //   if (value != null) {
  //     setState(() {
  //       _devices.add(value);
  //     });
  //   }
  // }

  // ignore: avoid_void_async
  // void _onEditDeviceTap({
  //   required int index,
  //   required Device device
  // }) async {
  //   final value = await Multiplatform.showScrollableDialog<Device>(
  //     // context: context,
  //     context: Navigation.navigatorKey.currentState!.context,
  //     builder: (context, scrollController) => AddDeviceScreen(
  //       device: device,
  //       itemUnit: data.selectedService.itemUnit,
  //     )
  //   );
  //   if (value != null) {
  //     setState(() {
  //       _devices[index] = value;
  //     });
  //   }
  // }

  void _onClaimsSuccessCreate(String qrUrl) {
    Navigator.of(context).pop();
    final qr = SizedBox(
      width: 150,
      height: 150,
      child: qrUrl.isNotEmpty
          ? QrImageView(
            data: qrUrl,
            version: QrVersions.auto,
            size: 150,
          )
          : Container()
    );
    Multiplatform.showMessageWithContent(
      context: context,
      title: 'Требование создано!',
      message: '',
      content: qr,
      type: DialogType.success
    );
  }
}