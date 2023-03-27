import 'package:dio/dio.dart' hide Headers;
import 'package:restaurant_flutter_app/common/dio/dio.dart';
import 'package:restaurant_flutter_app/common/model/cursor_pagination_model.dart';
import 'package:restaurant_flutter_app/common/model/pagination_params.dart';
import 'package:restaurant_flutter_app/restaurant/model/restaurant_detail_model.dart';
import 'package:restaurant_flutter_app/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/const/data.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

    return repository;
  },
);

@RestApi()
abstract class RestaurantRepository {
  // retrofit standard 구조
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // 레스토랑 스크린
  // http://$ip/restaurant
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate({
    // 특정 cursor의 다음 값들을 가져오려면 파라미터 필요
    // build type const여야 하므로 const로 정의
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  // 레스토랑 디테일 스크린
  // http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
