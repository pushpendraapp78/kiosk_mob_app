import 'package:get/get.dart';
import '../../Utils/tools.dart';
import '../../repo/auth_repo.dart';
import '../../repo/session_repo.dart';

class SettingController extends GetxController {
  RxString? term;
  RxString privacy=RxString("");
  RxBool isLoading=false.obs;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  void onDeleteAccount(){
    Tools.ShowSuccessMessage("Your delete account request submitted successfully");
    deleteAccount();
    Logout();
    Get.offAllNamed('/login');
  }
  void onGetTermCondition(){
    isLoading.value=true;
    getTermCondition().then((value) {
      isLoading.value=false;
      term=RxString(value.data!);
    },);
  }
  void onGetPrivacyPolicy(){
    isLoading.value=true;
    getPrivacyPolicy().then((value) {
      isLoading.value=false;
      privacy=RxString(value.data!);
    },);
  }
}
