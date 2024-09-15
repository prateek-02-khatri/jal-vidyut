import 'package:get/get.dart';

class UsageController extends GetxController {

  final int totalDays;
  RxInt index = 0.obs;

  UsageController(this.totalDays) {
    index = totalDays.obs;
  }

  void reset() {
    index.value = totalDays;
  }

  void moveLeft() {
    if (index.value > 0) {
      index.value--;
    }
  }

  void moveRight() {
    if (index.value < totalDays) {
      index.value++;
    }
  }
}