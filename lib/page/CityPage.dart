import 'package:flutter/material.dart';

import '../repository/CityRepository.dart';

class CityPage extends StatelessWidget {
  CityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CityRepository.me.getList(),
      builder: (context, snapshot) {
        bool isDone = snapshot.connectionState==ConnectionState.done;
        if(!isDone) {
          return const Center(child: CircularProgressIndicator());
        }

        return Container(width: 100, height: 100, color: Colors.red);
      },
    );
  }
}
