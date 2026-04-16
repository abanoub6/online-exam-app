import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/widgets/timer_widget.dart';

class ExamAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onTimeFinished;

  const ExamAppBar({
    super.key,
    required this.title,
    required this.onBack,
    required this.onTimeFinished,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTextStyles.s20w600()),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBack,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TimerWidget(
            // key: UniqueKey(),
            initialSeconds: 30,
            onTimeFinished: onTimeFinished,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
