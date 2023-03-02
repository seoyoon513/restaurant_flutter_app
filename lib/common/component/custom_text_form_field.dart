import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  // 외부에서 정의
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final  ValueChanged<String>? onChanged;

  const CustomTextFormField({
    required this.onChanged, // 필수 구현
    this.autofocus = false,
    this.obscureText = false,
    this.hintText,
    this.errorText,
    Key? key
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 기본적으로 UnderlineInputBorder()가 적용되어 있음
    // 기본 border로 사용할 baseBorder 정의
    final baseBorder = OutlineInputBorder(
        borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0));

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      // 외부에서 추가적으로 textField마다 따로 정의해야 하는 것들 -> 파라미터로 정의
      obscureText: obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      decoration: InputDecoration( // 공통 스타일은 내부에 정의
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        fillColor: INPUT_BG_COLOR,
        // false - 배경색 없음
        // true - 배경색 있음
        filled: true,
        // 모든 input 상태의 기본 스타일 세팅
        border: baseBorder,
        enabledBorder: baseBorder, // 테두리 관련 파라미터
        focusedBorder: baseBorder.copyWith(
          //baseBorder의 모든 특성을 유지하면서 borderSide만 변경
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR, // borderSide의 color 변경
          ),
        ),
      ),
    ); // material 기본 위젯
  }
}
