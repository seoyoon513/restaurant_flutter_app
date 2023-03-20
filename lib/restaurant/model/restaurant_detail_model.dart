import 'package:restaurant_flutter_app/restaurant/model/restaurant_model.dart';

import '../../common/const/data.dart';

class RestaurantDetailModel extends RestaurantModel {
  // 상속을 통해서 중복 값을 세팅
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values.firstWhere(
        (e) => e.name == json['priceRange'],
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      // product 안의 각각의 요소에 접근해서 매핑해주어야 함
      products: json['products'].map<RestaurantProductModel>( // 제네릭을 넣어주지 않으면 자동으로 dynamic 타입으로 지정됨
        (x) => RestaurantProductModel(
            id: x['id'],
            name: x['name'],
            imgUrl: x['imgUrl'],
            detail: x['detail'],
            price: x['price']),
      ).toList(), // 매핑을 받아서 리스트로 반환
    );
  }
}

class RestaurantProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });
}
