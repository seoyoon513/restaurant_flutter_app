import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/common/component/custom_text_form_field.dart';

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white, // Scaffold의 기본 색상은 white가 아님
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              hintText: '이메일을 입력해주세요',
              onChanged: (String value) { },
            ),
            CustomTextFormField(
              hintText: '비밀번호를 입력해주세요',
              onChanged: (String value) { },
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}



