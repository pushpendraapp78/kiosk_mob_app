import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Constant/color_const.dart';
enum LoadingType{
  LIST,MyEvent,DASHBOARD
}
class LoadingWidget extends StatelessWidget {
  LoadingType type;
  LoadingWidget({this.type=LoadingType.LIST});
  @override
  Widget build(BuildContext context) {
    if(type==LoadingType.LIST){
      return _listLoading();
    }
    if(type==LoadingType.DASHBOARD){
      return _dashboardLoading();
    }
    if(type==LoadingType.MyEvent){
      return _myEventLoading();
    }
    return _listLoading();
    }
  Widget _listLoading(){
    return ListView.builder(itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.lightBlueAccent.shade100,
                  spreadRadius: 1,
                  blurRadius: 2
              )
            ]
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Container(
                    height: 25,
                    color: Colors.grey,
                    margin: EdgeInsets.only(right: 10,),
                  ),flex: 2,),
                  Expanded(child: Container(
                    height: 25,
                    margin: EdgeInsets.only(left: 10),
                    color: Colors.grey,
                  ),flex: 4,),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Container(
                    height: 25,
                    color: Colors.grey,
                    margin: EdgeInsets.only(right: 10,top: 10),
                  ),flex: 2,),
                  Expanded(child: Container(
                    height: 25,
                    margin: EdgeInsets.only(left: 10,top: 10),
                    color: Colors.grey,
                  ),flex: 4,),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Container(
                    height: 25,
                    color: Colors.grey,
                    margin: EdgeInsets.only(right: 10,top: 10),
                  ),flex: 2,),
                  Expanded(child: Container(
                    height: 25,
                    margin: EdgeInsets.only(left: 10,top: 10),
                    color: Colors.grey,
                  ),flex: 4,),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Container(
                    height: 25,
                    color: Colors.grey,
                    margin: EdgeInsets.only(right: 10,top: 10),
                  ),flex: 2,),
                  Expanded(child: Container(
                    height: 25,
                    margin: EdgeInsets.only(left: 10,top: 10),
                    color: Colors.grey,
                  ),flex: 4,),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Container(
                    height: 25,
                    color: Colors.grey,
                    margin: EdgeInsets.only(right: 10,top: 10),
                  ),flex: 2,),
                  Expanded(child: Container(
                    height: 25,
                    margin: EdgeInsets.only(left: 10,top: 10),
                    color: Colors.grey,
                  ),flex: 4,),
                ],
              ),
            ],
          ),
        ),
      );
    },itemCount: 4,shrinkWrap: true,padding: EdgeInsets.zero);
  }
  Widget _dashboardLoading(){
    return ListView.builder(itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: primaryColorCode.withOpacity(0.2),
        highlightColor: Colors.white,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    height: 20,
                    margin: EdgeInsets.symmetric(vertical: 3),
                    color: Colors.grey,
                  ),
                  Container(
                    width: 80,
                    height: 20,
                    margin: EdgeInsets.symmetric(vertical: 3),
                    color: Colors.grey,
                  )
                ],
              ),
              Container(
                height: 180,
                child: ListView.builder(itemBuilder: (context, index){
                  return Container(
                    width: 250,
                    height: 150,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey,
                    ),
                    margin: EdgeInsets.only(
                      top: 5,
                      right: 10,
                      bottom: 5
                    ),
                  );
                },itemCount: 2,shrinkWrap: true,scrollDirection: Axis.horizontal,),
              ),
            ],
          ),
        ),
      );
    },itemCount: 5,shrinkWrap: true,padding: EdgeInsets.zero);
  }
  Widget _myEventLoading(){
    return AbsorbPointer(
      absorbing: true,
      child: ListView.builder(itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: primaryColorCode.withOpacity(0.2),
          highlightColor: Colors.white,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                ),
              ),
              title: Container(
                width: 80,
                height: 25,
                margin: EdgeInsets.symmetric(vertical: 3),
                color: Colors.grey,
              ),
              subtitle: Container(
                width: 100,
                height: 25,
                margin: EdgeInsets.symmetric(vertical: 3),
                color: Colors.grey,
              ),
              tileColor: Theme.of(context).cardColor,
            ),
          ),
        );
      },itemCount: 8,shrinkWrap: true,padding: EdgeInsets.zero)
    );
  }
}
