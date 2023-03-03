import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/common/const/colors.dart';
import 'package:restaurant_flutter_app/common/layout/default_layout.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int index = 0; // 탭 저장

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) { // 클릭한 index를 파라미터로 받는다
          setState(() {
            this.index = index; // 1. class index에 선택된 index를 저장
          });
          // print(index);
        },
        currentIndex: index, // 2. currentIndex에 값 넣어주기
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined),
              label: '음식'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              label: '주문'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: '프로필'
          ),
        ],
      ),
      child: Center(
        child: Text('RootTab'),
      ),
    );
  }
}
