
import 'package:fitness/core/helper/cache_helper.dart';
import 'package:fitness/screens/splash/presentation/screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF9F6),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


