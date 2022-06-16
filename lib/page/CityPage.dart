import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import '../_common/flutter/bottomSheet/AlertBottomSheet.dart';
import '../_common/flutter/bottomSheet/InputBottomSheet.dart';
import '../_common/flutter/controller/ValueController.dart';
import '../_common/flutter/effect/BouncingModalBottomEffect.dart';
import '../_common/flutter/widget/listTile/MultiSelectListTile.dart';
import '../_common/flutter/widget/listTile/SwitchInput.dart';
import '../_common/flutter/widget/listTile/IntListTile.dart';
import '../_common/flutter/widget/listTile/TextFieldInput.dart';
import '../_common/mixin/ReBuilder.dart';
import '../_common/model/exception/CommonException.dart';
import '../repository/CityRepository.dart';

class CityPage extends StatefulWidget {
  CityPage({Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> with ReBuilder<CityPage> {
  late ValueController<String> nameController;
  late ValueController<String> stateController;
  late ValueController<String> countryController;
  late ValueController<bool> capitalController;
  late ValueController<int> populationController;
  late ValueController<List<String>> regionsController;

  late CityPageService s;
  final inputBottomSheetPopController = BackController();
  final alertBottomSheetPopController = BackController();

  List<S2Choice<String>> regions = [
    S2Choice<String>(value: 'jung-gu', title: '중구'),
    S2Choice<String>(value: 'dong-gu', title: '동구'),
    S2Choice<String>(value: 'seo-gu', title: '서구'),
    S2Choice<String>(value: 'gyeyang-gu', title: '계양구'),
  ];

  CityRepository get r => CityRepository.me;

  @override
  void initState() {
    super.initState();
    s = CityPageService(this);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<City>>(
      future: r.getList(),
      builder: (context, snapshot) {
        bool isDone = snapshot.connectionState == ConnectionState.done;
        if (!isDone) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        FloatingActionButton floatingActionButton = FloatingActionButton(
            onPressed: createBottomSheet, child: const Icon(Icons.add));

        List<City> cityList = snapshot.data ?? [];

        if (cityList.isEmpty) {
          return Scaffold(
            body: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  floatingActionButton,
                  const SizedBox(width: 10),
                  Text("${r.collectionName} 요소를 추가해주세요"),
                ],
              ),
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
              return SwipeActionCell(
                key: ObjectKey(city),
                trailingActions: [
                  SwipeAction(
                    title: "삭제",
                    onTap: (deleteEffect) => s.deleteCity(deleteEffect, city),
                    color: Colors.red,
                  ),
                  SwipeAction(
                    title: "수정",
                    onTap: (h) => updateBottomSheet(city),
                    color: Colors.blue,
                  ),
                ],
                child: Card(
                  child: ListTile(
                    title: Text(city.toFirestore().toString()),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void createBottomSheet() async {
    nameController = ValueController<String>("");
    stateController = ValueController<String>("");
    countryController = ValueController<String>("");
    capitalController = ValueController<bool>(false);
    populationController = ValueController<int>(0);
    regionsController = ValueController<List<String>>([]);

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
          controller: regionsController,
          choiceItems: regions,
          modalConfirm: true,
        ),
        const SizedBox(height: 10),
      ],
      backController: inputBottomSheetPopController,
    );
  }

  void updateBottomSheet(City city) async {
    nameController = ValueController<String>(city.name ?? "");
    stateController = ValueController<String>(city.state ?? "");
    countryController = ValueController<String>(city.country ?? "");
    capitalController = ValueController<bool>(city.capital ?? false);
    populationController = ValueController<int>(city.population ?? 0);
    regionsController = ValueController<List<String>>(city.regions ?? []);

    await InputBottomSheet.show(
      context,
      title: "${r.collectionName} 요소 수정",
      buttonStr: '수정',
      onAdd: (setErrorMessage)=>s.updateCity(setErrorMessage, city),
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
          controller: regionsController,
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
  final _CityPageState state;

  const CityPageService(this.state);
  Future<void> createCity(
      void Function(String errorMessage) setErrorMessage) async {
    _saveCity(setErrorMessage, City(), isAdd: true);
  }

  Future<void> updateCity(
      void Function(String errorMessage) setErrorMessage, City city) async {
    _saveCity(setErrorMessage, city, isAdd: false);
  }

  void deleteCity(CompletionHandler deleteEffect, City city) async {
    await deleteEffect(true);
    await CityRepository.me.delete(documentId: city.documentId);
    state.rebuild();
  }

  Future<void> _saveCity(void Function(String errorMessage) setErrorMessage, City city,
      {required bool isAdd}) async {
    var context = state.context;

    city
      ..name=(state.nameController.value)
      ..capital=(state.capitalController.value)
      ..country=(state.countryController.value)
      ..state=(state.stateController.value)
      ..population=(state.populationController.value)
      ..regions=(state.regionsController.value);

    try {
      city.throwInputError();
      await CityRepository.me.save(city);
      await AlertBottomSheet.show(
        context,
        alertMessageText:
        "${state.r.collectionName} 요소 ${isAdd ? "추가" : "수정"}에 성공하였습니다.",
        backController: state.alertBottomSheetPopController,
      );
      state.inputBottomSheetPopController.back();
      state.rebuild();
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
