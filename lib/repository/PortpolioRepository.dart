import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:try_startup/_common/firebase/FirebaseDTO.dart';
import 'package:try_startup/_common/firebase/firestore/FirebaseRepository.dart';

class PortpolioRepository extends FirebaseRepository<Portpolio> {
  static final PortpolioRepository me = PortpolioRepository._internal();

  PortpolioRepository._internal()
      : super(
          collectionName: "Portpolio",
          fromFirestore: Portpolio.fromFirestore,
          toFirestore: (Portpolio portpolio, options) =>
              portpolio.toFirestore(),
        );
}

class Portpolio extends FirebaseDTO {
  String? type;
  String? name;
  String? title;
  String? content;

  Portpolio({
    this.type,
    this.name,
    this.title,
    this.content,
  }) : super(documentId: DateTime.now().microsecondsSinceEpoch);

  factory Portpolio.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Portpolio(
      type: data?['type'],
      name: data?['name'],
      title: data?['title'],
      content: data?['content'],
    )..documentId = data?['documentId'];
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (documentId != null) "documentId": documentId,
      if (type != null) "name": type,
      if (name != null) "state": name,
      if (title != null) "country": title,
      if (content != null) "capital": content,
    };
  }

  void throwInputError() {
  //   if (name.isNullOrEmpty) throw CommonException(message: "도시 이름 항목이 비어있습니다.");
  //   if (state.isNullOrEmpty) throw CommonException(message: "상태 항목이 비어있습니다.");
  //   if (country.isNullOrEmpty)
  //     throw CommonException(message: "나라 이름 항목이 비어있습니다.");
  }
}
