import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chooseProfile/choose_profile_type_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      defaultTransition: Transition.native,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      locale: const Locale('en'),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const ChooseProfileTypeScreen(),
      },
      // theme: lightTheme,
    );
  }
}
