import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

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
    _safeInit(() {
      _TempWeeks = prefs.getString('ff_TempWeeks') ?? _TempWeeks;
    });
    _safeInit(() {
      _Prompt = prefs.getString('ff_Prompt') ?? _Prompt;
    });
    _safeInit(() {
      _currentStudyPlan =
          prefs.getString('ff_currentStudyPlan')?.ref ?? _currentStudyPlan;
    });
    _safeInit(() {
      _syllabusIndex = prefs.getInt('ff_syllabusIndex') ?? _syllabusIndex;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

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

  String _TempWeeks = '';
  String get TempWeeks => _TempWeeks;
  set TempWeeks(String value) {
    _TempWeeks = value;
    prefs.setString('ff_TempWeeks', value);
  }

  String _Prompt = '';
  String get Prompt => _Prompt;
  set Prompt(String value) {
    _Prompt = value;
    prefs.setString('ff_Prompt', value);
  }

  bool _PreviewExpanded = false;
  bool get PreviewExpanded => _PreviewExpanded;
  set PreviewExpanded(bool value) {
    _PreviewExpanded = value;
  }

  DocumentReference? _currentStudyPlan;
  DocumentReference? get currentStudyPlan => _currentStudyPlan;
  set currentStudyPlan(DocumentReference? value) {
    _currentStudyPlan = value;
    value != null
        ? prefs.setString('ff_currentStudyPlan', value.path)
        : prefs.remove('ff_currentStudyPlan');
  }

  int _syllabusIndex = 0;
  int get syllabusIndex => _syllabusIndex;
  set syllabusIndex(int value) {
    _syllabusIndex = value;
    prefs.setInt('ff_syllabusIndex', value);
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
