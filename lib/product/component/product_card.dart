import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/restaurant/component/restaurant_card.dart';

class ProdcutCard extends StatelessWidget {
  const ProdcutCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RestaurantCard(
          image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
          name: '불타는 떡볶이',
          tags: ['떡볶이', '맛있음', '치즈'],
          ratingsCount: 100,
          deliveryTime: 30,
          deliveryFee: 3000,
          ratings: 4.76,
          isDetail: true,
          detail: '맛있는 떡볶이',
        )
      ],
    );
  }
}
