import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _DayOfWeek = prefs.getString('ff_DayOfWeek') ?? _DayOfWeek;
    });
    _safeInit(() {
      _WhichWeek = prefs.getInt('ff_WhichWeek') ?? _WhichWeek;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _apiweek = '';
  String get apiweek => _apiweek;
  set apiweek(String value) {
    _apiweek = value;
  }

  String _DayOfWeek = 'monday';
  String get DayOfWeek => _DayOfWeek;
  set DayOfWeek(String value) {
    _DayOfWeek = value;
    prefs.setString('ff_DayOfWeek', value);
  }

  int _WhichWeek = 0;
  int get WhichWeek => _WhichWeek;
  set WhichWeek(int value) {
    _WhichWeek = value;
    prefs.setInt('ff_WhichWeek', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
