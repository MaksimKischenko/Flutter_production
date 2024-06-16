import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class FtpToInCopyFile extends StatefulWidget {

  final JobPartInsertRequest request;

  const FtpToInCopyFile({
    required this.request,
    Key? key,
  }) : super(key: key);

  @override
  _FtpToInCopyFileState createState() => _FtpToInCopyFileState();
}

class _FtpToInCopyFileState extends State<FtpToInCopyFile> {

  bool isPassiveMode = false;
  ProxyTypeStatus _selectedProxtType = ProxyTypeStatus.none;
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
              labelText: 'Хост',
              maxLength: 128,
              onSaved: (value) {
                widget.request.ftpHostN = value;
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
                initialValue: '0',
                labelText: 'Порт',
                maxLength: 128,
                onSaved: (value) {
                  widget.request.ftpPortN = int.parse(value);
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
                labelText: 'Имя пользователя',
                maxLength: 128,
                onSaved: (value) {
                  widget.request.ftpUsernameN = value;
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
                labelText: 'Пароль',
                onSaved: (value) {
                  widget.request.ftpPasswordN = value;
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
              value: isPassiveMode,
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
              selected: _selectedProxtType,
              onTap: (item) {
                setState(() {
                  _selectedProxtType = item;
                });
              },
              onSaved: (value) {
                widget.request.proxyTypeN = _selectedProxtType.inJson;
              },
            ),
          ),
        ),
       ..._proxyTypeFields()
    ],
  ); 

  List<Widget>  _proxyTypeFields () {
      if(_selectedProxtType != ProxyTypeStatus.none) {
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
                labelText: 'Хост',
                maxLength: 128,
                onSaved: (value) {
                  widget.request.proxyHostN = value;
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
                  initialValue: '0',
                  labelText: 'Порт',
                  maxLength: 128,
                  onSaved: (value) {
                    widget.request.proxyPortN = int.parse(value);
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
                  labelText: 'Имя пользователя',
                  maxLength: 128,
                  onSaved: (value) {
                    widget.request.proxyUsernameN = value;
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
                  labelText: 'Пароль',
                  onSaved: (value) {
                    widget.request.proxyPasswordN = value;
                  },
                ),
              ),
          ),
        ]; 
      }
    return [];
  }
}
