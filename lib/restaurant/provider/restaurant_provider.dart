import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_flutter_app/common/model/cursor_pagination_model.dart';
import 'package:restaurant_flutter_app/common/model/pagination_params.dart';
import 'package:restaurant_flutter_app/restaurant/model/restaurant_model.dart';
import 'package:restaurant_flutter_app/restaurant/repository/restaurant_repository.dart';

/// 캐시를 공유하기 위한 Provider
//home -> detail
final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
      final state = ref.watch(restaurantProvider);

      if (state is! CursorPagination<RestaurantModel>) {
        return null;
      }
      
      return state.data.firstWhere((element) => element.id == id); // 동일 아이디 데이터 가져오기
});

/// 캐시를 관리하기 위한 Provider -> StateNotifierProvider
final restaurantProvider =
// 2-1.List<RestaurantModel>이 아닌 CursorPagination을 받아야 다음 페이지를 요청할 수 있음
// meta 정의 확인
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);
    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  // 1. 기본 상태는 빈 리스트 []
  // 추후에 pagination 기능, restaurantDetail 가져오는 기능을 Provider 내부에서 수행한다
  // 가져온 데이터를 빈 리스트에 넣어주고
  // 리스트에 넣은 값들을 기억하여 화면에 보여준다
  RestaurantStateNotifier({
    required this.repository,
    // 2-2. 생성되는 시점에서는 meta와 data에 어떤 값이 들어갈 지 모르는 상태
    // 즉, 실행되기 전(로딩)의 상태가 들어가야 함 -> 새로운 클래스를 만들어 상태 구분
  }) : super(CursorPaginationLoading()) {
    paginate(); // 3. constructor body 내부에 paginate() 함수 실행 -> class 인스턴스가 생성이 될 때 실행
  }

  // 2. 요청 보내고 응답 받기
  void paginate({
    // 한 번에 받아오는 값의 개수
    int fetchCount = 20,
    // 추가로 데이터 가져올지 여부
    // true -  추가로 데이터 더 가져옴
    // false - 새로고침 (현재 상태 덮어씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true - CursorPaginationLoading()
    bool forceRefetch = false,
  }) async {
    // 5가지 가능성
    // state의 상태
    // 1) CursorPagination - 정상적으로 데이터가 있는 상태
    // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
    // 3) CursorPaginationError - 에러가 있는 상태
    // 4) CursorPaginationRefetching - 첫 번째 페이지부터 다시 데이터를 가져올 때
    // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을 때

    // [바로 반환하는 상황]
    // 1) hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 들고있다면)
    // 2) 로딩중 - fetchMore : true (맨 아래까지 내려가서 데이터 추가로 가져올 때)
    //   로딩중에 fetchMore가 아닐 때 - 새로고침의 의도가 있을 수 있다

    try {
      if (state is CursorPagination && !forceRefetch) {
        // if문을 통과했으면 무조건 CursorPagination이므로 캐스팅
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return; // 바로 반환해서 paginate를 실행하지 않는다
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      // PaginationParams 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore
      // 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        // 데이터를 무조건 들고 있는 상황인 조건
        final pState = state as CursorPagination;

        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        // 어떤 데이터 다음으로 가져와야 할지 결정 -> after를 넣어주어야 함
        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      }
      // 데이터를 처음부터 가져오는 상황
      else {
        // 만약에 데이터가 있는 상황이라면
        // 기존 데이터를 보존한채로 Fetch(API 요청)를 진행
        if (state is CursorPagination && !forceRefetch) {
          // 데이터를 유지한 채로 로딩
          final pState = state as CursorPagination;
          state = CursorPaginationRefetching(
            meta: pState.meta,
            data: pState.data,
          );
        } else {
          state = CursorPaginationLoading();
        }
      }

      // 위에 상태가 어떻게 되었든 데이터는 가져와야 함 (처음 20개의 데이터)
      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        // 기존 데이터 + 새로 들어온 데이터
        state = resp.copyWith(
            data: [
              ...pState.data,
              ...resp.data,
            ]
        );
      } else {
        state = resp;
      }

    } catch(e) {
      state = CursorPaginationError(message: "데이터를 가져오지 못했습니다.");
    }
  }
}
