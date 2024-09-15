import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/models/user_model.dart';

class ElectricityConsumptionScreen extends StatefulWidget {
  const ElectricityConsumptionScreen({
    super.key,
    required this.user
  });

  final UserModel user;

  @override
  State<ElectricityConsumptionScreen> createState() => _ElectricityConsumptionScreenState();
}

class _ElectricityConsumptionScreenState extends State<ElectricityConsumptionScreen> {

  double sizedBoxHeight = Get.height * 0.055;

  late DatabaseReference _electricityRef;
  late double voltage = 0;
  late double current = 0;
  late double powerConsumption = 0;
  late double totalEnergyConsumption = 0;
  late double cost = 0;

  @override
  void initState() {
    super.initState();
    // _electricityRef = FirebaseDatabase.instance.ref('electricity');

    // You can call a function to listen to real-time updates for electricity
    // listenToElectricityData();
  }

  void listenToElectricityData() {
    _electricityRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        voltage = double.parse(data['voltage'].toString());
        current = double.parse(data['current'].toString());
        powerConsumption = voltage * current;
        totalEnergyConsumption = double.parse(data['totalEnergyConsumption'].toString());
        cost = totalEnergyConsumption * 0.15; // Assuming cost per kWh is $0.15
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Real-Time Electricity Monitoring")),
      body: Column(
        children: [
          SizedBox(height: sizedBoxHeight),

          Text(
            'Current Power Consumption: ${powerConsumption.toStringAsFixed(2)} W',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: sizedBoxHeight),

          Text(
            'Voltage: ${voltage.toStringAsFixed(2)} V',
            style: TextStyle(fontSize: 20),
          ),

          SizedBox(height: sizedBoxHeight),

          Text(
            'Current: ${current.toStringAsFixed(2)} A',
            style: TextStyle(fontSize: 20),
          ),

          SizedBox(height: sizedBoxHeight),

          Text(
            'Total Energy Consumption: ${totalEnergyConsumption.toStringAsFixed(2)} kWh',
            style: TextStyle(fontSize: 20),
          ),

          SizedBox(height: sizedBoxHeight),

          Text(
            'Estimated Cost: \$${cost.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, color: Colors.green),
          ),

          SizedBox(height: sizedBoxHeight),
        ],
      ),
    );
  }
}
