import 'package:get/get.dart';

class BaseController extends GetxController {
  RxBool isLoading = false.obs;

  setLoading(bool value) {
    if (isLoading.value == value) return;
    isLoading.value = value;
  }
}
