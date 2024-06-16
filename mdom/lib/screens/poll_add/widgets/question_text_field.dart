import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class QuestionTextField extends StatelessWidget {
  final int index;
  final NewQuestionWrapper value;
  final Function(String value) onChanged;
  final Function(int index) onDismissed;

  const QuestionTextField({
    Key? key,
    required this.index,
    required this.value,
    required this.onChanged,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Slidable(
    key: value.key,
    closeOnScroll: true,
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      dismissible: DismissiblePane(onDismissed: () => onDismissed(index)),
      dragDismissible: false,
      children: [
        SlidableAction(
          label: 'Удалить',
          backgroundColor: const Color(0xffEC5B5B),
          icon: Icons.delete_forever,
          autoClose: false,
          onPressed: _onDeleteTap,
        )
      ],
    ),
    child: TextFormField(
      initialValue: value.text,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: 'Вопрос №${index+1}',
        // hintText: hint,
        counterText: '',
        alignLabelWithHint: true,
        labelStyle: AppStyles.inputLabelUnderlineStyle,
        focusedBorder: AppStyles.inputBorderUnderline,
        enabledBorder: AppStyles.inputBorderUnderline,
        border: AppStyles.inputBorderUnderline,
        isDense: true,
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value?.isEmpty ?? true) return 'Обязательное поле';
        return null;
      },
      // onChanged: (value) {
      //   try {
      //     final date = DateFormat('dd/MM/yyyy').parse(value);
      //     return onChanged?.call(date);
      //   } catch (e) {}
      // },
    ),
  );

  void _onDeleteTap(BuildContext context) {
    Slidable.of(context)?.dismiss(ResizeRequest(const Duration(milliseconds: 50), () => onDismissed(index)));
  }
}