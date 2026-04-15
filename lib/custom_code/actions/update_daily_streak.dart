// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<dynamic> updateDailyStreak(
  int currentStreak,
  DateTime? lastStreakVisit,
) async {
  DateTime normalizeDate(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }

  final now = DateTime.now();
  final today = normalizeDate(now);

  if (lastStreakVisit == null) {
    return {
      'updatedStreak': 1,
      'updatedLastVisit': now,
    };
  }

  final lastDay = normalizeDate(lastStreakVisit);
  final difference = today.difference(lastDay).inDays;

  if (difference == 0) {
    return {
      'updatedStreak': currentStreak,
      'updatedLastVisit': lastStreakVisit,
    };
  } else if (difference == 1) {
    return {
      'updatedStreak': currentStreak + 1,
      'updatedLastVisit': now,
    };
  } else {
    return {
      'updatedStreak': 1,
      'updatedLastVisit': now,
    };
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
// yea
