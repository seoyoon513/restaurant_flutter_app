import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/common/layout/default_layout.dart';

import '../../component/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout( // DefaultLayout으로 한 번 감싼다
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            hintText: '이메일을 입력해주세요',
            onChanged: (String value) {},
          ),
          CustomTextFormField(
            hintText: '비밀번호를 입력해주세요',
            onChanged: (String value) {},
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
