import 'dart:io';
import 'package:edu_clubs_app/repository/admin/admin_home_view_content_add/banner_repository.dart';
import 'package:edu_clubs_app/data/models/admin/home/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BannerController extends GetxController {
  final BannerRepository _bannerRepo = BannerRepository();
  final TextEditingController imageLinkController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool isUploading = false;
  List<BannerModel> banners = [];

  void pickFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update();
    }
  }

  Future<void> addBanner() async {
    if (selectedImage == null) {
      Get.snackbar("Error", "Please select an image",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isUploading = true;
    update();

    final imageUrl = await _bannerRepo.uploadBannerImage(selectedImage!);
    if (imageUrl == null) {
      Get.snackbar("Error", "Image upload failed",
          snackPosition: SnackPosition.BOTTOM);
      isUploading = false;
      update();
      return;
    }

    final banner = BannerModel(
      userId: '4902e25b-18ab-43cd-8e86-5d0cd57cf737',
      bannerImage: imageUrl,
      bannerLink: imageLinkController.text,
    );

    bool success = await _bannerRepo.addBanner(banner);
    if (success) {
      Get.snackbar("Success", "Banner uploaded successfully!",
          snackPosition: SnackPosition.BOTTOM);
      imageLinkController.clear();
      selectedImage = null;
      fetchBanners();
    } else {
      Get.snackbar("Error", "Failed to upload banner",
          snackPosition: SnackPosition.BOTTOM);
    }

    isUploading = false;
    update();
  }

  void fetchBanners() async {
    banners = await _bannerRepo.fetchBanners();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }
}
