import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseRepository<TargetType> {
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

  Future<void> save(TargetType targetType,
      {String? documentId, SetOptions? options}) async {
    await _dRef(documentId).set(targetType, options);
  }

  Future<void> delete(TargetType targetType, {String? documentId}) async {
    await _dRef(documentId).delete();
  }

  Future<TargetType?> get({String? documentId}) async {
    DocumentSnapshot<TargetType> targetTypeSnapshot =
        await _dRef(documentId).get();
    TargetType? targetType = targetTypeSnapshot.data();
    return targetType;
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
