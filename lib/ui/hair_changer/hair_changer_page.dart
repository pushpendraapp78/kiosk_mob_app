import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/ui/widgets/header_txt_widget.dart';
import '../../../Constant/color_const.dart';
import 'hair_changer_controller.dart';
import '../widgets/app_bar_widget.dart';

class HairChangerPage extends StatelessWidget {
  const HairChangerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HairChangerController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBarWidget(
        showBackButton: true,
        title: HeaderTxtWidget(
          "Hair Changer",
          fontSize: 24,
          color: Colors.white,
        ),
        height: 75,
      ),
      body: Obx(
            () => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImageSection(controller),
              const SizedBox(height: 24),
              _buildEditingOptions(controller),
              const SizedBox(height: 24),
              _buildActionButton(controller),
              const SizedBox(height: 24),
              Obx(() => controller.isLoading.value
                  ? Column(
                children: [
                  _buildProcessingSection(controller),
                  const SizedBox(height: 16),
                ],
              )
                  : const SizedBox.shrink()),
              Obx(() => controller.resultImageUrl.value.isNotEmpty
                  ? _buildResultSection(controller)
                  : const SizedBox.shrink()),
              Obx(() => controller.errorMessage.value.isNotEmpty
                  ? Column(
                children: [
                  const SizedBox(height: 16),
                  _buildErrorSection(controller),
                  const SizedBox(height: 16),
                  _buildRetryButton(controller),
                ],
              )
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(HairChangerController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select Your Photo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: primaryColorCode,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: controller.isLoading.value ? null : controller.selectImageSource,
              child: Obx(() => Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.selectedImage.value == null
                        ? Colors.grey
                        : primaryColorCode,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                ),
                child: controller.selectedImage.value == null
                    ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                      'Tap to select photo',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    controller.selectedImage.value!,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditingOptions(HairChangerController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transformation Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: primaryColorCode,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Edit Type:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Obx(() => DropdownButtonFormField<String>(
              value: controller.editingType.value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'hairstyle', child: Text('Hairstyle Only')),
                DropdownMenuItem(value: 'color', child: Text('Color Only')),
                DropdownMenuItem(value: 'both', child: Text('Both')),
              ],
              onChanged: controller.isLoading.value ? null : controller.onEditingTypeChanged,
            )),
            const SizedBox(height: 16),
            Obx(() => controller.editingType.value != 'hairstyle'
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hair Color:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: controller.colorDescription.value,
                  onChanged: controller.isLoading.value
                      ? null
                      : (value) => controller.colorDescription.value = value,
                  enabled: !controller.isLoading.value,
                  decoration: InputDecoration(
                    hintText: 'e.g., blonde, red, purple',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            )
                : const SizedBox.shrink()),
            const SizedBox(height: 16),
            Obx(() => controller.editingType.value != 'color'
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hairstyle:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: controller.hairstyleDescription.value.isEmpty
                      ? null
                      : controller.hairstyleDescription.value,
                  decoration: InputDecoration(
                    hintText: 'Select hairstyle',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  items: controller.hairstyles.map((String style) {
                    return DropdownMenuItem<String>(
                      value: style,
                      child: Text(style.replaceAll(' hairstyle', '')),
                    );
                  }).toList(),
                  onChanged: controller.isLoading.value
                      ? null
                      : (String? newValue) {
                    if (newValue != null) {
                      controller.hairstyleDescription.value = newValue;
                    }
                  },
                ),
              ],
            )
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(HairChangerController controller) {
    return Obx(() => SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: controller.isLoading.value ? null : controller.changeHair,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColorCode,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: controller.isLoading.value
            ? const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Processing...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        )
            : const Text(
          '✨ Transform My Hair',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ));
  }

  Widget _buildProcessingSection(HairChangerController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                AnimatedBuilder(
                  animation: controller.animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: controller.animationController.value * 2 * 3.141592653589793,
                      child: const Icon(Icons.refresh, size: 20, color: primaryColorCode),
                    );
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing Transformation',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColorCode,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.statusMessage.value,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(primaryColorCode),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: controller.clearAll,
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection(HairChangerController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 24),
                SizedBox(width: 8),
                Text(
                  'Transformation Complete!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                controller.resultImageUrl.value,
                height: 250,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 250,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250,
                    color: Colors.grey[200],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 48),
                        SizedBox(height: 8),
                        Text('Failed to load result'),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Get.snackbar(
                      'Share',
                      'Share this amazing transformation!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: primaryColorCode,
                      colorText: Colors.white,
                    );
                  },
                  icon: const Icon(Icons.share, color: Colors.white),
                  label: const Text('Share', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColorCode,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: controller.clearAll,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text('New', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorSection(HairChangerController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRetryButton(HairChangerController controller) {
    return SizedBox(
      height: 45,
      child: ElevatedButton.icon(
        onPressed: controller.retryTransformation,
        icon: const Icon(Icons.refresh, color: Colors.white),
        label: const Text('Retry Transformation', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}