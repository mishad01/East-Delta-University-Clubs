import 'dart:io';
import 'package:edu_clubs_app/data/models/admin/home/prize_giving_ceremony_model.dart';
import 'package:edu_clubs_app/data/repositories/admin/admin_home_view_content_add/prize_giving_card_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PrizeGivingCeremonyController extends GetxController {
  final PrizeGivingCeremonyRepository _prizeGivingRepo =
      PrizeGivingCeremonyRepository();
  final TextEditingController ceremonyNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool isUploading = false;
  List<PrizeGivingCeremonyModel> ceremonies = [];

  void pickFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update();
    }
  }

  Future<void> addPrizeGivingCeremony() async {
    if (selectedImage == null ||
        ceremonyNameController.text.isEmpty ||
        dateController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields and select an image",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isUploading = true;
    update();

    final imageUrl =
        await _prizeGivingRepo.uploadPrizeGivingImage(selectedImage!);
    if (imageUrl == null) {
      Get.snackbar("Error", "Image upload failed",
          snackPosition: SnackPosition.BOTTOM);
      isUploading = false;
      update();
      return;
    }

    final ceremony = PrizeGivingCeremonyModel(
      userId:
          '4902e25b-18ab-43cd-8e86-5d0cd57cf737', // Replace with actual userId dynamically if needed
      prizeGivingCeremonyName: ceremonyNameController.text,
      prizeGivingImage: imageUrl,
      prizeGivingDate: dateController.text,
    );

    bool success = await _prizeGivingRepo.addPrizeGivingCeremony(ceremony);
    if (success) {
      Get.snackbar("Success", "Prize giving ceremony added successfully!",
          snackPosition: SnackPosition.BOTTOM);
      ceremonyNameController.clear();
      dateController.clear();
      selectedImage = null;
      fetchCeremonies();
    } else {
      Get.snackbar("Error", "Failed to add ceremony",
          snackPosition: SnackPosition.BOTTOM);
    }

    isUploading = false;
    update();
  }

  void fetchCeremonies() async {
    ceremonies = await _prizeGivingRepo.fetchCeremonies();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchCeremonies();
  }
}
