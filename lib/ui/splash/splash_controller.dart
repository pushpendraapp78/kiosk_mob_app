import 'package:get/get.dart';
import '../../repo/session_repo.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    getSession();
    Future.delayed(
      const Duration(seconds: 5),
      () {
        isLogin().then((value) {
          Get.offAndToNamed(value ? '/dashboard' : '/login');
        });
      },
    );
  }

  //No use of it right now
  //ignore: unnecessary_override
  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
