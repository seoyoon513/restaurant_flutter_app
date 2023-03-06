import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/common/const/colors.dart';

class RestaurantCard extends StatelessWidget {
  // 이미지
  final Widget image;

  // 레스토랑 이름
  final String name;

  // 태그
  final List<String> tags;

  // 평점 개수
  final int ratingCount;

  // 배송 걸리는 시간
  final int deliveryTime;

  // 배송 비용
  final int deliveryFee;

  // 평균 평점
  final double rating;

  const RestaurantCard(
      {required this.image,
      required this.name,
      required this.tags,
      required this.ratingCount,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.rating,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          // 이미지 테두리를 깎는 위젯
          borderRadius: BorderRadius.circular(12.0),
          child: image,
        ),
        const SizedBox(height: 16.0),
        Column(
          // 1. 글자정렬을 위해 Column으로 감싸기
          crossAxisAlignment: CrossAxisAlignment.stretch, // 2. 왼쪽 정렬
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              tags.join(' · '),
              style: TextStyle(
                color: BODY_TEXT_COLOR,
                fontSize: 14.0,
              ), // 텍스트 합치기
            )
          ],
        )
      ],
    );
  }
}

