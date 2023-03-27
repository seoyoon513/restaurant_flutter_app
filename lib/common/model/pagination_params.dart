import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

/// paginate()에 들어갈 param을 class로 정의
@JsonSerializable()
class PaginationParams {
  final String? after;
  final int? count;

  const PaginationParams({
    this.after,
    this.count,
  });
  
  factory PaginationParams.fromJson(Map<String, dynamic> json)
  => _$PaginationParamsFromJson(json);

  // 직접 넣은 값을 json으로 변환해서 보내야 함
  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
