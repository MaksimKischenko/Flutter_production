import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/screens/job_part_edit/widgets/widgets.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class CopyFileTab extends StatefulWidget {

  final JobPartUpdateRequest request;
  final JobPart? jobPart;

  final ProxyTypeStatus? selectedProxyStatus;
  final ProxyTypeStatus? selectedProxyStatusN;

  final TextEditingController jobPartImportDirController;
  final TextEditingController jobPartExportDirController;
  final TextEditingController jobPartTempFileNameController;
  final TextEditingController ftpHostController;
  final TextEditingController ftpPortController;
  final TextEditingController ftpLoginController;
  final TextEditingController ftpPasswordController;
  final TextEditingController ftpHostControllerN;
  final TextEditingController ftpPortControllerN;
  final TextEditingController ftpLoginControllerN;
  final TextEditingController ftpPasswordControllerN;
  final TextEditingController proxyHostController;
  final TextEditingController proxyPortController;
  final TextEditingController proxyLoginController;
  final TextEditingController proxyPasswordController;
  final TextEditingController proxyHostControllerN;
  final TextEditingController proxyPortControllerN;
  final TextEditingController proxyLoginControllerN;
  final TextEditingController proxyPasswordControllerN;

  const CopyFileTab({
    required this.request,
    required this.jobPartImportDirController,
    required this.jobPartExportDirController,
    required this.jobPartTempFileNameController,
    required this.ftpHostController,
    required this.ftpPortController,
    required this.ftpLoginController,
    required this.ftpPasswordController,
    required this.ftpHostControllerN,
    required this.ftpPortControllerN,
    required this.ftpLoginControllerN,
    required this.ftpPasswordControllerN,
    required this.proxyHostController,
    required this.proxyPortController,
    required this.proxyLoginController,
    required this.proxyPasswordController,
    required this.proxyHostControllerN,
    required this.proxyPortControllerN,
    required this.proxyLoginControllerN,
    required this.proxyPasswordControllerN,
    this.jobPart,
    this.selectedProxyStatus,
    this.selectedProxyStatusN,
    Key? key,
  }) : super(key: key);


  
  @override
  _CopyFileTabState createState() => _CopyFileTabState();
}

class _CopyFileTabState extends State<CopyFileTab> {

 bool isFtpFrom = false; 
 bool isFtpTo = false; 
 
  @override
  void initState() {
    super.initState();
    isFtpFrom = widget.request.isFtp =='1';
    isFtpTo = widget.request.isFtpN =='1';
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
            controller: widget.jobPartExportDirController,
            labelText: 'Директория экспорта',
            maxLength: 128,
            onSaved: (value) {
              if ((widget.jobPart?.expDir ?? '') != value) {
                widget.request.expDir = value;
              } else {
                widget.request.expDir = null;
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
            value: widget.request.isFtp == '1',
            onChanged: (value) {
              setState(() {
                isFtpFrom = !isFtpFrom;
                if(value) {
                  widget.request.isFtp = '1';
                  widget.jobPartExportDirController.text = widget.jobPartExportDirController.text.replaceAll('file://', 'ftp://');//дир.экспорта
                } else {
                  widget.request.isFtp = '0';
                  widget.jobPartExportDirController.text = widget.jobPartExportDirController.text.replaceAll('ftp://', 'file://');
                }
              });
            },
            text: 'Работа с FTP сервером',
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      if(isFtpFrom)
      FtpFromEdit(
        request: widget.request, 
        jobPart: widget.jobPart, 
        selectedProxyStatus: widget.selectedProxyStatus, 
        ftpHostController: widget.ftpHostController, 
        ftpPortController: widget.ftpPortController, 
        ftpLoginController: widget.ftpLoginController, 
        ftpPasswordController: widget.ftpPasswordController,
        proxyHostController: widget.proxyHostController,
        proxyPortController: widget.proxyPortController,
        proxyLoginController: widget.proxyLoginController,
        proxyPasswordController: widget.proxyPasswordController,
      ),
      Div(
        colL: 6,
        colM: 12,
        child: 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              controller: widget.jobPartTempFileNameController,
              labelText: 'Файл-шаблон',
              maxLength: 128,
              onSaved: (value) {
                if ((widget.jobPart?.tmpFileName ?? '') != value) {
                  widget.request.tmpFileName = value;
                } else {
                  widget.request.tmpFileName = null;
                }
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
              controller: widget.jobPartImportDirController,
              labelText: 'Директория импорта',
              maxLength: 128,
              onSaved: (value) {
               if ((widget.jobPart?.impDir ?? '') != value) {
                  widget.request.impDir = value;
               } else {
                  widget.request.impDir = null;
               }
              }
            ),
          ),
      ),
      Div(
        colL: 6,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AttrLogic(
            value: widget.request.isFtpN == '1',
            onChanged: (value) {
              setState(() {
                isFtpTo = !isFtpTo;
                if(value) {
                  widget.request.isFtpN = '1';
                  widget.jobPartImportDirController.text = widget.jobPartImportDirController.text.replaceAll('file://', 'ftp://'); //импорт
                } else {
                  widget.request.isFtpN = '0';
                  widget.jobPartImportDirController.text= widget.jobPartImportDirController.text.replaceAll('ftp://', 'file://');
                }
              });
            },
            text: 'Работа с FTP сервером',
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      if(isFtpTo)
      FtpToEditInCopyFile(
        request: widget.request, 
        jobPart: widget.jobPart, 
        selectedProxyStatus: widget.selectedProxyStatusN, 
        ftpHostControllerN: widget.ftpHostControllerN, 
        ftpPortControllerN: widget.ftpPortControllerN, 
        ftpLoginControllerN: widget.ftpLoginControllerN, 
        ftpPasswordControllerN: widget.ftpPasswordControllerN,
        proxyHostControllerN: widget.proxyHostControllerN,
        proxyPortControllerN: widget.proxyPortControllerN,
        proxyLoginControllerN: widget.proxyLoginControllerN,
        proxyPasswordControllerN: widget.proxyPasswordControllerN,
      )
    ],
  );
}