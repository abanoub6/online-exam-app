import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';

class SearchTextField extends StatefulWidget {
  final Function(String)? onChanged;

  const SearchTextField({super.key, this.onChanged});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (value) {
        setState(() {});
        widget.onChanged?.call(value);
      },
      decoration: InputDecoration(
        hintText: AppStrings.search,
        hintStyle: TextStyle(color: AppColors.gray),
        prefixIcon: Icon(Icons.search, color: AppColors.gray),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear, color: AppColors.gray),
                onPressed: () {
                  _controller.clear();
                  setState(() {});
                  widget.onChanged?.call('');
                },
              )
            : null,
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r(20)),
          // borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r(20)),
          // borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r(20)),
          // borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
