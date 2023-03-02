import 'package:flutter/material.dart';

/**
 * 모든 View에 공통 기능을 적용할 때 유용한 Default Widget
 */
class DefaultLayout extends StatelessWidget {
  final Widget child; // 1. 외부에서 child로 받는 것은

  const DefaultLayout({
    required this.child,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: child, // 2. Scaffold에 전달
    );
  }
}
