import 'package:flutter/material.dart';
import 'package:jalvidyut/components/custom_app_bar.dart';
import 'package:jalvidyut/screens/challenges/widget/challenges.dart';

import '../../models/challenges_model.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Challenges'),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: ListView.builder(
                itemCount: challenges.length,
                itemBuilder: (context, index) {
                  return Challenges(
                      title: challenges[index]['title'].toString(),
                      desc: challenges[index]['desc'].toString(),
                      cost: challenges[index]['cost'] as int,
                      isCompleted: challenges[index]['isCompleted'] as bool
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
