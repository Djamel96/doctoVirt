import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chooseProfile/choose_profile_type_screen.dart';
import 'them/colors.dart';

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
      theme: ThemeData(
        fontFamily: 'DMSans',
        primaryColor: Colors.white,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appMain100,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        dividerColor: Colors.white54,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: AppColors.appMain100),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
            .copyWith(secondary: AppColors.appMain100),
      ),
    );
  }
}
