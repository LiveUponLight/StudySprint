import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:integration_test/integration_test.dart';
import 'package:study_sprint/flutter_flow/flutter_flow_icon_button.dart';
import 'package:study_sprint/flutter_flow/flutter_flow_widgets.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:study_sprint/index.dart';
import 'package:study_sprint/main.dart';
import 'package:study_sprint/flutter_flow/flutter_flow_util.dart';

import 'package:provider/provider.dart';
import 'package:study_sprint/backend/firebase/firebase_config.dart';
import 'package:study_sprint/auth/firebase_auth/auth_util.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initFirebase();

    await FlutterFlowTheme.initialize();
  });

  setUp(() async {
    await authManager.signOut();
    FFAppState.reset();
    final appState = FFAppState();
    await appState.initializePersistedState();
  });

  testWidgets('US4 AC2', (WidgetTester tester) async {
    _overrideOnError();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: 'us4@gmail.com', password: '123456');
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FFAppState(),
        ),
      ],
      child: const MyApp(),
    ));
    await GoogleFonts.pendingFonts();

    await tester.pumpAndSettle(const Duration(milliseconds: 3000));
    await tester.enterText(find.byKey(const ValueKey('syllabus_8a3y')),
        'Teach me how to code in Python in 4 weeks.');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.tap(find.byKey(const ValueKey('confirm_upmw')));
  });

  testWidgets('US1 Sign Up', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FFAppState(),
        ),
      ],
      child: MyApp(
        entryPage: LoginWidget(),
      ),
    ));
    await GoogleFonts.pendingFonts();

    await tester.pumpAndSettle(const Duration(milliseconds: 30000));
    await tester.enterText(find.byKey(const ValueKey('signupEmail_q4yt')),
        'testuserrr67@mail.com');
    await tester.enterText(
        find.byKey(const ValueKey('signupPassword_yvhx')), '123456');
    await tester.enterText(
        find.byKey(const ValueKey('signupConfirmPassword_629x')), '123456');
    await tester.tap(find.byKey(const ValueKey('signupButton_fxns')));
    await tester.pumpAndSettle(const Duration(milliseconds: 30000));
    expect(find.byKey(const ValueKey('syllabus_8a3y')), findsWidgets);
  });

  testWidgets('US3 - Schedule Creation', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FFAppState(),
        ),
      ],
      child: const MyApp(),
    ));
    await GoogleFonts.pendingFonts();

    await tester.pumpAndSettle(const Duration(milliseconds: 3000));
    await tester.tap(find.text('Upload'));
    await tester.pumpAndSettle(const Duration(milliseconds: 3000));
    expect(find.text('Upload Schedule'), findsOneWidget);
  }, skip: true);
}

// There are certain types of errors that can happen during tests but
// should not break the test.
void _overrideOnError() {
  final originalOnError = FlutterError.onError!;
  FlutterError.onError = (errorDetails) {
    if (_shouldIgnoreError(errorDetails.toString())) {
      return;
    }
    originalOnError(errorDetails);
  };
}

bool _shouldIgnoreError(String error) {
  // It can fail to decode some SVGs - this should not break the test.
  if (error.contains('ImageCodecException')) {
    return true;
  }
  // Overflows happen all over the place,
  // but they should not break tests.
  if (error.contains('overflowed by')) {
    return true;
  }
  // Sometimes some images fail to load, it generally does not break the test.
  if (error.contains('No host specified in URI') ||
      error.contains('EXCEPTION CAUGHT BY IMAGE RESOURCE SERVICE')) {
    return true;
  }
  // These errors should be avoided, but they should not break the test.
  if (error.contains('setState() called after dispose()')) {
    return true;
  }
  // Web-specific error when interacting with TextInputType.emailAddress
  if (error.contains('setSelectionRange') &&
      error.contains('HTMLInputElement')) {
    return true;
  }

  return false;
}
