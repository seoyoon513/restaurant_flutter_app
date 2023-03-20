import 'package:dio/dio.dart' hide Headers;
import 'package:restaurant_flutter_app/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // retrofit standard 구조
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
  _RestaurantRepository;


  // 레스토랑 스크린
  // http://$ip/restaurant
  // @GET('/')
  // paginate();

  // 레스토랑 디테일 스크린
  // http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({
    'authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNjc5MjkyMjIzLCJleHAiOjE2NzkyOTI1MjN9.MX6i4WW_nDSvKO4VMhbqqucuj3XeMiolOsADg-Tu7dI'
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
