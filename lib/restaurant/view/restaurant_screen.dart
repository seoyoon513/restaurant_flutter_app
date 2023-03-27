import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_flutter_app/restaurant/component/restaurant_card.dart';
import 'package:restaurant_flutter_app/restaurant/provider/restaurant_provider.dart';
import 'package:restaurant_flutter_app/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    if (data.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemCount: data.length,
          itemBuilder: (_, index) {
            // 1. 몇 개의 아이템을 렌더링할지 정의
            final pItem = data[index]; // 2. 각 순서에 맞는 아이템을 불러오기

            return GestureDetector(
              // 1. GestureDetector로 감싸기
              onTap: () {
                // 2. 눌렀을 때 페이지 이동
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        RestaurantDetailScreen(
                          id: pItem.id,
                        ),
                  ),
                );
              },
              child: RestaurantCard.fromModel(model: pItem),
            );
          },
          separatorBuilder: (_, index) {
            return SizedBox(height: 16.0);
          },
        )
    );


    // FutureBuilder<CursorPagination<RestaurantModel>>(
    //   future: ref.watch(restaurantRepositoryProvider).paginate(),
    //   builder: (context, AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
    //     if (!snapshot.hasData) {
    //       return Center(
    //         child: CircularProgressIndicator(), // 로딩 추가
    //       );
    //     }
    //
    //
    //   },
    // ));
  }
}
