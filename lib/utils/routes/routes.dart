import 'package:flutter/material.dart';
import 'package:jalvidyut/models/user_model.dart';
import 'package:jalvidyut/screens/auth/login_screen.dart';
import 'package:jalvidyut/screens/auth/signup_screen.dart';
import 'package:jalvidyut/screens/auth/tank_specification_screen.dart';
import 'package:jalvidyut/screens/goal/goal_screen.dart';
import 'package:jalvidyut/screens/home/electricity_consumption/electricity_consumption_screen.dart';
import 'package:jalvidyut/screens/home/water_consumption/water_consumption_screen.dart';
import 'package:jalvidyut/screens/navigation_menu.dart';
import 'package:jalvidyut/screens/profile/user_detail.dart';
import 'package:jalvidyut/screens/welcome/splash_screen.dart';
import 'package:jalvidyut/utils/app_colors.dart';

class Routes {

  static const String splash = 'splash_screen';
  static const String login = 'login_screen';
  static const String signup = 'signup_screen';
  static const String tankSpecificationScreen = 'tank_specification_screen';
  static const String navigationMenu = 'navigation_menu';
  static const String waterConsumptionScreen = 'water_consumption_screen';
  static const String electricityConsumptionScreen = 'electricity_consumption_screen';
  static const String userDetail = 'userDetail';
  static const String goal = 'goal';

  static const String waiting = 'waiting';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {

      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case Routes.signup:
        return MaterialPageRoute(builder: (context) => const SignupScreen());

      case Routes.tankSpecificationScreen:
        return MaterialPageRoute(builder: (context) => const TankSpecificationScreen());

      case Routes.navigationMenu:
        UserModel user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (context) => NavigationMenu(user: user));

      case Routes.waterConsumptionScreen:
        UserModel user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (context) => WaterConsumptionScreen(user: user));

      case Routes.electricityConsumptionScreen:
        UserModel user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (context) => ElectricityConsumptionScreen(user: user));

      case Routes.userDetail:
        Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) => UserDetail(user: map['user'], controller: map['controller']));

      case Routes.goal:
        Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) => GoalScreen(
          user: map['user'],
          isWater: map['isWater'],
          weekData: map['weekData'],
          dailyData: map['dailyData'],
        ));

      case Routes.waiting:
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