import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

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
    return Text("content", style: TextStyle(fontSize: 400));
  }

  Widget footer() {
    return Text("footer", style: TextStyle(fontSize: 400));
  }
}
