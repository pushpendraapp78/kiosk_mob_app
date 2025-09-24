import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ipbot_app/Utils/tools.dart';
import '../../../repo/auth_repo.dart';
import '../../repo/setting_repo.dart';
import './m/hair_changer_response.dart';

class HairChangerController extends GetxController with GetTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();

  // Form fields
  var selectedImage = Rxn<File>();
  var editingType = 'hairstyle'.obs;
  var colorDescription = ''.obs;
  var hairstyleDescription = 'bob cut hairstyle'.obs;
  var resultImageUrl = ''.obs;
  var originalImageUrl = ''.obs;
  var currentReferenceId = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var statusMessage = ''.obs;

  final List<String> hairstyles = [
    'afro hairstyle',
    'bob cut hairstyle',
    'bowl cut hairstyle',
    'braid hairstyle',
    'caesar cut hairstyle',
    'pixie cut hairstyle',
    'long wavy hairstyle',
    'short curly hairstyle',
    'bun hairstyle',
    'ponytail hairstyle',
  ];

  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    hairstyleDescription.value = hairstyles[1];
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void selectImageSource() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Get.back();
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Get.back();
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        errorMessage.value = '';
        statusMessage.value = '';
      }
    } catch (e) {
      errorMessage.value = 'Failed to pick image: $e';
      Tools.ShowErrorMessage(errorMessage.value);
    }
  }

  Future<void> changeHair() async {
    if (selectedImage.value == null) {
      errorMessage.value = 'Please select an image first';
      Tools.ShowErrorMessage(errorMessage.value);
      return;
    }

    if (editingType.value == 'both' &&
        (colorDescription.value.isEmpty || hairstyleDescription.value.isEmpty)) {
      errorMessage.value = 'Please provide both color and hairstyle descriptions';
      Tools.ShowErrorMessage(errorMessage.value);
      return;
    }

    if (editingType.value == 'color' && colorDescription.value.isEmpty) {
      errorMessage.value = 'Please provide hair color description';
      Tools.ShowErrorMessage(errorMessage.value);
      return;
    }

    if (editingType.value == 'hairstyle' && hairstyleDescription.value.isEmpty) {
      errorMessage.value = 'Please select a hairstyle';
      Tools.ShowErrorMessage(errorMessage.value);
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    statusMessage.value = 'Starting hair transformation...';
    resultImageUrl.value = '';
    currentReferenceId.value = '';

    try {
      String? userId = auth.value.id?.toString();

      var response = await processHairTransformation(
        imageFile: selectedImage.value!,
        userId: userId,
        transformationType: editingType.value,
        colorDescription: editingType.value != 'hairstyle' ? colorDescription.value : null,
        hairstyleDescription: editingType.value != 'color' ? hairstyleDescription.value : null,
      );

      if (response.success == true) {
        currentReferenceId.value = response.referenceId ?? '';
        originalImageUrl.value = response.originalImageUrl ?? '';
        resultImageUrl.value = response.resultUrl ?? '';
        if (resultImageUrl.value.isNotEmpty) {
          isLoading.value = false;
          statusMessage.value = '';
        } else {
          isLoading.value = false;
          errorMessage.value = 'No result image received';
          Tools.ShowErrorMessage(errorMessage.value);
        }
      } else {
        isLoading.value = false;
        errorMessage.value = response.error ?? 'Failed to start transformation';
        statusMessage.value = '';
        Tools.ShowErrorMessage(errorMessage.value);
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Error: $e';
      statusMessage.value = '';
      Tools.ShowErrorMessage(errorMessage.value);
    }
  }

  void clearAll() {
    isLoading.value = false;
    selectedImage.value = null;
    resultImageUrl.value = '';
    originalImageUrl.value = '';
    currentReferenceId.value = '';
    colorDescription.value = '';
    hairstyleDescription.value = hairstyles[1];
    errorMessage.value = '';
    statusMessage.value = '';
    editingType.value = 'hairstyle';
  }

  void onEditingTypeChanged(String? newValue) {
    if (newValue != null) {
      editingType.value = newValue;

      if (newValue == 'hairstyle') {
        colorDescription.value = '';
      } else if (newValue == 'color') {
        hairstyleDescription.value = hairstyles[1];
      }
    }
  }

  void retryTransformation() {
    errorMessage.value = '';
    statusMessage.value = 'Retrying transformation...';
    changeHair();
  }
}