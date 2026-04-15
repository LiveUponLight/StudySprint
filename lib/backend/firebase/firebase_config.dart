import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAN9ONlDED1RRTtA8T6uVT-qZc0QnODVu8",
            authDomain: "study-sprint-4ld9hz.firebaseapp.com",
            projectId: "study-sprint-4ld9hz",
            storageBucket: "study-sprint-4ld9hz.firebasestorage.app",
            messagingSenderId: "524900500688",
            appId: "1:524900500688:web:ac28e31958b032ccbd8ad5",
            measurementId: "G-K9DX08KKDX"));
  } else {
    await Firebase.initializeApp();
  }
}
