import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/restaurant/component/restaurant_card.dart';

import '../../common/const/data.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken =
        await storage.read(key: ACCESS_TOKEN_KEY); // accessToken 가져오기

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(headers: {
        'authorization': 'Bearer $accessToken',
      }),
    );
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List>(
          future: paginateRestaurant(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            return ListView.separated(
              itemBuilder: (_, index) { // 1. 몇 개의 아이템을 렌더링할지 정의
                final item = snapshot.data![index]; // 2. 각 순서에 맞는 아이템을 불러오기
                return RestaurantCard(
                  image: Image.network(
                    'http://$ip${item['thumbUrl']}',
                    fit: BoxFit.cover,
                  ),
                  name: item['name'],
                  tags: List<String>.from(item['tags']), // dynamic 타입을 String 타입으로 받는다
                  ratingsCount: item['ratingsCount'],
                  deliveryTime: item['deliveryTime'],
                  deliveryFee: item['deliveryFee'],
                  ratings: item['ratings'],
                );
              },
              separatorBuilder: (_, index) {
                return SizedBox(height: 16.0);
              },
              itemCount: snapshot.data!.length,
            );
          },
        ));
  }
}
