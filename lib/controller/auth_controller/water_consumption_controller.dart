import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/models/user_model.dart';

class WaterConsumptionController extends GetxController {
  RxDouble tankHeight = 0.0.obs;
  RxDouble tankRadius = 0.0.obs;
  RxDouble tankCapacity = 0.0.obs;

  RxDouble availableWater = 0.0.obs;
  RxDouble waterUsed = 0.0.obs;
  RxDouble filledHeight = 0.0.obs;

  void calculateAvailableWater(double distance) {
    if (distance > tankHeight.value) {
      availableWater.value = 0;
    }
    double volume = calculateVolume(tankHeight.value-distance);
    availableWater.value = volume/1000000;

    if (availableWater.value < 0) {
      availableWater.value = 0;
    }
  }

  void calculateWaterUsed(double distance) {
    if (distance > tankHeight.value) {
      waterUsed.value = calculateVolume(tankHeight.value) / 1000000;
    }
    double volume = calculateVolume(distance);
    waterUsed.value = volume/1000000;
  }

  void calculateFilledHeight(double height, double distance) {
    if (distance > tankHeight.value) {
      filledHeight.value = 0;
      return;
    }
    double filledRatio = (tankHeight.value-distance) / tankHeight.value;
    double totalFilledHeight = height * filledRatio;
    if (totalFilledHeight < 0) {
      filledHeight.value = 0;
      return;
    }
    filledHeight.value = totalFilledHeight;
  }

  double calculateVolume(double height) {
    return 3.14 * tankRadius.value * tankRadius.value * height;
  }

  Future<void> fetchData(UserModel user) async {

    tankHeight.value = double.parse(user.tankHeight);
    tankRadius.value = double.parse(user.tankWidth) / 2;
    tankCapacity.value = double.parse(user.tankCapacity);

    var snap = await FirebaseDatabase.instance.ref(user.userId).child('distance').get();
    String value = snap.value.toString();
    double distance = double.parse(value) * 10;
    calculateAvailableWater(distance);
    calculateWaterUsed(distance);
  }
}