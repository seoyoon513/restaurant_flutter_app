import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/common/const/colors.dart';
import 'package:restaurant_flutter_app/common/layout/default_layout.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

// vsync 사용 시 with SingleTickerProviderStateMixin 추가
class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller; // ?를 붙이면 컨트롤러 사용할 때마다 널처리를 해줘야 함
  int index = 0; // 탭 저장

  @override
  void initState() {
    super.initState();
    // length = 컨트롤 할 개수 = TabBarView의 리스트 요소 개수
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(tabListener);
  }

  void tabListener() { // controller에 변화가 있을 때마다 setState() 실행
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: TabBarView(
        controller: controller,
        children: [
          Center(
            child: Container(
              child: Text('홈'),
            ),
          ),
          Center(
            child: Container(
              child: Text('음식'),
            ),
          ),
          Center(
            child: Container(
              child: Text('주문'),
            ),
          ),
          Center(
            child: Container(
              child: Text('프로필'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index); // 하단 선택 아이콘 표시를 위해 리스너 추가
          // 클릭한 index를 파라미터로 받는다
          // setState(() {
          //   this.index = index; // 1. class index에 선택된 index를 저장
          // });
          // print(index);
        },
        currentIndex: index,
        // 2. currentIndex에 값 넣어주기
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined), label: '음식'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: '주문'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined), label: '프로필'),
        ],
      ),
    );
  }
}
