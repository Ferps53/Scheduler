import 'dart:ui';

enum AppColors {
  infoColors(
    Color(0xff03045e),
    Color(0xff0077b6),
    Color(0xff00b4d8),
    Color(0xff90e0ef),
    Color(0xffcaf0f8),
  ),
  danger(
    Color(0xffA80808),
    Color(0xffD30808),
    Color(0xffFF3E3E),
    Color(0xffFF7272),
    Color(0xffFFB9B9),
  ),
  success(
    Color(0xff000C00),
    Color(0xff004000),
    Color(0xff008000),
    Color(0xff7FBF7F),
    Color(0xffE5F2E5),
  ),
  warn(
    Color(0xffe47200),
    Color(0xffe6b400),
    Color(0xffe5de00),
    Color(0xffece75f),
    Color(0xfff7f5bc),
  );

  const AppColors(
    this.textColor,
    this.baseColor,
    this.primaryColor,
    this.lightColor,
    this.backgroundColor,
  );

  final Color textColor;
  final Color baseColor;
  final Color primaryColor;
  final Color lightColor;
  final Color backgroundColor;
}
