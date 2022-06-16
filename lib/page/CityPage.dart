import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import '../_common/flutter/bottomSheet/AlertBottomSheet.dart';
import '../_common/flutter/bottomSheet/InputBottomSheet.dart';
import '../_common/flutter/controller/ValueController.dart';
import '../_common/flutter/effect/BouncingModalBottomEffect.dart';
import '../_common/flutter/widget/listTile/MultiSelectListTile.dart';
import '../_common/flutter/widget/listTile/SwitchInput.dart';
import '../_common/flutter/widget/listTile/IntListTile.dart';
import '../_common/flutter/widget/listTile/TextFieldInput.dart';
import '../_common/model/exception/CommonException.dart';
import '../repository/CityRepository.dart';

class CityPage extends StatefulWidget {
  CityPage({Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  final inputBottomSheetPopController = BackController();
  final alertBottomSheetPopController = BackController();

  late List<S2Choice<String>> regions;
  late ValueController<String> nameController;
  late ValueController<String> stateController;
  late ValueController<String> countryController;
  late ValueController<bool> capitalController;
  late ValueController<int> populationController;
  late ValueController<List<String>> regionsController2;
  late CityPageService s;

  CityRepository get r => CityRepository.me;

  @override
  void initState() {
    s = CityPageService(this);

    regions = [
      S2Choice<String>(value: 'seoul', title: '서울'),
      S2Choice<String>(value: 'incheon', title: '인천'),
      S2Choice<String>(value: 'busan', title: '부산'),
      S2Choice<String>(value: 'jeju', title: '제주'),
    ];

    nameController = ValueController<String>("");
    stateController = ValueController<String>("");
    countryController = ValueController<String>("");
    capitalController = ValueController<bool>(false);
    populationController = ValueController<int>(0);
    regionsController2 = ValueController<List<String>>(
        regions.sublist(0, 2).map((e) => e.value).toList());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<City>>(
      future: r.getList(),
      builder: (context, snapshot) {
        bool isDone = snapshot.connectionState == ConnectionState.done;
        if (!isDone) {
          return const Center(child: CircularProgressIndicator());
        }

        FloatingActionButton floatingActionButton = FloatingActionButton(
            onPressed: createBottomSheet, child: const Icon(Icons.add));

        List<City> cityList = snapshot.data ?? [];

        if (cityList.isEmpty) {
          return Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                floatingActionButton,
                const SizedBox(width: 10),
                Text("${r.collectionName} 요소를 추가해주세요"),
              ],
            ),
          );
        }

        return Scaffold(
          floatingActionButton:
              cityList.isNotEmpty ? floatingActionButton : null,
          body: ListView.builder(
            itemCount: cityList.length,
            itemBuilder: (context, index) {
              City city = cityList[index];
              return Card(
                child: ListTile(
                  title: Text(city.toFirestore().toString()),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void createBottomSheet() async {
    await InputBottomSheet.show(
      context,
      title: "${r.collectionName} 요소 추가",
      buttonStr: '추가',
      onAdd: s.createCity,
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
      backController: inputBottomSheetPopController,
    );
  }
}

class CityPageService {
  _CityPageState state;

  CityPageService(this.state);

  Future<void> createCity(
      void Function(String errorMessage) setErrorMessage) async {
    var context = state.context;

    var city = City(
      name: state.nameController.value,
      capital: state.capitalController.value,
      country: state.countryController.value,
      state: state.stateController.value,
      population: state.populationController.value,
      regions: state.regionsController2.value,
    );

    try {
      city.throwInputError();
      await CityRepository.me.save(city);
      await AlertBottomSheet.show(
        context,
        alertMessageText: "${state.r.collectionName} 요소 추가에 성공하였습니다.",
        backController: state.alertBottomSheetPopController,
      );
      state.inputBottomSheetPopController.back();
    } catch (e) {
      if (e is CommonException) {
        await AlertBottomSheet.show(
          context,
          alertMessageText: e.message,
          backController: state.alertBottomSheetPopController,
        );
      } else {
        await AlertBottomSheet.show(
          context,
          alertMessageText: "SystemError : ${e.toString()}",
          backController: state.alertBottomSheetPopController,
        );
      }
    }
  }
}
