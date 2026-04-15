import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserRecord extends FirestoreRecord {
  UserRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "user_name" field.
  String? _userName;
  String get userName => _userName ?? '';
  bool hasUserName() => _userName != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "scheduleUser" field.
  List<String>? _scheduleUser;
  List<String> get scheduleUser => _scheduleUser ?? const [];
  bool hasScheduleUser() => _scheduleUser != null;

  // "streak" field.
  int? _streak;
  int get streak => _streak ?? 0;
  bool hasStreak() => _streak != null;

  // "streakEligible" field.
  bool? _streakEligible;
  bool get streakEligible => _streakEligible ?? false;
  bool hasStreakEligible() => _streakEligible != null;

  // "lastVisit" field.
  DateTime? _lastVisit;
  DateTime? get lastVisit => _lastVisit;
  bool hasLastVisit() => _lastVisit != null;

  // "daysSinceLastVisit" field.
  int? _daysSinceLastVisit;
  int get daysSinceLastVisit => _daysSinceLastVisit ?? 0;
  bool hasDaysSinceLastVisit() => _daysSinceLastVisit != null;

  // "lastStudy" field.
  DateTime? _lastStudy;
  DateTime? get lastStudy => _lastStudy;
  bool hasLastStudy() => _lastStudy != null;

  // "daysSinceLastStudy" field.
  int? _daysSinceLastStudy;
  int get daysSinceLastStudy => _daysSinceLastStudy ?? 0;
  bool hasDaysSinceLastStudy() => _daysSinceLastStudy != null;

  // "hasCompletedNPS" field.
  bool? _hasCompletedNPS;
  bool get hasCompletedNPS => _hasCompletedNPS ?? false;
  bool hasHasCompletedNPS() => _hasCompletedNPS != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _userName = snapshotData['user_name'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _scheduleUser = getDataList(snapshotData['scheduleUser']);
    _streak = castToType<int>(snapshotData['streak']);
    _streakEligible = snapshotData['streakEligible'] as bool?;
    _lastVisit = snapshotData['lastVisit'] as DateTime?;
    _daysSinceLastVisit = castToType<int>(snapshotData['daysSinceLastVisit']);
    _lastStudy = snapshotData['lastStudy'] as DateTime?;
    _daysSinceLastStudy = castToType<int>(snapshotData['daysSinceLastStudy']);
    _hasCompletedNPS = snapshotData['hasCompletedNPS'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user');

  static Stream<UserRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserRecord.fromSnapshot(s));

  static Future<UserRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserRecord.fromSnapshot(s));

  static UserRecord fromSnapshot(DocumentSnapshot snapshot) => UserRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  String? userName,
  DateTime? createdTime,
  String? phoneNumber,
  int? streak,
  bool? streakEligible,
  DateTime? lastVisit,
  int? daysSinceLastVisit,
  DateTime? lastStudy,
  int? daysSinceLastStudy,
  bool? hasCompletedNPS,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'user_name': userName,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'streak': streak,
      'streakEligible': streakEligible,
      'lastVisit': lastVisit,
      'daysSinceLastVisit': daysSinceLastVisit,
      'lastStudy': lastStudy,
      'daysSinceLastStudy': daysSinceLastStudy,
      'hasCompletedNPS': hasCompletedNPS,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserRecordDocumentEquality implements Equality<UserRecord> {
  const UserRecordDocumentEquality();

  @override
  bool equals(UserRecord? e1, UserRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.userName == e2?.userName &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        listEquality.equals(e1?.scheduleUser, e2?.scheduleUser) &&
        e1?.streak == e2?.streak &&
        e1?.streakEligible == e2?.streakEligible &&
        e1?.lastVisit == e2?.lastVisit &&
        e1?.daysSinceLastVisit == e2?.daysSinceLastVisit &&
        e1?.lastStudy == e2?.lastStudy &&
        e1?.daysSinceLastStudy == e2?.daysSinceLastStudy &&
        e1?.hasCompletedNPS == e2?.hasCompletedNPS;
  }

  @override
  int hash(UserRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.userName,
        e?.createdTime,
        e?.phoneNumber,
        e?.scheduleUser,
        e?.streak,
        e?.streakEligible,
        e?.lastVisit,
        e?.daysSinceLastVisit,
        e?.lastStudy,
        e?.daysSinceLastStudy,
        e?.hasCompletedNPS
      ]);

  @override
  bool isValidKey(Object? o) => o is UserRecord;
}
