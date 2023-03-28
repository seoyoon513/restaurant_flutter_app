import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_flutter_app/common/model/cursor_pagination_model.dart';
import 'package:restaurant_flutter_app/restaurant/component/restaurant_card.dart';
import 'package:restaurant_flutter_app/restaurant/provider/restaurant_provider.dart';
import 'package:restaurant_flutter_app/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // ListView의 스크롤이 변하면 scrollerListener 함수 실행됨
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    //print('run');
    // 현재 위치가
    // 최대 길이보다 조금 덜되는 위치까지 왔다면
    // 새로운 데이터를 추가요청
    // 현재 position > 최대 스크롤 가능한 길이 - 300
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(
          fetchMore: true // 새로운 데이터 붙여넣기
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    // 처음 로딩일 때
    if (data is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러일 때
    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    // CursorPagination
    // CursorPaginationFetchMore
    // CursorPaginationRefetching

    final cp = data as CursorPagination;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          controller: controller,
          itemCount: cp.data.length + 1, // 그릴 수 있는 개수 + 1
          itemBuilder: (_, index) {
            if (index == cp.data.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Center(
                  child: data is CursorPaginationFetchingMore
                      ? CircularProgressIndicator()
                      : Text("마지막 데이터입니다 ㅠㅠ"),
                ),
              );
            }

            // 1. 몇 개의 아이템을 렌더링할지 정의
            final pItem = cp.data[index]; // 2. 각 순서에 맞는 아이템을 불러오기

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
          },
          separatorBuilder: (_, index) {
            return SizedBox(height: 16.0);
          },
        ));

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
