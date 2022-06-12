import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../_common/animation/FastBouncingWidget.dart';
import '../repository/CityRepository.dart';

class CityPage extends StatelessWidget {
  CityRepository get r => CityRepository.me;
  late BuildContext context;
  late AnimationController bounceAnimateController;

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
    showMaterialModalBottomSheet(
      expand: true,
      enableDrag: true,
      bounce: true,
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Column(
          children: [
            Expanded(child: GestureDetector(
              onTap: () {
                bounceAnimateController.reset();
                bounceAnimateController.forward().then((value) {
                  bounceAnimateController.reverse();
                });
                print("click");
              },
            )),
            FastBouncingWidget(
              animationControllerSender: (controller) =>
                  bounceAnimateController = controller,
              child: Container(
                height: 100,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
