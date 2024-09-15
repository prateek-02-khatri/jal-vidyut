import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jalvidyut/models/user_model.dart';
import 'package:jalvidyut/screens/analytics/analytics_screen.dart';
import 'package:jalvidyut/screens/challenges/challenges_screen.dart';
import 'package:jalvidyut/screens/home/home_screen.dart';
import 'package:jalvidyut/screens/profile/profile_screen.dart';
import 'package:jalvidyut/screens/usage/usage_screen.dart';
import 'package:jalvidyut/utils/utils.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key, required this.user});

  final UserModel user;

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {

  int currentIndex = 2;

  late List<Widget> screens;

  @override
  void initState() {
    screens = [
      const AnalyticsScreen(),
      UsageScreen(user: widget.user),
      HomeScreen(user: widget.user),
      const ChallengesScreen(),
      ProfileScreen(email: widget.user.email),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      extendBody: false,

      body: screens[currentIndex],

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          height: 70,
          backgroundColor: Colors.white,
          iconTheme: WidgetStateProperty.all(
            const IconThemeData(size: 26,),
          ),
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.all(
              Utils.customTextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Colors.black
              )
          ),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            currentIndex = index;
            setState(() {});
          },
          destinations: const [
            NavigationDestination(icon: FaIcon(FontAwesomeIcons.chartLine), label: 'Analytics', selectedIcon: FaIcon(FontAwesomeIcons.chartLine, color: Colors.blueAccent,)),
            NavigationDestination(icon: FaIcon(FontAwesomeIcons.batteryThreeQuarters), label: 'Usage', selectedIcon: FaIcon(FontAwesomeIcons.batteryThreeQuarters, color: Colors.blueAccent,)),
            NavigationDestination(icon: FaIcon(FontAwesomeIcons.house), label: 'Home', selectedIcon: FaIcon(FontAwesomeIcons.house, color: Colors.blueAccent,)),
            NavigationDestination(icon: FaIcon(FontAwesomeIcons.coins), label: 'Challenges', selectedIcon: FaIcon(FontAwesomeIcons.coins, color: Colors.blueAccent,)),
            NavigationDestination(icon: FaIcon(FontAwesomeIcons.person), label: 'Profile', selectedIcon: FaIcon(FontAwesomeIcons.person, color: Colors.blueAccent,)),
          ],
        ),
      ),
    );
  }
}