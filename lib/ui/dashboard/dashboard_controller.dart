import 'package:get/get.dart';
import 'package:ipbot_app/Utils/tools.dart';
import 'package:ipbot_app/repo/session_repo.dart';
import 'package:ipbot_app/repo/setting_repo.dart';
import '../../repo/auth_repo.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    onGetProfile();
  }

  var currentIndex = 0.obs;
  void changePage(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
      switch (index) {
        case 0:
          Get.toNamed("home", id: 1);
          break;
        // case 1:
        //   Get.toNamed("hair_changer", id: 1); // New route for Hair Changer
        //   break;
        case 1:
          Get.toNamed("more", id: 1);
          break;
        case 2:
          Get.toNamed("help_support", id: 1);
          break;
      }
    }
  }

  void onGetProfile() {
    getSession().then(
          (value) {
        if (value.token == null) {
          Logout();
          Tools.ShowErrorMessage('Token Expire');
          Get.offAllNamed('/login');
        }
      },
    );
    getProfile().then(
          (value) {
        if (value.success!) {
          value.data!.token = auth.value.token;
          CreateSession(value.data!.toJson(), true);
        }
      },
    );
  }
}