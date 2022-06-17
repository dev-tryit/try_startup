import 'package:flutter/material.dart';

import '../repository/PortpolioRepository.dart';
import '../util/MyImage.dart';

class MainPage extends StatelessWidget {
  List<Portpolio> portpolioList = [];
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 400,
              pinned: true,
              elevation: 0,
              title: Row(children: [
                Text("leading"),
                Spacer(),
                Text("menu"),
                Spacer(),
                Text("action")
              ]),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              content(),
              footer(),
            ])),
          ],
        ),
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        Text("트라잇 프로젝트"),
        Text("트라잇은 고객이 원하는 프로덕트를 만듭니다."),
        typeSelector(),
        portpolioColumn(),
      ],
    );
  }

  Widget footer() {
    return Text("footer", style: TextStyle(fontSize: 400));
  }

  Widget typeSelector() {
    return Row(
      children:
          ["전체", "프로덕트", "비즈니스", "블록체인", "아웃소싱"].map((e) => Text(e)).toList(),
    );
  }

  Widget portpolioColumn() {
    return Column(
      children: portpolioList.map((e) => PortpolioWidget(e)).toList(),
    );
  }
}

class PortpolioWidget extends StatelessWidget {
  double detailHeight = 0;
  Portpolio portpolio;
  PortpolioWidget(this.portpolio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      defaultSection(),
      detailSection(),
    ]);
  }

  Widget defaultSection() {
    return Row(
      children: [
        Image(image: MyImage.sampleImage),
        Column(
          children: [
            Text(portpolio.type.toString()),
            Text(portpolio.title.toString()),
            Text(portpolio.content.toString()),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget detailSection() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      height: detailHeight,
      child: Text("detailSection"),
    );
  }
}
