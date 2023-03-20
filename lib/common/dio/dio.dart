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
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}'); // 로그로 사용

    // 1. 보내려는 요청의 header에서 값을 가져와서
    if (options.headers['accessToken'] == 'true') {
      // 2. 헤더 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 3. 실제 토큰으로 대체
      options.headers.addAll({'authorization': 'Bearer $token'});
    }

    // 1. 보내려는 요청의 header에서 값을 가져와서
    if (options.headers['refreshToken'] == 'true') {
      // 2. 헤더 삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // 3. 실제 토큰으로 대체
      options.headers.addAll({'authorization': 'Bearer $token'});
    }
    return super.onRequest(options, handler); // 요청이 보내지는 순간
  }

  // 2) 응답 받을 때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');
    return super.onResponse(response, handler);
  }
  // 3) 에러가 났을 때
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    // 401 error (status code)
    // 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면
    // 다시 새로운 토큰으로 요청한다
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refreshToken 아예 없으면
    // 에러를 던진다
    if (refreshToken == null) {
      return handler.reject(err); // 에러 생성시킬 때는 handler.reject 사용
    }

    // 응답이 없을 수도 있으니 nullable
    final isStatus401 = err.response?.statusCode == 401;

    // token을 refresh 하려다가 에러가 난 경우 -> refreshToken 자체의 문제
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      // 1. accessToken을 필요로 하는 요청에서 error가 났음
      final dio = Dio();

      try {
        // 2. 가지고 있던 refreshToken으로 새로운 토큰 발급
        final resp = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final accessToken = resp.data['accessToken'];
        final options = err.requestOptions;

        // 새로 발급받은 토큰으로 헤더 업데이트
        options.headers.addAll({
          'authorization': 'Bearer $accessToken'
        });

        // 새로 발급받은 토큰을 스토리지에 저장
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 다시 재요청 (에러를 발생시킨 토큰만 바꾼 채로)
        final response = await dio.fetch(options);

        // 재요청한 결과를 던진다. 마치 에러가 나지 않는 것처럼.
        return handler.resolve(response);

      } on DioError catch (e) {
        return handler.reject(e);
      }
    }


    return handler.reject(err);
  }
}
