import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../Utils/tools.dart';
import '../../repo/session_repo.dart';
import '../widgets/confirm_dailog_widget.dart';
import '../widgets/header_txt_widget.dart';
import '../widgets/sub_txt_widget.dart';
import 'setting_controller.dart';

class TermConditionView extends StatefulWidget {
  const TermConditionView({super.key});

  @override
  State<TermConditionView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<TermConditionView> {
  final _con = Get.put(SettingController());
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.onGetTermCondition();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: HeaderTxtWidget("Term & Condition"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Obx(() => _body(),),
      ),
    );
  }
  Widget _body(){
  if(_con.isLoading.value){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  if(_con.term!.isEmpty){
    return Center(
      child:SubTxtWidget('No Privacy policy found'),
    );
  }
  return SingleChildScrollView(
    child: Html(data:_con.term!.value),
  );
  }
}
