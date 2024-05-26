import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newtask/welcomescreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAmp2JB_btwobMxAaDK7Rs-Vt7fRlgP6js",
          appId: "1:440219766050:android:8db48ca08f422378c7697b",
          messagingSenderId: "440219766050",
          projectId: "newtask-5ae3b",
          storageBucket: 'newtask-5ae3b.appspot.com'));

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: WelcomeScreen(),
    );
  }
}