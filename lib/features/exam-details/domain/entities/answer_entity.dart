import 'package:flutter/cupertino.dart';

@immutable
class AnswerEntity {
  final String answer;
  final String key;

  const AnswerEntity({required this.answer, required this.key});
}
