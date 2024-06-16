import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/screens/job_part_add/widgets/widgets.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ImOffLineMesTab extends StatefulWidget {

  final JobPartInsertRequest request;

  const ImOffLineMesTab({
    required this.request,
    Key? key
  }) : super(key: key);

  
  @override
  _ImOffLineMesTabState createState() => _ImOffLineMesTabState();
}

class _ImOffLineMesTabState extends State<ImOffLineMesTab> {

  bool isFtpTo = false;
  bool useElSign = false;
  String localDirection = 'file://';
  String ftpDirection = 'ftp://';
  
  @override
  Widget build(BuildContext context) => Responsive(
    runSpacing: 0,
    children: [
      Div(
          colL: 12,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              labelText: 'SQL-запрос',
              maxLength: 10000,
              maxLines: 6,
              onSaved: (value) {
                widget.request.sql = value;
              },
            ),
          ),
        ),
        Div(
          colL: 12,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text('ДИРЕКТОРИИ', style: AppStyles.headerTextStyle)
          ),
        ),
        const SizedBox(height: 10),
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: AttrLogic(
              value: isFtpTo,
              onChanged: (value) {
                setState(() {
                  isFtpTo = !isFtpTo;
                  if(value) {
                    widget.request.isFtp = '1';
                  } else {
                    widget.request.isFtp = '0';
                  }
                });
              },
              text: 'Работа с FTP сервером',
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        if(isFtpTo)
        FtpTo(request: widget.request),
        Div(
          colL:12,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: AttrLogic(
              value: useElSign,
              onChanged: (value) {
                setState(() {
                  useElSign = !useElSign;
                });
              },
              text: 'Использовать электронную подпись',
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              labelText: 'Директория импорта',
              maxLength: 128,
              onSaved: (value) {
                if(isFtpTo) {
                    widget.request.impDir = ftpDirection + value;
                } else {
                    widget.request.impDir = localDirection + value;
                }
              },
            ),
          ),
        ),
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              labelText: 'Директория обработанных файлов',
              maxLength: 128,
              onSaved: (value) {
                if(isFtpTo) {
                    widget.request.afterImpDir = ftpDirection + value;
                } else {
                    widget.request.afterImpDir = localDirection + value;
                }
              },
            ),
          ),
        ),
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              labelText: 'Директория ошибок',
              maxLength: 128,
              onSaved: (value) {
                if(isFtpTo) {
                    widget.request.dirInErr = ftpDirection + value;
                } else {
                    widget.request.dirInErr = localDirection + value;
                }
              },
            ),
          ),
        ),
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              labelText: 'Директория экспорта',
              maxLength: 128,
              onSaved: (value) {
                if(isFtpTo) {
                    widget.request.expDir = ftpDirection + value;
                } else {
                    widget.request.expDir = localDirection + value;
                }
              },
            ),
          ),
        ),
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              labelText: 'Директория экспорта копии',
              maxLength: 128,
              onSaved: (value) {
                if(isFtpTo) {
                    widget.request.copyExpDir = ftpDirection + value;
                } else {
                    widget.request.copyExpDir = localDirection + value;
                }
              },
            ),
          ),
        ),
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              labelText: 'Файл-шаблон',
              maxLength: 128,
              onSaved: (value) {
                widget.request.tmpFileName = value;
              },
            ),
          ),
        ),
    ],
  );
}