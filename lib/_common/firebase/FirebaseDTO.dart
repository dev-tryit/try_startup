abstract class FirebaseDTO {
  int? documentId;

  FirebaseDTO({this.documentId});
  
  @override
  bool operator ==(dynamic other) => documentId == other.documentId;

  Map<String, dynamic> toFirestore();

}
