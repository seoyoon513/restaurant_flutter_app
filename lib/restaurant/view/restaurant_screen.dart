import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_flutter_app/common/model/cursor_pagination_model.dart';
import 'package:restaurant_flutter_app/restaurant/component/restaurant_card.dart';
import 'package:restaurant_flutter_app/restaurant/model/restaurant_model.dart';
import 'package:restaurant_flutter_app/restaurant/repository/restaurant_repository.dart';
import 'package:restaurant_flutter_app/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<CursorPagination<RestaurantModel>>(
          future: ref.watch(restaurantRepositoryProvider).paginate(),
          builder: (context, AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(), // 로딩 추가
              );
            }

            return ListView.separated(
              itemBuilder: (_, index) {
                // 1. 몇 개의 아이템을 렌더링할지 정의
                final pItem = snapshot.data!.data[index]; // 2. 각 순서에 맞는 아이템을 불러오기

                return GestureDetector(
                  // 1. GestureDetector로 감싸기
                  onTap: () {
                    // 2. 눌렀을 때 페이지 이동
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
              itemCount: snapshot.data!.data.length,
            );
          },
        ));
  }
}
