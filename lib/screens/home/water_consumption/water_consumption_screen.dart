import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/controller/auth_controller/water_consumption_controller.dart';
import 'package:jalvidyut/components/custom_app_bar.dart';
import 'package:jalvidyut/models/user_model.dart';
import 'package:jalvidyut/utils/app_colors.dart';
import '../../../utils/utils.dart';

class WaterConsumptionScreen extends StatefulWidget {
  const WaterConsumptionScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<WaterConsumptionScreen> createState() => _WaterConsumptionScreenState();
}

class _WaterConsumptionScreenState extends State<WaterConsumptionScreen> {

  double sizedBoxHeight = Get.height * 0.055;
  final double _tankHeight = Get.height * 0.5;

  late WaterConsumptionController controller;

  @override
  void initState() {
    controller = Get.put(WaterConsumptionController());
    controller.fetchData(widget.user);
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: FirebaseAnimatedList(
        query: FirebaseDatabase.instance.ref(widget.user.userId).orderByKey(),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        defaultChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: AppColors.waterColor,
                ),
              ),
            ),
          ],
        ),
        itemBuilder: (context, snapshot, animation, index) {

          String value = snapshot.child('distance').value.toString();
          double distance = double.parse(value) * 10;

          controller.calculateAvailableWater(distance);
          controller.calculateWaterUsed(distance);
          controller.calculateFilledHeight(_tankHeight, distance);
          double filledHeight = controller.filledHeight.value;
          if (filledHeight < 0) {
            filledHeight = 0;
          }

          return Obx( () => Column(
            children: [
              SizedBox(height: sizedBoxHeight),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Available Water: ${controller.availableWater.value.toStringAsFixed(2)} litre',
                  style: Utils.customTextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: sizedBoxHeight),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Water Used: ${controller.waterUsed.value.toStringAsFixed(2)} litre',
                  style: Utils.customTextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: sizedBoxHeight),

              Container(
                width: Get.width,
                height: _tankHeight,
                color: Colors.white,
                child: Stack(
                  children: [

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          height: filledHeight,
                          color: AppColors.waterColor,
                        ),
                      ),
                    ),


                    Image.asset(
                      height: Get.height,
                      fit: BoxFit.fitHeight,
                      'assets/images/water tank.png',
                    ),
                  ],
                ),
              ),

              SizedBox(height: sizedBoxHeight),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Tank Capacity: ${controller.tankCapacity.value} litres',
                  style: Utils.customTextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: sizedBoxHeight),
            ],
          ));
        }
      ),
    );
  }
}

// tankHeight = 1100 mm
// tankRadius = 610 mm
// tankCapacity = 1000 L