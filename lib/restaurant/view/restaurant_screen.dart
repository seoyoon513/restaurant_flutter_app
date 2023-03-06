import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/restaurant/component/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RestaurantCard(
          image: Image.asset(
            'asset/img/food/ddeok_bok_gi.jpg',
            fit: BoxFit.cover, // 전체 차지
          ),
          name: '불타는 떡볶이',
          tags: ['떡볶이', '치즈', '매운맛'],
          ratingCount: 100,
          deliveryTime: 15,
          deliveryFee: 2000,
          rating: 4.52),
    );
  }
}
