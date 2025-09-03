import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/ui/widgets/sub_txt_widget.dart';
import '../../Constant/color_const.dart';
import '../widgets/button_primary_widget.dart';
import '../widgets/dropdown_widget.dart';
import '../widgets/header_txt_widget.dart';
import 'documents_controller.dart';

class AddDocumentView extends StatefulWidget {
  const AddDocumentView({super.key});

  @override
  State<AddDocumentView> createState() => _AddDocumentViewState();
}

class _AddDocumentViewState extends State<AddDocumentView> {
  final DocumentsController _con = Get.put(DocumentsController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: HeaderTxtWidget('Add Document'),
        backgroundColor: scaffoldBackgroundColor,
      ),
      body: Obx(
            () => SingleChildScrollView(
          controller: _scrollController,
          child: Form(
            key: _con.formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  DropdownWidget<String>(
                    title: 'Paper size',
                    value: _con.pageType,
                    items: ['A4']
                        .map(
                          (e) => DropdownMenuItem(
                        value: e,
                        child: SubTxtWidget(e),
                      ),
                    )
                        .toList(),
                    onChanged: (item) {
                      _con.pageType = item;
                    },
                    errorMsg: "Paper size",
                  ),
                  DropdownWidget<String>(
                    title: 'Print Type',
                    value: _con.printType,
                    items: ['Color', 'Black & White']
                        .map(
                          (e) => DropdownMenuItem(
                        value: e,
                        child: SubTxtWidget(e),
                      ),
                    )
                        .toList(),
                    onChanged: (item) {
                      _con.printType = item;
                      _con.getAmount();
                    },
                    errorMsg: "Required Print Type",
                  ),
                  DropdownWidget<String>(
                    title: 'No Of Copies',
                    value: _con.noOfCopies,
                    items: List.generate(
                      10,
                          (i) => DropdownMenuItem(
                        value: '${i + 1}',
                        child: SubTxtWidget('${i + 1}'),
                      ),
                    ),
                    onChanged: (item) {
                      _con.noOfCopies = item;
                    },
                    errorMsg: "Required no of copies",
                  ),
                  Wrap(
                    children: [
                      for (var file in _con.files)
                        Container(
                          width: 100,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                            border: Border.all(color: color_E4DFDF),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 10),
                                  const Icon(Icons.file_copy_outlined),
                                  const SizedBox(height: 5),
                                  SubTxtWidget(
                                    file.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12,
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                              Positioned(
                                top: -10,
                                right: -10,
                                child: IconButton(
                                  onPressed: () {
                                    _con.files.remove(file);
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                            ],
                          ),
                        ),
                      GestureDetector(
                        onTap: () async {
                          FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['docx', 'doc', 'pdf'],
                          );

                          if (result != null) {
                            _con.files.addAll(result.files);
                          }
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          alignment: AlignmentDirectional.center,
                          color: Colors.grey.shade100,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Icon(
                            Icons.attach_file,
                            color: Colors.grey.shade400,
                            size: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ButtonPrimaryWidget(
                    "Submit",
                    onTap: () {
                      if (_con.formKey.currentState!.validate()) {
                        Get.toNamed('/preview_document');
                      }
                    },
                    isLoading: _con.isLoading.value,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
