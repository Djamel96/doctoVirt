import 'package:flutter/material.dart';

import 'chooseProfile/choose_profile_type_screen.dart';
import 'ongoingCall/ongoing_call_main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChooseProfileTypeScreen(),
    );
  }
}
