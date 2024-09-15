import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/screens/welcome/splash_screen.dart';
import 'package:jalvidyut/utils/routes/routes.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
  ]);
  runApp(const WaterElectricityTrackingApp());
}

class WaterElectricityTrackingApp extends StatelessWidget {
  const WaterElectricityTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Jal Vidyut',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white
        ),
        scaffoldBackgroundColor: Colors.white
      ),
      home: const SplashScreen(),
      initialRoute: Routes.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
