
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class MessageItem extends StatefulWidget {
  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  bool get isSaveAvailable => _messageController.text.length > 1;
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();


  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) => Expanded(
    child: BlocListener<IntroMessageBloc, IntroMessageState>(
      listener: (context, state) {
        if (state is IntroMessageError) {
          RequestUtil.catchNetworkError(context: context, obj: state.error);
        } else if (state is IntroMessageSuccess) {
          Multiplatform.showMessage(
            context: context,
            title: 'Успешно',
            message: 'Сообщение сохранено',
            type: DialogType.success
          );
        } 
      },
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text('Настройка сообщения', style: AppStyles.headerTextStyle),
          const SizedBox(height: 20),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  var width = 800.0;
                  if (sizingInformation.isMobile || sizingInformation.isTablet) {
                    width = sizingInformation.screenSize.width;
                  }
                  return SizedBox(
                    width: width,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          AttrTextField(
                            controller: _messageController,
                            labelText: 'Сообщение',
                            mandatory: true,
                            maxLength: 2000,
                            maxLines: 10,
                            onChanged: (_) => setState(() {}),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Поле обязательное для заполнения';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SaveButton(
                  onTap: _onSaveTap,
                  isAvaible: isSaveAvailable
                )
              ],
            ),
          ),
        ],
      )
    ),
  );

   
  void _onSaveTap() {
    if(_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<IntroMessageBloc>().add(IntroMessageSave(
          message: _messageController.text
      ));
    }
  }
}