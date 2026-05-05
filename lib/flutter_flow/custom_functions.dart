import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

int? calculateStreakV2(
  int currentStreak,
  DateTime? lastVisit,
) {
  DateTime normalizeDate(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }

  final now = DateTime.now();
  final today = normalizeDate(now);

  if (lastVisit == null) {
    return 1;
  }

  final lastDay = normalizeDate(lastVisit);
  final difference = today.difference(lastDay).inDays;

  if (difference == 0) {
    return currentStreak;
  } else if (difference == 1) {
    return currentStreak + 1;
  } else {
    return 1;
  }
}

List<String> getDayTasks(
  String weeksJson,
  int weekIndex,
  String day,
) {
  try {
    final List<dynamic> weeks = json.decode(weeksJson);

    if (weekIndex < 0 || weekIndex >= weeks.length) {
      return [];
    }

    final dynamic dayTasks = weeks[weekIndex]['days'][day];

    if (dayTasks is List) {
      return dayTasks.map((task) => task.toString()).toList();
    }

    return [];
  } catch (e) {
    return [];
  }
}

String getWeeksTheme(
  String weeksJson,
  int weekIndex,
) {
  try {
    final List<dynamic> weeks = json.decode(weeksJson);

    if (weekIndex < 0 || weekIndex >= weeks.length) {
      return '';
    }

    return weeks[weekIndex]['theme']?.toString() ?? '';
  } catch (e) {
    return '';
  }
}

DocumentReference getDocID(
  String userID,
  int studyPlanNumber,
) {
  String documentId = '$userID-$studyPlanNumber';
  DocumentReference studyPlanRef =
      FirebaseFirestore.instance.collection('studyPlans').doc(documentId);
  return studyPlanRef; // Return the document ID or use the reference as needed
}
