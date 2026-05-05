import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StudyPlanRecord extends FirestoreRecord {
  StudyPlanRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "totalWeeks" field.
  int? _totalWeeks;
  int get totalWeeks => _totalWeeks ?? 0;
  bool hasTotalWeeks() => _totalWeeks != null;

  // "timeCreated" field.
  DateTime? _timeCreated;
  DateTime? get timeCreated => _timeCreated;
  bool hasTimeCreated() => _timeCreated != null;

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "weeks" field.
  String? _weeks;
  String get weeks => _weeks ?? '';
  bool hasWeeks() => _weeks != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "numOfStudyPlan" field.
  int? _numOfStudyPlan;
  int get numOfStudyPlan => _numOfStudyPlan ?? 0;
  bool hasNumOfStudyPlan() => _numOfStudyPlan != null;

  // "isDeleted" field.
  bool? _isDeleted;
  bool get isDeleted => _isDeleted ?? false;
  bool hasIsDeleted() => _isDeleted != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _totalWeeks = castToType<int>(snapshotData['totalWeeks']);
    _timeCreated = snapshotData['timeCreated'] as DateTime?;
    _userId = snapshotData['userId'] as String?;
    _weeks = snapshotData['weeks'] as String?;
    _user = snapshotData['user'] as DocumentReference?;
    _numOfStudyPlan = castToType<int>(snapshotData['numOfStudyPlan']);
    _isDeleted = snapshotData['isDeleted'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('studyPlan');

  static Stream<StudyPlanRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StudyPlanRecord.fromSnapshot(s));

  static Future<StudyPlanRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StudyPlanRecord.fromSnapshot(s));

  static StudyPlanRecord fromSnapshot(DocumentSnapshot snapshot) =>
      StudyPlanRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StudyPlanRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StudyPlanRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StudyPlanRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StudyPlanRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStudyPlanRecordData({
  String? title,
  int? totalWeeks,
  DateTime? timeCreated,
  String? userId,
  String? weeks,
  DocumentReference? user,
  int? numOfStudyPlan,
  bool? isDeleted,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'totalWeeks': totalWeeks,
      'timeCreated': timeCreated,
      'userId': userId,
      'weeks': weeks,
      'user': user,
      'numOfStudyPlan': numOfStudyPlan,
      'isDeleted': isDeleted,
    }.withoutNulls,
  );

  return firestoreData;
}

class StudyPlanRecordDocumentEquality implements Equality<StudyPlanRecord> {
  const StudyPlanRecordDocumentEquality();

  @override
  bool equals(StudyPlanRecord? e1, StudyPlanRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.totalWeeks == e2?.totalWeeks &&
        e1?.timeCreated == e2?.timeCreated &&
        e1?.userId == e2?.userId &&
        e1?.weeks == e2?.weeks &&
        e1?.user == e2?.user &&
        e1?.numOfStudyPlan == e2?.numOfStudyPlan &&
        e1?.isDeleted == e2?.isDeleted;
  }

  @override
  int hash(StudyPlanRecord? e) => const ListEquality().hash([
        e?.title,
        e?.totalWeeks,
        e?.timeCreated,
        e?.userId,
        e?.weeks,
        e?.user,
        e?.numOfStudyPlan,
        e?.isDeleted
      ]);

  @override
  bool isValidKey(Object? o) => o is StudyPlanRecord;
}
