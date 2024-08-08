import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jalvidyut/screens/analytics/analytics_screen.dart';
import 'package:jalvidyut/screens/challenges/challenges_screen.dart';
import 'package:jalvidyut/screens/home/home_screen.dart';
import 'package:jalvidyut/screens/profile/profile_screen.dart';
import 'package:jalvidyut/screens/usage/usage_screen.dart';
import 'package:jalvidyut/utils/utils.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});


  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {

  int currentIndex = 2;

  List<Widget> screens = [
    const AnalyticsScreen(),
    const UsageScreen(),
    const HomeScreen(),
    const ChallengesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      extendBody: false,

      body: screens[currentIndex],

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
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
          height: 70,
          backgroundColor: Colors.white,
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