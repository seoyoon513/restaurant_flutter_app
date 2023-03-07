import '../../common/const/data.dart';

enum RestaurantPriceRange { expensive, medium, cheap }

class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    // RestaurantModel 생성 시 아래 값을 파라미터로 넣어줘야 함
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  // factory constructor
  factory RestaurantModel.fromJson({ // json -> model 매핑 과정을 모델에서 진행
    required Map<String, dynamic> json,
  }) {
    return RestaurantModel(
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
        deliveryFee: json['deliveryFee']);
  }
}
