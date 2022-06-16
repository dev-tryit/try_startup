import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:try_startup/_common/flutter/widget/listTile/SingleSelectListTile.dart';
import '../_common/flutter/bottomSheet/AlertBottomSheet.dart';
import '../_common/flutter/bottomSheet/InputBottomSheet.dart';
import '../_common/flutter/controller/ValueController.dart';
import '../_common/flutter/effect/BouncingModalBottomEffect.dart';
import '../_common/flutter/widget/listTile/MultiSelectListTile.dart';
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
    List<S2Choice<String>> regions = [
      S2Choice<String>(value: 'seoul', title: '서울'),
      S2Choice<String>(value: 'incheon', title: '인천'),
      S2Choice<String>(value: 'busan', title: '부산'),
      S2Choice<String>(value: 'jeju', title: '제주'),
    ];

    final nameController = ValueController<String>("");
    final stateController = ValueController<String>("");
    final countryController = ValueController<String>("");
    final capitalController = ValueController<bool>(false);
    final populationController = ValueController<int>(0);
    // final regionsController = ValueController<String>(regions[0].value);
    final regionsController2 = ValueController<List<String>>(
        regions.sublist(0, 2).map((e) => e.value).toList());

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
          // SingleSelectListTile(titleText: "지역", controller: regionsController, choiceItems:regions),
          // const SizedBox(height: 10),
          MultiSelectListTile(
            titleText: "지역",
            controller: regionsController2,
            choiceItems: regions,
            modalConfirm: true,
          ),
          const SizedBox(height: 10),
        ],
      );
    });
  }
}
