import 'dart:convert';
import 'package:flutter/material.dart';

class ViewImageWidget extends StatelessWidget {
  String image;
  ViewImageWidget({required this.image});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Container(
        height: MediaQuery.of(context).size.height*0.8,
        alignment: AlignmentDirectional.center,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
              ]),
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.memory(
                  base64Decode(image),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(top: 0,right: 0,child: IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: const Icon(Icons.cancel,color: Colors.white,)),)
            ],
          ),
        ),
      )
    );
  }
}
