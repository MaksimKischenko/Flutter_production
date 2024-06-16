import 'package:flutter/foundation.dart';

class NewQuestionWrapper {
  final Key key;
  final String text;

  const NewQuestionWrapper({
    required this.key,
    required this.text,
  });

  NewQuestionWrapper copyWith({
    Key? key,
    String? text,
  }) => NewQuestionWrapper(
    key: key ?? this.key,
    text: text ?? this.text,
  );
}
