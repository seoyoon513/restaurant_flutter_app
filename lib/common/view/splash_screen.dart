import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/common/const/data.dart';
import 'package:restaurant_flutter_app/common/layout/default_layout.dart';
import 'package:restaurant_flutter_app/common/view/root_tab.dart';
import 'package:restaurant_flutter_app/user/view/login_screen.dart';

import '../const/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // 위젯이 처음 생성되었을 때 하는 작업
    super.initState();

    //deleteToken();
    checkToken();
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();

    try {
      final resp = await dio.post('http://$ip/auth/token',
        options: Options(
          headers: {
            'authorization' : 'Bearer $refreshToken'
          },
        ),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => RootTab(),
        ),
            (route) => false,
      );
    } catch(e) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width, // 1. 너비를 최대로 하면
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 2. 좌우로도 가운데 정렬
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(
                height: 16.0,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
