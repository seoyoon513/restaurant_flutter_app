import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_flutter_app/common/utils/data_utils.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange { expensive, medium, cheap }

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl, // json으로부터 인스턴스를 만들 때 실행하고 싶은 함수
    //toJson: , // json으로 변경이 될 때 실행하고 싶은 함수
  )
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

  factory RestaurantModel.fromJson(Map<String, dynamic> json)
  => _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  // factory constructor
//   factory RestaurantModel.fromJson({ // json -> model 매핑 과정을 모델에서 진행
//     required Map<String, dynamic> json,
//   }) {
//     return RestaurantModel(
//         id: json['id'],
//         name: json['name'],
//         thumbUrl: 'http://$ip${json['thumbUrl']}',
//         tags: List<String>.from(json['tags']),
//         priceRange: RestaurantPriceRange.values.firstWhere(
//               (e) => e.name == json['priceRange'],
//         ),
//         ratings: json['ratings'],
//         ratingsCount: json['ratingsCount'],
//         deliveryTime: json['deliveryTime'],
//         deliveryFee: json['deliveryFee']);
//   }
}
