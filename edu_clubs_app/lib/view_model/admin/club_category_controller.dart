import 'dart:io';
import 'package:edu_clubs_app/repository/club_category_repository.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/categories/categories_model.dart';
import 'package:image_picker/image_picker.dart';

class ClubCategoryController extends GetxController {
  final ClubCategoryRepository _repository = ClubCategoryRepository();
  final TextEditingController clubNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var isLoading = false.obs;
  var iconImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  void pickIconImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      iconImage.value = File(pickedFile.path);
    }
  }

  Future<void> addClubCategory() async {
    if (clubNameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        iconImage.value == null) {
      Get.snackbar("Error", "Please fill in all fields and select an image");
      return;
    }

    isLoading.value = true;

    final iconImageUrl = await _repository.uploadIconImage(iconImage.value!);
    if (iconImageUrl != null) {
      final newCategory = ClubCategoryModel(
        clubName: clubNameController.text,
        createdAt: DateTime.now().toIso8601String(),
        iconImg: iconImageUrl,
        description: descriptionController.text,
      );

      final success = await _repository.addClubCategory(newCategory);
      if (success) {
        Get.snackbar("Success", "Club category added successfully!");
        clearFields();
      } else {
        Get.snackbar("Error", "Failed to add club category.");
      }
    } else {
      Get.snackbar("Error", "Image upload failed.");
    }

    isLoading.value = false;
  }

  void clearFields() {
    clubNameController.clear();
    descriptionController.clear();
    iconImage.value = null;
  }
}
