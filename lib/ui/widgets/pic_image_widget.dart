import 'package:flutter/material.dart';
import 'package:ipbot_app/ui/widgets/sub_txt_widget.dart';

class PicImageWidget extends StatelessWidget {
  Function() onCamera;
  Function() onGallery;
  PicImageWidget(
      {required this.onGallery,
      required this.onCamera});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                ]),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SubTxtWidget("Select image from"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   IconButton(onPressed: () {
                     onCamera.call();
                     Navigator.pop(context);
                   }, icon: const Icon(Icons.camera_alt,size: 50,)),
                    IconButton(onPressed: () {
                      onGallery.call();
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.photo,size: 50,))

                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
