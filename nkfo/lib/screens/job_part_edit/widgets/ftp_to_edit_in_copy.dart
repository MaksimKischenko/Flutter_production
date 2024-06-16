import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

// ignore: must_be_immutable
class FtpToEditInCopyFile extends StatefulWidget {

  final JobPartUpdateRequest request;
  final JobPart? jobPart;

  ProxyTypeStatus? selectedProxyStatus;

  final TextEditingController ftpHostControllerN;
  final TextEditingController ftpPortControllerN;
  final TextEditingController ftpLoginControllerN;
  final TextEditingController ftpPasswordControllerN;

  final TextEditingController proxyHostControllerN;
  final TextEditingController proxyPortControllerN;
  final TextEditingController proxyLoginControllerN;
  final TextEditingController proxyPasswordControllerN;

  FtpToEditInCopyFile({
    required this.request,
    required this.jobPart,
    required this.selectedProxyStatus,
    required this.ftpHostControllerN,
    required this.ftpPortControllerN,
    required this.ftpLoginControllerN,
    required this.ftpPasswordControllerN,
    required this.proxyHostControllerN,
    required this.proxyPortControllerN,
    required this.proxyLoginControllerN,
    required this.proxyPasswordControllerN
  });

  @override
  _FtpToEditInCopyFileState createState() => _FtpToEditInCopyFileState();
}

class _FtpToEditInCopyFileState extends State<FtpToEditInCopyFile> {

  bool isPassiveMode = false;
  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '#######');
  }

  @override
  Widget build(BuildContext context) => Responsive(
    runSpacing: 0,
    children: [
        Div(
          colL: 12,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text('Настройка FTP. Импорт', style: AppStyles.headerTextStyle)
          ),
        ),
        Div(
          colL: 8,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              controller: widget.ftpHostControllerN,
              labelText: 'Хост',
              maxLength: 128,
              onSaved: (value) {
                if ((widget.jobPart?.ftpHostN ?? '') != value) {
                  widget.request.ftpHostN = value;
                } else {
                  widget.request.ftpHostN = null;
                }
              },
            ),
          ),
        ),
        Div(
          colL: 4,
          colM: 12,
          child: 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AttrTextField(
                formatter: _formatter,
                controller: widget.ftpPortControllerN,
                labelText: 'Порт',
                maxLength: 128,
                onSaved: (value) {
                  // ignore: unrelated_type_equality_checks
                  if ((widget.jobPart?.ftpPortN ?? 0) != value) {
                  widget.request.ftpPortN = int.parse(value);
                } else {
                  widget.request.ftpHostN = null;
                }
                },
              ),
            ),
        ),
        Div(
          colL: 6,
          colM: 12,
          child: 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AttrTextField(
                controller: widget.ftpLoginControllerN,
                labelText: 'Имя пользователя',
                maxLength: 128,
                onSaved: (value) {
                  if ((widget.jobPart?.ftpUsernameN ?? '') != value) {
                  widget.request.ftpUsernameN = value;
                } else {
                  widget.request.ftpUsernameN = null;
                }
                },
              ),
            ),
        ),
        Div(
          colL: 6,
          colM: 12,
          child: 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PasswordTextField(
                controller: widget.ftpPasswordControllerN,
                labelText: 'Пароль',
                onSaved: (value) {
                  if ((widget.jobPart?.ftpPasswordN ?? '') != value) {
                  widget.request.ftpPasswordN = value;
                } else {
                  widget.request.ftpPasswordN = null;
                }
                },
              ),
            ),
        ),
        Div(
          colL: 12,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrLogic(
              value: widget.request.ftpIspassiveModeN =='1',
              onChanged: (value) {
                setState(() {
                  isPassiveMode = !isPassiveMode;
                  if(value) {
                    widget.request.ftpIspassiveModeN = '1';
                  } else {
                    widget.request.ftpIspassiveModeN = '0';
                  }
                });
              },
              text: 'Пассивный режим',
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: TextFieldDropdownSearch<ProxyTypeStatus>(
              title: 'Тип прокси',
              showSearchBox: false,
              maxHeight: 300,
              items: ProxyTypeStatus.values,
              itemBuilder: (item) => item.name ?? '',
              selected: widget.selectedProxyStatus,
              onTap: (item) {
                setState(() {
                  widget.selectedProxyStatus = item;
                });
              },
              onSaved: (value) {
                widget.request.proxyTypeN = widget.selectedProxyStatus?.inJson;
              },
            ),
          ),
        ),
        ..._proxyTypeFields()
    ],
  ); 
    List<Widget>  _proxyTypeFields () {
      if(widget.selectedProxyStatus != ProxyTypeStatus.none) {
        return [
          Div(
            colL: 12,
            colM: 12,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Text('Настройки прокси', style: AppStyles.headerTextStyle)
            ),
          ),
          Div(
            colL: 8,
            colM: 12,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AttrTextField(
                controller: widget.proxyHostControllerN,
                labelText: 'Хост',
                maxLength: 128,
                onSaved: (value) {
                  if ((widget.jobPart?.proxyHostN ?? '') != value) {
                      widget.request.proxyHostN = value;
                  } else {
                      widget.request.proxyHostN = null;
                  }
                },
              ),
            ),
          ),
          Div(
            colL: 4,
            colM: 12,
            child: 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AttrTextField(
                  formatter: _formatter,
                  controller: widget.proxyPortControllerN,
                  labelText: 'Порт',
                  maxLength: 128,
                  onSaved: (value) {
                    if ((widget.jobPart?.proxyPortN ?? '') != value) {
                      widget.request.proxyPortN = int.parse(value);
                    } else {
                      widget.request.proxyPortN = null;
                    }
                  },
                ),
              ),
          ),
          Div(
            colL: 6,
            colM: 12,
            child: 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AttrTextField(
                  controller: widget.proxyLoginControllerN,
                  labelText: 'Имя пользователя',
                  maxLength: 128,
                  onSaved: (value) {
                    if ((widget.jobPart?.proxyUsernameN ?? '') != value) {
                      widget.request.proxyUsernameN = value;
                    } else {
                      widget.request.proxyUsernameN = null;
                    }
                  },
                ),
              ),
          ),
          Div(
            colL: 6,
            colM: 12,
            child: 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PasswordTextField(
                  controller: widget.proxyPasswordControllerN,
                  labelText: 'Пароль',
                  onSaved: (value) {
                    if ((widget.jobPart?.proxyPasswordN ?? '') != value) {
                      widget.request.proxyPasswordN = value;
                    } else {
                      widget.request.proxyPasswordN = null;
                    }
                  },
                ),
              ),
          ),
        ]; 
      }
    return [];
  } 
}
