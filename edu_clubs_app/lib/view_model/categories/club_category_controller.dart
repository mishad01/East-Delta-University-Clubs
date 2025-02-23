import 'dart:io';
import 'package:edu_clubs_app/repository/admin/club_category_repository.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/categories/categories_model.dart';
import 'package:image_picker/image_picker.dart';

class ClubCategoriesController extends GetxController {
  final ClubCategoryRepository _repository = ClubCategoryRepository();
  var isLoading = false.obs;
  var iconImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  var errorMessage = ''.obs;
  var clubCategories = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchClubCategories(); // Fetch categories when the controller is initialized
  }

  void pickIconImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      iconImage.value = File(pickedFile.path);
    }
  }

  Future<void> addClubCategory(String clubName, String description) async {
    if (clubName.isEmpty || description.isEmpty || iconImage.value == null) {
      Get.snackbar("Error", "Please fill in all fields and select an image");
      return;
    }

    isLoading.value = true;

    final iconImageUrl = await _repository.uploadIconImage(iconImage.value!);
    if (iconImageUrl != null) {
      final newCategory = ClubCategoryModel(
        clubName: clubName,
        createdAt: DateTime.now().toIso8601String(),
        iconImg: iconImageUrl,
        description: description,
      );

      final success = await _repository.addClubCategory(newCategory);
      if (success) {
        Get.snackbar("Success", "Club category added successfully!");
        fetchClubCategories(); // Fetch categories again after adding a new one
      } else {
        Get.snackbar("Error", "Failed to add club category.");
      }
    } else {
      Get.snackbar("Error", "Image upload failed.");
    }

    isLoading.value = false;
  }

  Future<void> fetchClubCategories() async {
    isLoading.value = true;
    try {
      final response = await _repository.fetchClubCategories();
      clubCategories.value = response;
    } catch (e) {
      errorMessage.value = 'Failed to load data: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    iconImage.value = null;
  }
}
