import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  FirebaseFirestore _instance = FirebaseFirestore.instance;
  CollectionReference cRef = FirebaseFirestore.instance.collection("test");

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              DocumentReference dRef = cRef.doc("id123");
              dRef.set({"test": "test"});
            },
            child: Text("다큐먼트 만들기")),
        ElevatedButton(
            onPressed: () {
              DocumentReference dRef = cRef.doc("id123");
              dRef.get().then((value) {
                print(value.data());
              });
            },
            child: Text("다큐먼트 얻기")),
      ],
    );
  }
}
