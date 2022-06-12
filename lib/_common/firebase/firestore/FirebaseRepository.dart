
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseRepository<TargetType> {
  String collectionName;
  FromFirestore<TargetType> fromFirestore;
  ToFirestore<TargetType> toFirestore;

  FirebaseRepository({
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
    DocumentSnapshot<TargetType> targetTypeSnapshot = await _dRef(documentId).get();
    TargetType? targetType = targetTypeSnapshot.data();
    return targetType;
  }

  Future<List<TargetType>> getList(
      Object field, {
        Object? isEqualTo,
        Object? isNotEqualTo,
        Object? isLessThan,
        Object? isLessThanOrEqualTo,
        Object? isGreaterThan,
        Object? isGreaterThanOrEqualTo,
        Object? arrayContains,
        List<Object?>? arrayContainsAny,
        List<Object?>? whereIn,
        List<Object?>? whereNotIn,
        bool? isNull,
      }) async {
    Query<TargetType> query = _cRef().where(
      field,
      isEqualTo: isEqualTo,
      isNotEqualTo: isNotEqualTo,
      isLessThan: isLessThan,
      isLessThanOrEqualTo: isLessThanOrEqualTo,
      isGreaterThan: isGreaterThan,
      isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
      arrayContains: arrayContains,
      arrayContainsAny: arrayContainsAny,
      whereIn: whereIn,
      whereNotIn: whereNotIn,
      isNull: isNull,
    );
    QuerySnapshot<TargetType> querySnapshot = await query.get();

    List<QueryDocumentSnapshot<TargetType>> queryDocumentSnapshotList =
        querySnapshot.docs;
    List<TargetType> targetTypeList =
    queryDocumentSnapshotList.map((e) => e.data()).toList();

    return targetTypeList;
  }
}