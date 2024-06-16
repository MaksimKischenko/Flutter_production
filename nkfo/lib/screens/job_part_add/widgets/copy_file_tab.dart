import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/screens/job_part_add/widgets/widgets.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class CopyFileTab extends StatefulWidget {

  final JobPartInsertRequest request;

  const CopyFileTab({
    required this.request,
    Key? key,
  }) : super(key: key);

 
  @override
  _CopyFileTabState createState() => _CopyFileTabState();
}

class _CopyFileTabState extends State<CopyFileTab> {

  bool isFtpFrom = false;
  bool isFtpTo = false;
  String localDirection = 'file://';
  String ftpDirection = 'ftp://';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_statements
    isFtpFrom ? controller.text = 'ftp://' : 'file://';
  }
  
  @override
  Widget build(BuildContext context) => Responsive(
    runSpacing: 0,
    children: [
        Div( 
          colL: 12,
          colM: 12,
          child: 
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text('ИЗ:', style: AppStyles.headerTextStyle,)
            ),
        ),
        Div(
            colL: 6,
            colM: 12,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AttrTextField(
                controller: controller,
                labelText: 'Директория экспорта',
                maxLength: 128,
                onSaved: (value) {
                  if(isFtpFrom) {
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
            child: AttrLogic(
              value: isFtpFrom,
              onChanged: (value) {
                setState(() {
                  isFtpFrom = !isFtpFrom;
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
        if(isFtpFrom)
        FtpFrom(
          request: widget.request,
        ),
        Div(
          colL: 6,
          colM: 12,
          child: 
            Padding(
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
        Div(
          colL: 12,
          colM: 12,
          child: 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text('В:', style: AppStyles.headerTextStyle,)
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
            child: AttrLogic(
              value: isFtpTo,
              onChanged: (value) {
                setState(() {
                  isFtpTo = !isFtpTo;
                  if(value) {
                    widget.request.isFtpN = '1';
                  } else {
                    widget.request.isFtpN = '0';
                  }
                });
              },
              text: 'Работа с FTP сервером',
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        if(isFtpTo)
        FtpToInCopyFile(
          request: widget.request
        )
    ],
  );
}