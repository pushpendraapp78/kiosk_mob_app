import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/ext/hex_color.dart';
import '../../Constant/color_const.dart';
import '../../generated/assets.dart';
import '../../repo/session_repo.dart';
import '../../repo/setting_repo.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/header_txt_widget.dart';
import '../widgets/sub_txt_widget.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final _con = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: HeaderTxtWidget(
          "More",
          fontSize: 20,
          color: Colors.white,
        ),
        height: 70,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            tile(
                assetName: Assets.svgUser,
                name: "Edit Profile",
                onTap: () {
                  Get.toNamed('/edit_profile');
                }),
            tile(
                assetName: Assets.svgLockClosed,
                name: "Change Password",
                onTap: () {
                  Get.toNamed('/update_password');
                }),
            tile(
                assetName: Assets.svgAdd,
                name: "Setting",
                onTap: () {
                  Get.toNamed('/setting');
                }),
          ],
        ),
      ),
    );
  }

  Widget tile({required String assetName, required String name, onTap,Icon? icon}) {
    return Container(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: "#575C8A0F".toColor(),
                blurRadius: 5,
                offset: const Offset(0.2, 0.8))
          ]),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: primaryColorCode.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.all(8),
              child:icon??SvgPicture.asset(
                assetName,
                height: 22,
                width: 22,
                color: primaryColorCode,
              ),
            ),
            Expanded(
                child: HeaderTxtWidget(
              name,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            )),
           Container(
             padding: const EdgeInsets.all(5),
             decoration: const BoxDecoration(
               color: primaryColorCode,
               shape: BoxShape.circle
             ),
             child: const Icon(Icons.arrow_forward,color: Colors.white,size: 18,),
           ),
          ],
        ),
      ),
    );
  }
}
