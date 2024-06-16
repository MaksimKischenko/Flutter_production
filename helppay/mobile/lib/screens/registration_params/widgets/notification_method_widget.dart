import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';

// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'notification_method_widget');

// enum ContactOption { PHONE, EMAIL }

class ComunicationTypeForm extends StatefulWidget {
  final String title;
  final List<MdomLookupItem>? lookUps;

  const ComunicationTypeForm({required this.title, this.lookUps});
  @override
  _ComunicationTypeFormState createState() => _ComunicationTypeFormState();
}

class _ComunicationTypeFormState extends State<ComunicationTypeForm> {
  final _formKey1 = GlobalKey<FormState>();

  String? _selectedContactOption;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${widget.title}:',
            ),
          ),
          Form(
            key: _formKey1,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              itemCount: widget.lookUps?.length ?? 0,
              itemBuilder: (context, index) => ListTile(
                title: Text(widget.lookUps?[index].name ?? ''),
                leading: Radio<String?>(
                  value: widget.lookUps?[index].evalue,
                  groupValue: _selectedContactOption,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedContactOption = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      );
}


// Column(
//               children: [
                // ListTile(
                //   title: Text('Phone'),
                //   leading: Radio<ContactOption>(
                //     value: ContactOption.phone,
                //     groupValue: _selectedContactOption,
                //     onChanged: (ContactOption? value) {
                //       setState(() {
                //         _selectedContactOption = value;
                //       });
                //     },
                //   ),
                // ),
//                 ListTile(
//                   title: Text('Email'),
//                   leading: Radio<ContactOption>(
//                     value: ContactOption.email,
//                     groupValue: _selectedContactOption,
//                     onChanged: (ContactOption? value) {
//                       setState(() {
//                         _selectedContactOption = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),