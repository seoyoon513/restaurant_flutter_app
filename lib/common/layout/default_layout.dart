import 'package:flutter/material.dart';

/**
 * 모든 View에 공통 기능을 적용할 때 유용한 Default Widget
 */
class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor; // nullable로 선언
  final Widget child; // 1. 외부에서 child로 받는 것은

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      body: child, // 2. Scaffold에 전달
    );
  }
}
