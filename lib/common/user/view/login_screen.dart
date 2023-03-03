import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/common/const/colors.dart';
import 'package:restaurant_flutter_app/common/layout/default_layout.dart';
import 'package:restaurant_flutter_app/common/view/root_tab.dart';

import '../../component/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    // localhost
    final emulatorIp = '10.0.2.2:3000'; // 애뮬레이터는 '10.0.0.2' 가 localhost와 동일
    final simulatorIp = '127.0.0.1:3000'; // 시뮬레이터는 localhost와 동일

    // 어떤 OS에서 코드가 실행되는지 알 수 있는 메서드
    final ip = Platform.isIOS ? simulatorIp : emulatorIp;

    return DefaultLayout(
      // DefaultLayout으로 한 번 감싼다
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag, // drag 했을 때 키보드 사라짐
        child: SafeArea( // 디바이스 영역이 앱의 위젯 영역을 침범하는 것을 막아준다
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // 좌우를 꽉 차게 배치
              children: [
                _Title(),
                const SizedBox(height: 16.0), // children 사이에 간격 두기
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2, // 전체 화면 너비의 2/3 사이즈
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요',
                  onChanged: (String value) { // 값이 바뀔 때마다 콜백 호출
                    username = value;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    // ID:비밀번호
                    final rawString = '$username:$password';

                    // 변환 정의
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    // String -> Base64 인코딩
                    String token = stringToBase64.encode(rawString);

                    final resp = await dio.post('http://$ip/auth/login',
                        options: Options(
                          headers: {
                            'authorization' : 'Basic $token'
                          },
                        ),
                    );
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RootTab(),
                        )
                    );
                    print(resp.data); // 응답 받은 데이터 값 (body)
                  },
                  style: ElevatedButton.styleFrom(
                    //primary: PRIMARY_COLOR, - deprecated
                    backgroundColor: PRIMARY_COLOR, // 색 변화가 없음
                  ),
                  child: Text(
                      '로그인'
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final refreshToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTY3NzgwMzM0NCwiZXhwIjoxNjc3ODg5NzQ0fQ.4fQCW6fMIQ-pounjLsBeCskHTPEypg3WxMUGenbG4qw';

                    final resp = await dio.post('http://$ip/auth/token',
                      options: Options(
                        headers: {
                          'authorization' : 'Bearer $refreshToken'
                        },
                      ),
                    );
                    print(resp.data);
                  },
                  style: TextButton.styleFrom(
                    //primary: Colors.black, - deprecated
                    foregroundColor: Colors.black, // 색 변화가 없음
                  ),
                  child: Text('회원가입'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w500,
          color: Colors.black
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길:)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
