import 'package:edu_clubs_app/view_model/admin/home/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      init: BannerController(),
      builder: (controller) {
        return Center(
          child: GestureDetector(
            onTap: () => _showBannerDialog(controller, context),
            child: Container(
              width: 368,
              height: 212,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(26)),
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  "Add Banner and Link If have any",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBannerDialog(BannerController controller, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<BannerController>(
          builder: (controller) {
            return AlertDialog(
              title: Text('Add Banner and Link'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.imageLinkController,
                    decoration: InputDecoration(labelText: 'Image Link'),
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
                  onPressed:
                      controller.isUploading ? null : controller.addBanner,
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
