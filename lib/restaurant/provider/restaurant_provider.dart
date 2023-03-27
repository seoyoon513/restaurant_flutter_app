import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_flutter_app/restaurant/model/restaurant_model.dart';
import 'package:restaurant_flutter_app/restaurant/repository/restaurant_repository.dart';

/// 캐시를 관리하기 위한 Provider -> StateNotifierProvider
final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);
    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<List<RestaurantModel>> {
  final RestaurantRepository repository;

  // 1. 기본 상태는 빈 리스트 []
  // 추후에 pagination 기능, restaurantDetail 가져오는 기능을 Provider 내부에서 수행한다
  // 가져온 데이터를 빈 리스트에 넣어주고
  // 리스트에 넣은 값들을 기억하여 화면에 보여준다
  RestaurantStateNotifier({
    required this.repository,
  }) : super([]) {
    paginate(); // 3. constructor body 내부에 paginate() 함수 실행 -> class 인스턴스가 생성이 될 때 실행
  }

  // 2. 요청 보내고 응답 받기
  paginate() async {
    final resp = await repository.paginate();

    state = resp.data; // 응답 받은 모델을 state 안에 저장
  }
}
