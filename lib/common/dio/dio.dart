import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant_flutter_app/common/const/data.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1) 요청 보낼 때 (보내지기 전 호출)
  // 요청이 보내질 때마다 요청의 Headr에 accessToken : true라는 값이 있다면
  // 실제 토큰을 storage에서 가져와서 authorization: Bearer $token으로 변경
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}'); // 로그로 사용

    // 1. 보내려는 요청의 header에서 값을 가져와서
    if(options.headers['accessToken'] == 'true') {
      // 2. 헤더 삭제
      options.headers.remove('accessToken');
      
      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 3. 실제 토큰으로 대체
      options.headers.addAll({
        'authorization' : 'Bearer $token'
      });
    }

    // 1. 보내려는 요청의 header에서 값을 가져와서
    if(options.headers['refreshToken'] == 'true') {
      // 2. 헤더 삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // 3. 실제 토큰으로 대체
      options.headers.addAll({
        'authorization' : 'Bearer $token'
      });
    }
    return super.onRequest(options, handler);
  }
// 2) 응답 받을 때
// 3) 에러가 났을 때
}