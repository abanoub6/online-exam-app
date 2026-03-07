import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  AppTextStyles._();

  // Base function
  static TextStyle _style({
    required double size,
    required FontWeight weight,
    Color? color,
  }) {
    return TextStyle(fontSize: size.sp, fontWeight: weight, color: color);
  }

  /// -------- FontWeight.w300 --------

  static TextStyle s10w300([Color? color]) =>
      _style(size: 10, weight: FontWeight.w300, color: color);

  static TextStyle s12w300([Color? color]) =>
      _style(size: 12, weight: FontWeight.w300, color: color);

  static TextStyle s14w300([Color? color]) =>
      _style(size: 14, weight: FontWeight.w300, color: color);

  static TextStyle s16w300([Color? color]) =>
      _style(size: 16, weight: FontWeight.w300, color: color);

  static TextStyle s18w300([Color? color]) =>
      _style(size: 18, weight: FontWeight.w300, color: color);

  static TextStyle s20w300([Color? color]) =>
      _style(size: 20, weight: FontWeight.w300, color: color);

  /// -------- FontWeight.w400 --------

  static TextStyle s10w400([Color? color]) =>
      _style(size: 10, weight: FontWeight.w400, color: color);

  static TextStyle s12w400([Color? color]) =>
      _style(size: 12, weight: FontWeight.w400, color: color);

  static TextStyle s14w400([Color? color]) =>
      _style(size: 14, weight: FontWeight.w400, color: color);

  static TextStyle s16w400([Color? color]) =>
      _style(size: 16, weight: FontWeight.w400, color: color);

  static TextStyle s18w400([Color? color]) =>
      _style(size: 18, weight: FontWeight.w400, color: color);

  static TextStyle s20w400([Color? color]) =>
      _style(size: 20, weight: FontWeight.w400, color: color);

  static TextStyle s22w400([Color? color]) =>
      _style(size: 22, weight: FontWeight.w400, color: color);

  static TextStyle s24w400([Color? color]) =>
      _style(size: 24, weight: FontWeight.w400, color: color);

  /// -------- FontWeight.w500 --------

  static TextStyle s12w500([Color? color]) =>
      _style(size: 12, weight: FontWeight.w500, color: color);

  static TextStyle s14w500([Color? color]) =>
      _style(size: 14, weight: FontWeight.w500, color: color);

  static TextStyle s16w500([Color? color]) =>
      _style(size: 16, weight: FontWeight.w500, color: color);

  static TextStyle s18w500([Color? color]) =>
      _style(size: 18, weight: FontWeight.w500, color: color);

  static TextStyle s20w500([Color? color]) =>
      _style(size: 20, weight: FontWeight.w500, color: color);

  static TextStyle s22w500([Color? color]) =>
      _style(size: 22, weight: FontWeight.w500, color: color);

  static TextStyle s24w500([Color? color]) =>
      _style(size: 24, weight: FontWeight.w500, color: color);

  /// -------- FontWeight.w600 --------

  static TextStyle s14w600([Color? color]) =>
      _style(size: 14, weight: FontWeight.w600, color: color);

  static TextStyle s16w600([Color? color]) =>
      _style(size: 16, weight: FontWeight.w600, color: color);

  static TextStyle s18w600([Color? color]) =>
      _style(size: 18, weight: FontWeight.w600, color: color);

  static TextStyle s20w600([Color? color]) =>
      _style(size: 20, weight: FontWeight.w600, color: color);

  static TextStyle s22w600([Color? color]) =>
      _style(size: 22, weight: FontWeight.w600, color: color);

  static TextStyle s24w600([Color? color]) =>
      _style(size: 24, weight: FontWeight.w600, color: color);

  static TextStyle s28w600([Color? color]) =>
      _style(size: 28, weight: FontWeight.w600, color: color);

  /// -------- FontWeight.w700 --------

  static TextStyle s16w700([Color? color]) =>
      _style(size: 16, weight: FontWeight.w700, color: color);

  static TextStyle s18w700([Color? color]) =>
      _style(size: 18, weight: FontWeight.w700, color: color);

  static TextStyle s20w700([Color? color]) =>
      _style(size: 20, weight: FontWeight.w700, color: color);

  static TextStyle s24w700([Color? color]) =>
      _style(size: 24, weight: FontWeight.w700, color: color);

  static TextStyle s28w700([Color? color]) =>
      _style(size: 28, weight: FontWeight.w700, color: color);

  static TextStyle s32w700([Color? color]) =>
      _style(size: 32, weight: FontWeight.w700, color: color);

  static TextStyle s36w700([Color? color]) =>
      _style(size: 36, weight: FontWeight.w700, color: color);

  // bold
  static TextStyle s16Bold([Color? color]) =>
      _style(size: 16, weight: FontWeight.w700, color: color);
  static TextStyle s18Bold([Color? color]) =>
      _style(size: 18, weight: FontWeight.w700, color: color);
  static TextStyle s20Bold([Color? color]) =>
      _style(size: 20, weight: FontWeight.w700, color: color);
  static TextStyle s24Bold([Color? color]) =>
      _style(size: 24, weight: FontWeight.w700, color: color);
  static TextStyle s28Bold([Color? color]) =>
      _style(size: 28, weight: FontWeight.w700, color: color);
  static TextStyle s32Bold([Color? color]) =>
      _style(size: 32, weight: FontWeight.w700, color: color);
  static TextStyle s36Bold([Color? color]) =>
      _style(size: 36, weight: FontWeight.w700, color: color);
}
