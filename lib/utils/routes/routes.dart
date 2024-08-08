import 'package:flutter/material.dart';
import 'package:jalvidyut/screens/analytics/analytics_screen.dart';
import 'package:jalvidyut/screens/auth/login_screen.dart';
import 'package:jalvidyut/screens/auth/signup_screen.dart';
import 'package:jalvidyut/screens/challenges/challenges_screen.dart';
import 'package:jalvidyut/screens/home/home_screen.dart';
import 'package:jalvidyut/screens/navigation_menu.dart';
import 'package:jalvidyut/screens/profile/profile_screen.dart';
import 'package:jalvidyut/screens/usage/usage_screen.dart';
import 'package:jalvidyut/screens/welcome/splash_screen.dart';
import 'package:jalvidyut/utils/app_colors.dart';
import 'package:jalvidyut/utils/routes/routes_name.dart';

import '../../screens/profile/user_detail.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {

      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => const SignupScreen());

      case RoutesName.navigationMenu:
        return MaterialPageRoute(builder: (context) => const NavigationMenu());

      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case RoutesName.waiting:
        return MaterialPageRoute(builder: (context) => Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: AppColors.waterColor,
            ),
          ),
        ));

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
                child: Text(
                  'No Route Defined..!!'
                )
            ),
          );
        });
    }
  }
}