import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/tools.dart';
import '../../repo/session_repo.dart';
import '../widgets/confirm_dailog_widget.dart';
import '../widgets/header_txt_widget.dart';
import '../widgets/sub_txt_widget.dart';
import 'setting_controller.dart';

class SettingPage extends StatelessWidget {
   SettingPage({Key? key}) : super(key: key);
  final _con = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: HeaderTxtWidget("Setting"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: SubTxtWidget("Privacy Policy"),
              leading: const Icon(Icons.privacy_tip_outlined),
              onTap: (){
                Get.toNamed('/privacy_policy');
              },
            ),
            ListTile(
              title: SubTxtWidget("Terms & Condition"),
              leading: const Icon(Icons.info_outline),
              onTap: (){
                Get.toNamed('/term_condition');
              },
            ),
            ListTile(
              title: SubTxtWidget("Logout"),
              leading: const Icon(Icons.exit_to_app_rounded),
              onTap: (){
                Tools.ShowDailog(context, ConfirmDailogWidget(title: "Logout Account", sub_title: "Are you sure want to logout?",negative_button_text: "Cancel",
                  positive_button_text: "Logout",onSuccess: () {
                    Logout();
                    Get.offAllNamed('/login');
                  },));
              },
            ),
            ListTile(
              title: SubTxtWidget("Delete Account",color: Colors.red),
              leading: const Icon(Icons.delete_forever,color: Colors.red,),
              onTap: (){
                Tools.ShowDailog(context, ConfirmDailogWidget(title: "Delete Account", sub_title: "Warning: Deleting your account will permanently erase all your data and cannot be undone. Are you sure you want to proceed?",negative_button_text: "Cancel",
                positive_button_text: "Delete",onSuccess: () {
                  _con.onDeleteAccount();
                },));
              },
            ),
          ],
        ),
      ),
    );
  }
}
