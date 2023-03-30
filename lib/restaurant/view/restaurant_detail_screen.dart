import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_flutter_app/common/layout/default_layout.dart';
import 'package:restaurant_flutter_app/product/component/product_card.dart';
import 'package:restaurant_flutter_app/restaurant/component/restaurant_card.dart';
import 'package:restaurant_flutter_app/restaurant/model/restaurant_detail_model.dart';
import 'package:restaurant_flutter_app/restaurant/provider/restaurant_provider.dart';
import 'package:restaurant_flutter_app/restaurant/repository/restaurant_repository.dart';

import '../model/restaurant_model.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  // 1. Repository를 Provider로 작업
  // Future<RestaurantDetailModel> getRestaurantDetail(WidgetRef ref) async {
  //   return ref.watch(restaurantRepositoryProvider).getRestaurantDetail(
  //         id: id,
  //       );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 캐시 공유 provider watch
    final state = ref.watch(restaurantDetailProvider(id));

    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }


    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          renderTop(
            model: state!,
          ),
          // renderLabel(),
          // renderProducts(
          //   products: snapshot.data!.products,
          // ),
        ],
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(model: model),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }
}
