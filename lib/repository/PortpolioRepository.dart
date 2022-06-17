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

  Portpolio.sample()
      : this.type = "프로덕트",
        this.name = "Annot",
        this.title = "소스 기반 개발자 커뮤니티 플랫폼",
        this.content =
            """Annot은 레클의 자체 플랫폼으로 전 세계 모든 개발자가 소스 코드를 통해 소통하는 공간으로 누구나 코드를 분석하고 주석 작성을 가능하게 하여 주석의 양과 질을 증가시키며, 주석과 코드를 공유하는 플랫폼입니다.
커뮤니티 기반 플랫폼으로 세계 최대 스타트업 엑셀러레이터인 Plug & Play의 지원을 통해 사용자 기반을 확장하였습니다.

PLATFORM
Web 표준 서비스, Web & Mobile 환경 사용 가능

DEVELOPMENT
Node.js, React, PostgreSQL, Gitlab""";
}
