import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../Constant/color_const.dart'; //Not using anything from it
import '../../generated/assets.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  // const SplashPage({Key? key}) : super(key: key);
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    //ignored: unused_local_variable
    // final controller = Get.put(SplashController());
    Get.put(SplashController());

    //Previous Code
    // return Container(
    //   color: Colors.white,
    //   padding: const EdgeInsets.all(50),
    //   child: Image.asset(Assets.imgLogo),
    // );
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Image.asset(Assets.imgLogo),
        ),
      ),
    );
  }
}
