import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/screens/job_part_edit/widgets/widgets.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

// ignore: must_be_immutable
class ExTrpTemplateEditTab extends StatefulWidget {

  final JobPartUpdateRequest request;
  final JobPart? jobPart;

  final List<PeriodType>? periodTypes;
  PeriodType? selectedPeriodType;
  final ProxyTypeStatus? selectedProxyStatus;

  final TextEditingController jobPartTempFileNameController;
  final TextEditingController jobPartIdFieldNameController;
  final TextEditingController jobPartSumFieldNameController;
  final TextEditingController jobPartExportDirController;
  final TextEditingController jobPartExportDirCopyController;
  final TextEditingController jobPartNumOfPrevPeriodController;

  final TextEditingController ftpHostController;
  final TextEditingController ftpPortController;
  final TextEditingController ftpLoginController;
  final TextEditingController ftpPasswordController;
  final TextEditingController proxyHostController;
  final TextEditingController proxyPortController;
  final TextEditingController proxyLoginController;
  final TextEditingController proxyPasswordController;

  ExTrpTemplateEditTab({
    required this.request,
    required this.jobPart,
    required this.periodTypes,
    required this.selectedPeriodType,
    required this.selectedProxyStatus,
    required this.jobPartTempFileNameController,
    required this.jobPartIdFieldNameController,
    required this.jobPartSumFieldNameController,
    required this.jobPartExportDirController,
    required this.jobPartExportDirCopyController,
    required this.jobPartNumOfPrevPeriodController,
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
  _ExTrpTemplateEditTabState createState() => _ExTrpTemplateEditTabState();
}

class _ExTrpTemplateEditTabState extends State<ExTrpTemplateEditTab> {

  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  bool isUseDate = false; 
  bool isForCurePeriod = false;   
  bool isFtpFrom = false; 

  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '########');
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
      Div(
        colL: 6,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AttrTextField(
            controller: widget.jobPartIdFieldNameController,
            labelText: 'Наименование ID-поля',
            maxLength: 10,
            onSaved: (value) {
              if ((widget.jobPart?.idFieldName ?? '') != value) {
                widget.request.idFieldName = value; 
              } else {
                widget.request.idFieldName = null;
              }
            },
          ),
        ),
      ),
      Div(
        colL: 6,
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
      Div(
        colL: 6,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AttrTextField(
            controller: widget.jobPartSumFieldNameController,
            labelText: 'Наименование SUM-поля',
            maxLength: 10,
            onSaved: (value) {
              if ((widget.jobPart?.sumFieldName ?? '') != value) {
                widget.request.sumFieldName = value; 
              } else {
                widget.request.sumFieldName = null;
              }
            },
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
        colL: 12,
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
                    widget.jobPartExportDirCopyController.text = widget.jobPartExportDirCopyController.text.replaceAll('file://', 'ftp://');//дир.экспорта копии
                  } else {
                    widget.request.isFtp = '0';
                    widget.jobPartExportDirController.text = widget.jobPartExportDirController.text.replaceAll('ftp://', 'file://');
                    widget.jobPartExportDirCopyController.text = widget.jobPartExportDirCopyController.text.replaceAll('ftp://', 'file://');
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
            controller: widget.jobPartExportDirCopyController,
            labelText: 'Директория экспорта копии',
            maxLength: 128,
            onSaved: (value) {
              if ((widget.jobPart?.copyExpDir ?? '') != value) {
                widget.request.expDir =  value;
              } else {
                widget.request.copyExpDir = null;
              } 
            },
          ),
        ),
      ),
    ],
  );
}