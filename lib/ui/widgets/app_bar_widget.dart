import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/Constant/color_const.dart';
import 'package:ipbot_app/ext/hex_color.dart';

typedef callback = Function();

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  Widget? bottom;
  Widget? title;
  Widget? sufix;
  EdgeInsets? margin;
  bool showBackButton;
  BorderRadius? borderRadius;
  double? height;
  AppBarWidget(
      {this.bottom,
      this.onTap,
      this.title,
      this.margin,
      this.showBackButton = false,
      this.borderRadius,
      this.height,
      this.sufix});
  callback? onTap;
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColorCode,
          borderRadius: borderRadius ??
              const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (showBackButton)
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white)),
              if (title != null)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: showBackButton ? 10 : 20),
                    child: title!,
                  ),
                ),
              if (sufix != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: sufix!,
                )
            ],
          ),
          if (bottom != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: bottom!,
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? (bottom != null ? 130 : 90));
}
