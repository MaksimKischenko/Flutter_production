import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/screens/job_part_edit/widgets/ftp_to_edit.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ImOffLineMesTab extends StatefulWidget {

  final  JobPartUpdateRequest request;
  final JobPart? jobPart;
  final  ProxyTypeStatus selectedProxyStatus;

  final TextEditingController jobPartSqlTextController;
  final TextEditingController jobPartImportDirController;
  final TextEditingController jobPartExportDirController;
  final TextEditingController jobPartTempFileNameController;
  final TextEditingController jobPartAfterImportDirController;
  final TextEditingController jobPartErrorDirController;
  final TextEditingController jobPartCopyExportDirController;
  final TextEditingController ftpHostController;
  final TextEditingController ftpPortController;
  final TextEditingController ftpLoginController;
  final TextEditingController ftpPasswordController;
  final TextEditingController proxyHostController;
  final TextEditingController proxyPortController;
  final TextEditingController proxyLoginController;
  final TextEditingController proxyPasswordController;

   const ImOffLineMesTab({
    required this.request,
    required this.jobPart,
    required this.selectedProxyStatus,
    required this.jobPartSqlTextController,
    required this.jobPartImportDirController,
    required this.jobPartExportDirController,
    required this.jobPartTempFileNameController,
    required this.jobPartAfterImportDirController,
    required this.jobPartErrorDirController,
    required this.jobPartCopyExportDirController,
    required this.ftpHostController,
    required this.ftpPortController,
    required this.ftpLoginController,
    required this.ftpPasswordController,
    required this.proxyHostController,
    required this.proxyPortController,
    required this.proxyLoginController,
    required this.proxyPasswordController,
  });

  
  @override
  _ImOffLineMesTabState createState() => _ImOffLineMesTabState();
}

class _ImOffLineMesTabState extends State<ImOffLineMesTab> {

  bool isFtpTo = false;
  bool useElSign = false;

  @override
  void initState() {
    super.initState();
    isFtpTo = widget.request.isFtp =='1';
  }
  
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
            controller: widget.jobPartSqlTextController,
            labelText: 'SQL-запрос',
            maxLength: 10000,
            maxLines: 6,
            onSaved: (value) {
              if ((widget.jobPart?.sql ?? '') != value) {
                widget.request.sql = value;
              } else {
                widget.request.sql = null;
              }
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
      Div(
        colL: 6,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: AttrLogic(
            value: widget.request.isFtp =='1',
            onChanged: (value) {
              setState(() {
                isFtpTo = !isFtpTo;
                if(value) {
                  widget.request.isFtp = '1';
                  widget.jobPartImportDirController.text = widget.jobPartImportDirController.text.replaceAll('file://', 'ftp://'); //импорт
                  widget.jobPartAfterImportDirController.text = widget.jobPartAfterImportDirController.text.replaceAll('file://', 'ftp://');//дир.обр.файл
                  widget.jobPartErrorDirController.text = widget.jobPartErrorDirController.text.replaceAll('file://', 'ftp://'); //дир.ошибок
                  widget.jobPartExportDirController.text = widget.jobPartExportDirController.text.replaceAll('file://', 'ftp://');//дир.экспорта
                  widget.jobPartCopyExportDirController.text = widget.jobPartCopyExportDirController.text.replaceAll('file://', 'ftp://');//дир.экспорта копии
                } else {
                  widget.request.isFtp = '0';
                  widget.jobPartImportDirController.text= widget.jobPartImportDirController.text.replaceAll('ftp://', 'file://');
                  widget.jobPartAfterImportDirController.text = widget.jobPartAfterImportDirController.text.replaceAll('ftp://', 'file://');
                  widget.jobPartErrorDirController.text = widget.jobPartErrorDirController.text.replaceAll('ftp://', 'file://');
                  widget.jobPartExportDirController.text = widget.jobPartExportDirController.text.replaceAll('ftp://', 'file://');
                  widget.jobPartCopyExportDirController.text = widget.jobPartCopyExportDirController.text.replaceAll('ftp://', 'file://');
                }
              });
            },
            text: 'Работа с FTP сервером',
            padding: EdgeInsets.zero,
          ),
        ),
        ),
        if(isFtpTo)
        FtpToEdit(
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
          colL: 12,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: AttrLogic(
              value: widget.request.useEsign == 1,
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
        const SizedBox(height: 10),
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
            controller: widget.jobPartAfterImportDirController,
            labelText: 'Директория обработанных файлов',
            maxLength: 128,
            onSaved: (value) {
            if ((widget.jobPart?.afterImpDir ?? '') != value) {
               widget.request.afterImpDir = value;
            } else {
              widget.request.afterImpDir = null;
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
              controller: widget.jobPartErrorDirController,
              labelText: 'Директория ошибок',
              maxLength: 128,
              onSaved: (value) {
              if ((widget.jobPart?.dirInErr ?? '') != value) {
                widget.request.dirInErr = value;
              } else {
                widget.request.dirInErr = null;
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
          child: AttrTextField(
            controller: widget.jobPartCopyExportDirController,
            labelText: 'Директория экспорта копии',
            maxLength: 128,
            onSaved: (value) {
            if ((widget.jobPart?.copyExpDir ?? '') != value) {
              widget.request.copyExpDir = value;
            } else {
              widget.request.copyExpDir = null;
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
    ],
  );
}