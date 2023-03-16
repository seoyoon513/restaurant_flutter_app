import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/common/const/colors.dart';
import 'package:restaurant_flutter_app/restaurant/component/restaurant_card.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      // 3. 내부 위젯들이 최대 크기를 차지한 위젯만큼 크기 차지하도록 최 상단의 위젯을 변경한다
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
            child: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            // 2. Expanded를 해도 각 자식 위젯에 크기에 맞춰지기 때문이다
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // 1. spaceBetween으로 했지만 변화가 없다
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '떡볶이',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '전통 떡볶이의 정성!\n맛있습니다.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // 글자가 최대 줄 수를 넘었을 때
                  style: TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  '₩10000',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
