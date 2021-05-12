import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sample/presentation/start/start_page.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //you forgot this lineee........................!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!
  //you forgot this lineee........................!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!  //you forgot this lineee........................!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!  //you forgot this lineee........................!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!  //you forgot this lineee........................!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!
  configureDependencies(); //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  //you forgot this lineee........................!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!  //you forgot this lineee........................!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!  //you forgot this lineee........................!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!  //you forgot this lineee........................!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!  //you forgot this lineee........................!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!
  //!!!!!!!!!!
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yuthi',
      home: SplashScreen(),
    );
  }
}
