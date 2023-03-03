import 'package:flutter/material.dart';

/**
 * 모든 View에 공통 기능을 적용할 때 유용한 Default Widget
 */
class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor; // nullable로 선언
  final Widget child; // 1. 외부에서 child로 받는 것은
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: child, // 2. Scaffold에 전달
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) { // 2. null 처리
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!, // 1. Text 위젯에는 null이 들어갈 수 없음
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black, // AppBar 위에 올라가는 위젯 색깔
      );
    }
  }
}
