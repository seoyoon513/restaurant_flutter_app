import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagination<T> {
  final CursorPaginationMeta meta;
  final List<T> data; // List 안에 들어가는 Class만 다름 -> generic으로 선언

  CursorPagination({
    required this.meta,
    required this.data
});

  // 타입이 들어왔을 때 json으로부터 어떻게 인스턴스화 하는지 정의가 필요함
  factory CursorPagination.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT)
  => _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });
  
  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json)
  => _$CursorPaginationMetaFromJson(json);
}
