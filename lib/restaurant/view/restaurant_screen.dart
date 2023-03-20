import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/restaurant/component/restaurant_card.dart';
import 'package:restaurant_flutter_app/restaurant/model/restaurant_model.dart';
import 'package:restaurant_flutter_app/restaurant/view/restaurant_detail_screen.dart';

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
              return Center(
                child: CircularProgressIndicator(), // 로딩 추가
              );
            }

            return ListView.separated(
              itemBuilder: (_, index) {
                // 1. 몇 개의 아이템을 렌더링할지 정의
                final item = snapshot.data![index]; // 2. 각 순서에 맞는 아이템을 불러오기
                // parsed:변환됐다
                final pItem = RestaurantModel.fromJson(json: item);

                return GestureDetector(
                  // 1. GestureDetector로 감싸기
                  onTap: () { // 2. 눌렀을 때 페이지 이동
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailScreen(
                          id: pItem.id,
                        ),
                      ),
                    );
                  },
                  child: RestaurantCard.fromModel(model: pItem),
                );
                //   RestaurantCard(
                //   image: Image.network(
                //     pItem.thumbUrl,
                //     //'http://$ip${item['thumbUrl']}',
                //     fit: BoxFit.cover,
                //   ),
                //   name: pItem.name,
                //   tags: pItem.tags,
                //   // dynamic 타입을 String 타입으로 받는다
                //   ratingsCount: pItem.ratingsCount,
                //   deliveryTime: pItem.deliveryTime,
                //   deliveryFee: pItem.deliveryFee,
                //   ratings: pItem.ratings,
                // );
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
