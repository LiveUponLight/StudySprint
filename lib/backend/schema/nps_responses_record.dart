import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NpsResponsesRecord extends FirestoreRecord {
  NpsResponsesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "score" field.
  int? _score;
  int get score => _score ?? 0;
  bool hasScore() => _score != null;

  // "submitted_at" field.
  DateTime? _submittedAt;
  DateTime? get submittedAt => _submittedAt;
  bool hasSubmittedAt() => _submittedAt != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  bool hasComment() => _comment != null;

  // "user_type" field.
  String? _userType;
  String get userType => _userType ?? '';
  bool hasUserType() => _userType != null;

  void _initializeFields() {
    _userId = snapshotData['user_id'] as String?;
    _score = castToType<int>(snapshotData['score']);
    _submittedAt = snapshotData['submitted_at'] as DateTime?;
    _comment = snapshotData['comment'] as String?;
    _userType = snapshotData['user_type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('nps_responses');

  static Stream<NpsResponsesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NpsResponsesRecord.fromSnapshot(s));

  static Future<NpsResponsesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NpsResponsesRecord.fromSnapshot(s));

  static NpsResponsesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NpsResponsesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NpsResponsesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NpsResponsesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NpsResponsesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NpsResponsesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNpsResponsesRecordData({
  String? userId,
  int? score,
  DateTime? submittedAt,
  String? comment,
  String? userType,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_id': userId,
      'score': score,
      'submitted_at': submittedAt,
      'comment': comment,
      'user_type': userType,
    }.withoutNulls,
  );

  return firestoreData;
}

class NpsResponsesRecordDocumentEquality
    implements Equality<NpsResponsesRecord> {
  const NpsResponsesRecordDocumentEquality();

  @override
  bool equals(NpsResponsesRecord? e1, NpsResponsesRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.score == e2?.score &&
        e1?.submittedAt == e2?.submittedAt &&
        e1?.comment == e2?.comment &&
        e1?.userType == e2?.userType;
  }

  @override
  int hash(NpsResponsesRecord? e) => const ListEquality()
      .hash([e?.userId, e?.score, e?.submittedAt, e?.comment, e?.userType]);

  @override
  bool isValidKey(Object? o) => o is NpsResponsesRecord;
}
