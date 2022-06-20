import 'package:flutter/material.dart';

import '../repository/PortpolioRepository.dart';
import '../util/MyImage.dart';

class MainPage extends StatelessWidget {
  List<Portpolio> portpolioList = [
    Portpolio.sample(),
    Portpolio.sample(),
    Portpolio.sample(),
  ];
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            toolbarHeight: 600,
            title: SizedBox(
              height: 300,
              child: Row(children: [
                Text("leading"),
                Spacer(),
                Text("menu"),
                Spacer(),
                Text("action")
              ]),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            content(),
            footer(),
          ])),
        ],
      ),
    );
  }

  Widget content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("트라잇 프로젝트"),
        Text("트라잇은 고객이 원하는 프로덕트를 만듭니다."),
        typeSelector(),
        portpolioColumn(),
      ],
    );
  }

  Widget footer() {
    return Container(
      height: 300,
      color: Colors.red,
      child: Column(
        children: [
          topFotter(),
          bottomFotter(),
        ],
      ),
    );
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

  Widget topFotter() {
    return Column(
      children: [
        Text("LECLE"),
        Text("ⓒ LECLE All Right Reserved."),
      ],
    );
  }

  Widget bottomFotter() {
    return Column(
      children: [
        Text("SEOUL, KOREA"),
        Text("16F HiteJinro, 14 Seochojungang-ro, Seocho-gu, Seoul, Korea"),
        Text("VIETNAM"),
        Text(
            "81 Cách Mạng Tháng Tám, Phường Bến Thành, Quận 1, Hồ Chí Minh 700000"),
        Text("SINGAPORE"),
        Text("21 Heng Mui Keng Terrace, Singapore 119613"),
        Text("AUSTIN, USA"),
        Text("815-A Brazos St. #435 Austin, TX78701"),
        Text("CONTACT US"),
        Text("support@lecle.co.kr"),
        Text("BACKED BY"),
        Text("이미지1, 이미지2, 이미지3"),
      ],
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
        Expanded(child: Image(image: MyImage.sampleImage)),
        Expanded(
          child: Column(
            children: [
              Text(portpolio.type.toString()),
              Text(portpolio.name.toString()),
              Text(portpolio.title.toString()),
              Text(portpolio.content.toString()),
              IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget detailSection() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      height: detailHeight,
      child: Column(
        children: [
          Text(portpolio.name.toString()),
          Text(portpolio.title.toString()),
          Text(portpolio.content.toString()),
        ],
      ),
    );
  }
}
