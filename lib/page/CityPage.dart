import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../_common/animation/FastBouncingEffect.dart';
import '../_common/widget/bottomSheet/BouncingModalBottomSheet.dart';
import '../repository/CityRepository.dart';

class CityPage extends StatelessWidget {
  CityRepository get r => CityRepository.me;
  late BuildContext context;

  CityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
      body: FutureBuilder<List<City>>(
        future: r.getList(),
        builder: (context, snapshot) {
          bool isDone = snapshot.connectionState == ConnectionState.done;
          if (!isDone) {
            return const Center(child: CircularProgressIndicator());
          }

          List<City> cityList = snapshot.data ?? [];

          if (cityList.isEmpty) {
            return Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                      onPressed: createBottomSheet,
                      child: const Icon(Icons.add)),
                  const SizedBox(width: 10),
                  Text("${r.collectionName} 요소를 추가해주세요"),
                ],
              ),
            );
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              City city = cityList[index];
              return ListTile(
                title: Text(city.toFirestore().toString()),
              );
            },
          );
        },
      ),
    );
  }

  void createBottomSheet() {
    BouncingModalBottomSheet().show(context);
  }
}
