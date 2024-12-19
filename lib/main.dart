import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aspire Grammar College',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }
        )
      ),
      home: const SplashScreen(),
    );
  }
}
