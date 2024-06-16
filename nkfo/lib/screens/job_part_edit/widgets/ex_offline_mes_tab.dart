import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/screens/job_part_edit/widgets/widgets.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

// ignore: must_be_immutable
class ExpOfflineMesTab extends StatefulWidget {

  final JobPartUpdateRequest request;
  final JobPart? jobPart;

  final List<PeriodType>? periodTypes;
  PeriodType? selectedPeriodType;
  final ProxyTypeStatus selectedProxyStatus;

  final TextEditingController jobPartSqlTextController;
  final TextEditingController jobPartNumOfPrevPeriodController;
  final TextEditingController jobPartExportDirController;
  final TextEditingController jobPartCopyExportDirController;
  final TextEditingController jobPartParamComandFileController;
  final TextEditingController jobPartComandFileController;
  final TextEditingController ftpHostController;
  final TextEditingController ftpPortController;
  final TextEditingController ftpLoginController;
  final TextEditingController ftpPasswordController;
  final TextEditingController proxyHostController;
  final TextEditingController proxyPortController;
  final TextEditingController proxyLoginController;
  final TextEditingController proxyPasswordController;

   ExpOfflineMesTab({
    required this.request,
    required this.selectedProxyStatus,
    required this.jobPartSqlTextController,
    required this.jobPartNumOfPrevPeriodController,
    required this.jobPartExportDirController,
    required this.jobPartCopyExportDirController,
    required this.jobPartParamComandFileController,
    required this.jobPartComandFileController,
    required this.ftpHostController,
    required this.ftpPortController,
    required this.ftpLoginController,
    required this.ftpPasswordController,
    required this.proxyHostController,
    required this.proxyPortController,
    required this.proxyLoginController,
    required this.proxyPasswordController,
    this.jobPart,
    this.periodTypes,
    this.selectedPeriodType,
    Key? key,
  }) : super(key: key);


  
  
  @override
  _ExpOfflineMesTabState createState() => _ExpOfflineMesTabState();
}

class _ExpOfflineMesTabState extends State<ExpOfflineMesTab> {

  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  bool isUseDate = false; 
  bool isForCurePeriod = false;
  bool isFtpFrom = false; 
  bool useElSign = false;


  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '##########');
    isFtpFrom = widget.request.isFtp =='1';
    isForCurePeriod = widget.request.isForCurPeriod == '1';

    if(widget.jobPart?.numOfPrevPeriod == null) {
      widget.jobPartNumOfPrevPeriodController.text = '';
    }
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
            maxLines: 100,
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
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: AttrLogic(
              value: widget.request.isUseDate == '1',
              onChanged: (value) {
                setState(() {
                  isUseDate = !isUseDate;
                  if (value) {
                    widget.request.isUseDate = '1';
                  } else {
                    widget.request.isUseDate = '0';
                    widget.request.isForCurPeriod = '0';
                    widget.jobPartNumOfPrevPeriodController.text = '';
                    isForCurePeriod = false;
                    widget.selectedPeriodType = null;
                  }
                });
              },
              text: 'Формировать за период',
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
              isReadOnly: widget.request.isUseDate != '1',
              formatter: _formatter,
              controller: widget.jobPartNumOfPrevPeriodController,
              labelText: 'Кол-во предыдущих периодов',
              maxLength: 10,
              onSaved: (value) {
                if ((widget.jobPart?.numOfPrevPeriod ?? '') != value) {
                  widget.request.numOfPrevPeriod = int.tryParse(value) ?? 0;
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
            child: TextFieldDropdownSearch<PeriodType>(
              editable: widget.request.isUseDate == '1',
              title: 'Тип периода',
              showSearchBox: false,
              maxHeight: 290,
              items: widget.periodTypes ?? [],
              itemBuilder: (item) => item.name,
              selected: widget.selectedPeriodType,
              onTap: (item) {
                setState(() {
                  widget.selectedPeriodType = item;
                });
              },
              onSaved: (value) {
                widget.request.periodTypeName = value?.name;
                widget.request.periodType = value?.id;

                if(widget.selectedPeriodType == null) {
                  widget.request.periodType = 0;
                }
              },
            ),
          ),
        ),
        Div(
          colL: 12,
          colM: 12,
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: AttrLogic(
              editable: widget.request.isUseDate == '1',
              value: isForCurePeriod,
              onChanged: (value) {
                setState(() {
                  isForCurePeriod = !isForCurePeriod;
                  if (value) {
                    widget.request.isForCurPeriod = '1';
                  } else {
                    widget.request.isForCurPeriod = '0';
                  }
                });
              },
              text: 'Формировать за тек. период',
              padding: EdgeInsets.zero,
            ),
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
                  isFtpFrom = !isFtpFrom;
                  if(value) {
                    widget.request.isFtp = '1';
                    widget.jobPartExportDirController.text = widget.jobPartExportDirController.text.replaceAll('file://', 'ftp://');//дир.экспорта
                    widget.jobPartCopyExportDirController.text = widget.jobPartCopyExportDirController.text.replaceAll('file://', 'ftp://');//дир.экспорта копии
                  } else {
                    widget.request.isFtp = '0';
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
      Div(
        colL: 6,
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
            if (widget.jobPart?.copyExpDir != value) {

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
            controller: widget.jobPartComandFileController,
            labelText: 'Командный файл',
            maxLength: 128,
            onSaved: (value) {
            if ((widget.jobPart?.comFile ?? '') != value) {
              widget.request.comFile = value;
            } else {
              widget.request.comFile = null;
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
            controller: widget.jobPartParamComandFileController,
            labelText: 'Параметры командного файла',
            maxLength: 128,
            onSaved: (value) {
            if ((widget.jobPart?.paramComFile ?? '') != value) {
              widget.request.paramComFile = value;
            } else {
              widget.request.paramComFile = null;
            }
            },
          ),
        ),
      ),
    ],
    
  );
}