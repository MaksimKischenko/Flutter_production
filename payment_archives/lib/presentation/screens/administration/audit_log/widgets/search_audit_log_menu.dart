// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/administration/audit_log/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class SearchAuditLogMenu extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime _dateFrom = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime _dateTo = DateTime.now();
  DateTime _timeFrom = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);
  DateTime _timeTo = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute);  

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          child: Responsive(
            runSpacing: 16,
            children: [
                Div(
                  divison: const Division(
                    colL: 2,
                    colM: 6,
                  ),
                  child: DatePicker(
                    mandatory: true,
                    initialDate: _dateFrom,
                    labelText: AuditLogActionFieldNames.dateFrom.message,
                    onChange: (value) => _dateFrom = value ?? DateTime.now(),
                    validator: () {
                      if(_dateFrom.isAfter(_dateTo)) {
                        return 'Некорректный промежуток времени';
                      }
                      return null;
                    },
                  ),
                ),
                Div(
                  divison: const Division(
                    colL: 1,
                    colM: 6,
                  ),
                  child: TimePicker(
                    initialValue: _timeFrom.toStringFormattedHoursOnly(),
                    labelText: AuditLogActionFieldNames.timeFrom.message,
                    onChanged: (value) => _timeFrom = value,
                  ),
                ),                
                Div(
                  divison: const Division(
                    colL: 2,
                    colM: 6,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: DatePicker(
                      mandatory: true,      
                      initialDate: _dateTo, 
                      labelText: AuditLogActionFieldNames.dateTo.message,
                      onChange: (value) => _dateTo = value ?? DateTime.now(),                            
                      validator: () {
                        if(_dateTo.isBefore(_dateFrom)) {
                          return 'Некорректный промежуток времени';
                        }
                        return null;
                      }, 
                    ),
                  ),
                ),  
                Div(
                  divison: const Division(
                    colL: 1,
                    colM: 6,
                  ),
                  child: TimePicker(
                    initialValue: _timeTo.toStringFormattedHoursOnly(),
                    labelText: AuditLogActionFieldNames.timeTo.message,
                    onChanged: (value) => _timeTo = value,
                  ),
                ),                 
                Div(
                  divison: const Division(
                    colL: 3, 
                    colM: 6
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: InputField(
                      maxLength: 255,
                      controller: _nameController,
                      labelText: AuditLogActionFieldNames.userName.message,
                    ),
                  ),
                ),                                                        
            ],
          ),
        ),
        SizedBox(
          width: 80,
            child: SearchAuditLogButton(
              name: ButtonNames.search.message, 
              onTap: ()=>  _onSearchAuditLogs(context)
            ),
        )        
      ],
    );

  void _onSearchAuditLogs(BuildContext context)  {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();    
      context.read<AuditLogBloc>().add(AuditLogInit(
          dateFrom: DateTime(_dateFrom.year, _dateFrom.month, _dateFrom.day, _timeFrom.hour, _timeFrom.minute),
          dateTo: DateTime(_dateTo.year, _dateTo.month, _dateTo.day, _timeTo.hour, _timeTo.minute),
          userName: _nameController.text
      ));
  }}
}
