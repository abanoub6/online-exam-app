// widgets/timer_widget.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';

class TimerWidget extends StatefulWidget {
  final int initialSeconds;
  final VoidCallback? onTimeFinished;
  const TimerWidget({
    super.key,
    required this.initialSeconds,
    required this.onTimeFinished,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _resetTimer();
  }

  void _resetTimer() {
    _timer?.cancel();
    _remainingSeconds = widget.initialSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        widget.onTimeFinished?.call();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.timer_outlined, color: AppColors.blue),
        const SizedBox(width: 6),
        Text(
          formattedTime,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: _remainingSeconds <= 60 ? Colors.red : AppColors.blue,
          ),
        ),
      ],
    );
  }
}
