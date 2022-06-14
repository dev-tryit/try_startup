import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../_common/flutter/bottomSheet/AlertBottomSheet.dart';
import '../_common/flutter/bottomSheet/InputBottomSheet.dart';
import '../_common/flutter/controller/ValueController.dart';
import '../_common/flutter/effect/BouncingModalBottomEffect.dart';
import '../_common/flutter/widget/listTile/SwitchInput.dart';
import '../_common/flutter/widget/listTile/IntListTile.dart';
import '../_common/flutter/widget/listTile/TextFieldInput.dart';
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
    final nameController = ValueController<String>("");
    final stateController = ValueController<String>("");
    final countryController = ValueController<String>("");
    final capitalController = ValueController<bool>(false);
    final populationController = ValueController<int>(0);

    BouncingModalBottomEffect.apply(context, builder: (popFunction) {
      return InputBottomSheet(
        title: "${r.collectionName} 요소 추가",
        buttonStr: '추가',
        onAdd: (void Function(String) setErrorMessage) {},
        children: [
          TextFieldInput(titleText: "도시 이름", controller: nameController),
          const SizedBox(height: 10),
          TextFieldInput(titleText: "상태", controller: stateController),
          const SizedBox(height: 10),
          TextFieldInput(titleText: "나라 이름", controller: countryController),
          const SizedBox(height: 10),
          SwitchInput(titleText: "수도인지?", controller: capitalController),
          const SizedBox(height: 10),
          IntListTile(titleText: "인구수", controller: populationController),
          const SizedBox(height: 10),
        ],
      );
    });
  }
}
