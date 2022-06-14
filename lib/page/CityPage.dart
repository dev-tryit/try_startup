import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../_common/flutter/bottomSheet/AlertBottomSheet.dart';
import '../_common/flutter/bottomSheet/InputBottomSheet.dart';
import '../_common/flutter/effect/BouncingModalBottomEffect.dart';
import '../repository/CityRepository.dart';
import '../util/SnackBarUtil.dart';

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
    final TextEditingController titleController = TextEditingController();
    final TextEditingController keywordController = TextEditingController();

    BouncingModalBottomEffect.apply(context, builder: (popFunction) {
      return InputBottomSheet(
        title: "${r.collectionName} 요소 추가",
        buttonStr: '추가',
        onAdd: (void Function(String) setErrorMessage) {

        },
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            minLeadingWidth: 100,
            leading: const Text("분류 이름",
                style: TextStyle(fontSize: 12.5)),
            title: TextField(
              controller: titleController,
              decoration: const InputDecoration(isDense: true),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            minLeadingWidth: 100,
            leading: const Text("분류 기준 텍스트",
                style: TextStyle(fontSize: 12.5)),
            title: TextField(
              controller: keywordController,
              decoration: const InputDecoration(isDense: true),
            ),
          ),
          const SizedBox(height: 10),
        ],
      );
    });
  }
}
