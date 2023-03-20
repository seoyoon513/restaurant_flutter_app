import 'package:dio/dio.dart' hide Headers;
import 'package:restaurant_flutter_app/common/model/cursor_pagination_model.dart';
import 'package:restaurant_flutter_app/restaurant/model/restaurant_detail_model.dart';
import 'package:restaurant_flutter_app/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

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
  Future<CursorPagination<RestaurantModel>>paginate();

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
