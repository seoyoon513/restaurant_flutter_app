import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

/// class로 상태 구분
// 상태를 구분하기 위해서는 base class 필요 (abstract로 선언하여 인스턴스 생성 x)
// base class를 상속하는 형태로 구현 -> oop 개념
abstract class CursorPaginationBase {}

// error 상태
class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

// loading 상태
class CursorPaginationLoading extends CursorPaginationBase {}

@JsonSerializable(
  genericArgumentFactories: true,
)
// 값을 받아올 때의 상태
class CursorPagination<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  final List<T> data; // List 안에 들어가는 Class만 다름 -> generic으로 선언

  CursorPagination({required this.meta, required this.data});

  // 타입이 들어왔을 때 json으로부터 어떻게 인스턴스화 하는지 정의가 필요함
  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

// 새로고침 상태
// meta와 data가 이미 존재하는 상태에서 수행되므로 CursorPagination을 상속
// 상속 룰에 따라 CursorPagination, CursorPaginationBase 모두 extends를 하는 것
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

// 리스트의 맨 아래로 내려서
// 추가 데이터를 요청하는 중
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}
