import 'package:flutter/material.dart';

extension ContextHealpers on BuildContext {
  /// ───────────── Screen Size ─────────────
  Size get screenSize => MediaQuery.of(this).size;

  double get width => screenSize.width;
  double get height => screenSize.height;

  /// ───────────── Padding & SafeArea ─────────────
  EdgeInsets get padding => MediaQuery.of(this).padding;
  double get topPadding => padding.top;
  double get bottomPadding => padding.bottom;
  double get leftPadding => padding.left;
  double get rightPadding => padding.right;

  /// ───────────── Theme Shortcuts ─────────────
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  /// ───────────── MediaQuery Shortcuts ─────────────
  TextScaler get textScale => MediaQuery.of(this).textScaler;

  /// ───────────── Keyboard & Focus ─────────────
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
