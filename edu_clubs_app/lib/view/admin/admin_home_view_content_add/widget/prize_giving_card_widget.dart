import 'dart:io';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/admin/home/prize_giving_ceremony_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HighlightCardWidget extends StatelessWidget {
  final PrizeGivingCeremonyController controller =
      Get.put(PrizeGivingCeremonyController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrizeGivingCeremonyController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => _showPrizeGivingDialog(controller, context),
          child: Container(
            child: Stack(
              children: [
                SvgPicture.asset(
                  AssetsPath.card,
                  width: 300,
                  height: 320,
                ),
                _buildHighlightText(
                    controller.ceremonyNameController.text.isEmpty
                        ? "Add Ceremony Name"
                        : controller.ceremonyNameController.text,
                    20,
                    10),
                _buildHighlightText(
                    controller.dateController.text.isEmpty
                        ? "Add Date"
                        : controller.dateController.text,
                    220,
                    10,
                    fontSize: 10),
                _buildAddImageButton(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPrizeGivingDialog(
      PrizeGivingCeremonyController controller, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<PrizeGivingCeremonyController>(
          builder: (controller) {
            return AlertDialog(
              title: Text('Add Banner and Link'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.ceremonyNameController,
                    decoration: InputDecoration(labelText: 'Add Ceremony Name'),
                    enabled: !controller.isUploading,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: controller.dateController,
                    decoration: InputDecoration(labelText: 'Add Date'),
                    enabled: !controller.isUploading,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed:
                        controller.isUploading ? null : controller.pickFile,
                    child: Text('Pick Image'),
                  ),
                  SizedBox(height: 10),
                  if (controller.selectedImage != null)
                    Image.file(
                      controller.selectedImage!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 10),
                  if (controller.isUploading)
                    Center(child: CircularProgressIndicator()),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: controller.isUploading
                      ? null
                      : controller.addPrizeGivingCeremony,
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Positioned _buildHighlightText(String text, double left, double top,
      {double fontSize = 14}) {
    return Positioned(
      left: left,
      top: top,
      child: Text(
        text,
        style: GoogleFonts.sourceSerif4(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }

  Widget _buildAddImageButton(PrizeGivingCeremonyController controller) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: controller.isUploading ? null : () async {},
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Text(
            "Add Prize Giving Ceremony Image",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          if (controller.selectedImage != null) ...[
            SizedBox(height: 10),
            Image.file(
              controller.selectedImage!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ],
        ],
      ),
    );
  }
}
