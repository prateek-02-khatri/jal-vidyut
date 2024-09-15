import 'package:get/get.dart';

class AnalyticController extends GetxController {
  RxInt index = 3.obs;

  void reset() {
    index.value = 3;
  }

  void moveLeft() {
    if (index.value > 0) {
      index.value--;
    }
  }

  void moveRight() {
    if (index.value < 3) {
      index.value++;
    }
  }
}
