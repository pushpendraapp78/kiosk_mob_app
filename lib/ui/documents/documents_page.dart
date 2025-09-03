import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/Constant/color_const.dart';
import 'package:ipbot_app/Utils/tools.dart';
import 'package:ipbot_app/ui/documents/m/document_response.dart';
import 'package:ipbot_app/ui/widgets/confirm_dailog_widget.dart';
import 'package:ipbot_app/ui/widgets/loading_widget.dart';
import 'package:ipbot_app/ui/widgets/sub_txt_widget.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/header_txt_widget.dart';
import 'documents_controller.dart';


class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final _con = Get.put(DocumentsController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _con.refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: HeaderTxtWidget(
          "Dashboard",
          fontSize: 18,
          color: Colors.white,
        ),
        sufix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ActionChip(
              label: SubTxtWidget(
                "Add Document",
                fontSize: 13,
              ),
              color: const WidgetStatePropertyAll(Colors.white),
              shape: const StadiumBorder(),
              padding: EdgeInsets.zero,
              onPressed: () {
                Get.toNamed('/add_document');
              },
            ),
          ],
        ),
        height: 70,
      ),
      body: Obx(
        () => _body(),
      ),
    );
  }

  Widget _body() {
    if (_con.response.value == null) {
      return LoadingWidget(
        type: LoadingType.LIST,
      );
    }
    if (_con.list.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        alignment: AlignmentDirectional.center,
        child: SubTxtWidget('No Document Found'),
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        Data data = _con.list[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: data.otp_status == "Pending"
                  ? Colors.white
                  : Colors.grey.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.blue.shade50, spreadRadius: 3, blurRadius: 2),
              ]),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: SubTxtWidget(
                                'Print Type :',
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SubTxtWidget('${data.printType}'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: SubTxtWidget(
                                'No Of Copies :',
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SubTxtWidget('${data.noOfCopies}'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: SubTxtWidget(
                                'Page Type :',
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SubTxtWidget('${data.pageType}'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: SubTxtWidget(
                                'Amount :',
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SubTxtWidget('${data.amount}'),
                            ),
                          ],
                        ),
                        if (data.otp_status == "Pending")
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: SubTxtWidget(
                                  'Otp :',
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Wrap(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: const BoxDecoration(
                                        color: primaryColorCode,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: SubTxtWidget(
                                        '${data.otp}',
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Column(
                      children: [
                        const Icon(
                          Icons.file_copy_outlined,
                          size: 35,
                        ),
                        SubTxtWidget('Files(1)'),
                        ActionChip(
                          label: SubTxtWidget(
                            "Delete",
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          color: const WidgetStatePropertyAll(Colors.red),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Tools.ShowDailog(
                                context,
                                ConfirmDailogWidget(
                                  title: 'Delete',
                                  sub_title: "Are you sure want to delete?",
                                  onSuccess: () {
                                    _con.onDeleteItem(data);
                                  },
                                  positive_button_text: "Delete",
                                  negative_button_text: "Cancel",
                                ));
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SubTxtWidget(
                      'Created At :',
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SubTxtWidget(
                      '${data.createdAt}',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: _con.list.length,
      physics: const BouncingScrollPhysics(),
    );
  }
}
