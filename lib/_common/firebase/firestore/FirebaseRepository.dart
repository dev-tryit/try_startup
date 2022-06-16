import 'package:cloud_firestore/cloud_firestore.dart';

import '../FirebaseDTO.dart';

abstract class FirebaseRepository<TargetType extends FirebaseDTO> {
  final String collectionName;
  final FromFirestore<TargetType> fromFirestore;
  final ToFirestore<TargetType> toFirestore;

  const FirebaseRepository({
    required this.collectionName,
    required this.fromFirestore,
    required this.toFirestore,
  });

  //DB 접근하기
  FirebaseFirestore _db() => FirebaseFirestore.instance;

  //City Collection 접근하기
  CollectionReference<TargetType> _cRef() =>
      _db().collection(collectionName).withConverter(
            fromFirestore: fromFirestore,
            toFirestore: toFirestore,
          );

  DocumentReference<TargetType> _dRef([String? documentId]) =>
      _cRef().doc(documentId);

  Future<void> save(TargetType instance,
      {int? documentId, SetOptions? options}) async {
    await _dRef((documentId ?? instance.documentId).toString())
        .set(instance, options);
  }

  Future<void> delete({int? documentId}) async {
    await _dRef(documentId?.toString()).delete();
  }

  Future<TargetType?> get({int? documentId}) async {
    DocumentSnapshot<TargetType> targetTypeSnapshot =
        await _dRef(documentId?.toString()).get();
    TargetType? instance = targetTypeSnapshot.data();
    return instance;
  }

  Future<List<TargetType>> getList({Query<TargetType>? query}) async {
    QuerySnapshot<TargetType> querySnapshot =
        query != null ? await query.get() : await _cRef().get();

    List<QueryDocumentSnapshot<TargetType>> queryDocumentSnapshotList =
        querySnapshot.docs;
    List<TargetType> targetTypeList =
        queryDocumentSnapshotList.map((e) => e.data()).toList();

    return targetTypeList;
  }
}
