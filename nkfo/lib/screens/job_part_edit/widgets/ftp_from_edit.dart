import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

// ignore: must_be_immutable
class FtpFromEdit extends StatefulWidget {

  final JobPartUpdateRequest request;
  final JobPart? jobPart;

  ProxyTypeStatus? selectedProxyStatus;

  final TextEditingController ftpHostController;
  final TextEditingController ftpPortController;
  final TextEditingController ftpLoginController;
  final TextEditingController ftpPasswordController;
  final TextEditingController proxyHostController;
  final TextEditingController proxyPortController;
  final TextEditingController proxyLoginController;
  final TextEditingController proxyPasswordController;

  FtpFromEdit({
    required this.request,
    required this.jobPart,
    required this.selectedProxyStatus,
    required this.ftpHostController,
    required this.ftpPortController,
    required this.ftpLoginController,
    required this.ftpPasswordController,
    required this.proxyHostController,
    required this.proxyPortController,
    required this.proxyLoginController,
    required this.proxyPasswordController,
    Key? key,
  }) : super(key: key);

  @override
  _FtpFromEditState createState() => _FtpFromEditState();
}

class _FtpFromEditState extends State<FtpFromEdit> {

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
            child: Text('Настройка FTP. Экспорт', style: AppStyles.headerTextStyle)
          ),
        ),
        Div(
          colL: 8,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              controller: widget.ftpHostController,
              labelText: 'Хост',
              maxLength: 128,
              onSaved: (value) {
                if ((widget.jobPart?.ftpHost ?? '') != value) {
                  widget.request.ftpHost = value;
                } else {
                  widget.request.ftpHost = null;
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
                controller: widget.ftpPortController,
                labelText: 'Порт',
                maxLength: 128,
                onSaved: (value) {
                  // ignore: unrelated_type_equality_checks
                  if ((widget.jobPart?.ftpPort ?? 0) != value) {
                  widget.request.ftpPort = int.parse(value);
                } else {
                  widget.request.ftpHost = null;
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
                controller: widget.ftpLoginController,
                labelText: 'Имя пользователя',
                maxLength: 128,
                onSaved: (value) {
                  if ((widget.jobPart?.ftpUsername ?? '') != value) {
                  widget.request.ftpUsername = value;
                } else {
                  widget.request.ftpUsername = null;
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
                controller: widget.ftpPasswordController,
                labelText: 'Пароль',
                onSaved: (value) {
                  if ((widget.jobPart?.ftpPassword ?? '') != value) {
                  widget.request.ftpPassword = value;
                } else {
                  widget.request.ftpPassword = null;
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
              value: widget.request.ftpIspassiveMode =='1',
              onChanged: (value) {
                setState(() {
                  isPassiveMode = !isPassiveMode;
                  if(value) {
                    widget.request.ftpIspassiveMode = '1';
                  } else {
                    widget.request.ftpIspassiveMode = '0';
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
                widget.request.proxyType = widget.selectedProxyStatus?.inJson;
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
                controller: widget.proxyHostController,
                labelText: 'Хост',
                maxLength: 128,
                onSaved: (value) {
                  if ((widget.jobPart?.proxyHost ?? '') != value) {
                      widget.request.proxyHost = value;
                  } else {
                      widget.request.proxyHost = null;
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
                  controller: widget.proxyPortController,
                  labelText: 'Порт',
                  maxLength: 128,
                  onSaved: (value) {
                    if ((widget.jobPart?.proxyPort ?? '') != value) {
                      widget.request.proxyPort = int.parse(value);
                    } else {
                      widget.request.proxyPort = null;
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
                  controller: widget.proxyLoginController,
                  labelText: 'Имя пользователя',
                  maxLength: 128,
                  onSaved: (value) {
                    if ((widget.jobPart?.proxyUsername ?? '') != value) {
                      widget.request.proxyUsername = value;
                    } else {
                      widget.request.proxyUsername = null;
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
                  controller: widget.proxyPasswordController,
                  labelText: 'Пароль',
                  onSaved: (value) {
                    if ((widget.jobPart?.proxyPassword ?? '') != value) {
                      widget.request.proxyPassword = value;
                    } else {
                      widget.request.proxyPassword = null;
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
