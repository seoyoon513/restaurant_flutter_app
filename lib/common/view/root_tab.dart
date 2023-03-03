import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/common/layout/default_layout.dart';

class RootTab extends StatelessWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: Text('RootTab'),
      ),
    );
  }
}
