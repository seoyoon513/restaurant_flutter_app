import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/user/view/login_screen.dart';

void main() {
  runApp(
    _App()
  );
}

class _App extends StatelessWidget { // 위젯으로 한 번 감싸주기
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans', // 기본 폰트 설정
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
    );
  }
}



