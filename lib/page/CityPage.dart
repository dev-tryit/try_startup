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
    BouncingModalBottomSheet(
      context,
      child: AlertBottomSheet(
        alertMessageText: '아이디와 비밀번호가 일치하지 않습니다.',
        alertButtonText: '확인',
        onPressed: () {},
      ),
    ).show();
  }
}

class AlertBottomSheet extends StatelessWidget {
  String alertMessageText;
  String alertButtonText;
  VoidCallback onPressed;

  AlertBottomSheet(
      {Key? key,
      required this.alertMessageText,
      required this.alertButtonText,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(9),
          topRight: Radius.circular(9),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(alertMessageText),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(20)),
              onPressed: onPressed,
              child: Text(
                alertButtonText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
