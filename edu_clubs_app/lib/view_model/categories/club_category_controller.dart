import 'package:edu_clubs_app/data/models/categories_model.dart';
import 'package:edu_clubs_app/data/repositories/admin/club_category_repository.dart';
import 'package:get/get.dart';
import 'dart:io';

class ClubCategoryController extends GetxController {
  final ClubCategoryRepository _repository = ClubCategoryRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ClubCategoryModel> _categories = [];
  List<ClubCategoryModel> get categories => _categories;

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // Call fetchCategories on init
  }

  Future<bool> addCategory(
      String clubName, File iconImgFile, String description) async {
    if (clubName.isEmpty || description.isEmpty) {
      Get.snackbar("Error", "Please enter all required fields.");
      return false;
    }

    _inProgress = true;
    _errorMessage = null;
    update();

    // Upload the icon image
    final iconImageUrl = await _repository.uploadIconImage(iconImgFile);
    if (iconImageUrl == null) {
      _inProgress = false;
      _errorMessage = "Failed to upload icon image.";
      update();
      Get.snackbar("Error", _errorMessage!);
      return false;
    }

    final newCategory = ClubCategoryModel(
      clubName: clubName,
      iconImg: iconImageUrl,
      description: description,
    );

    final success = await _repository.addClubCategory(newCategory);
    if (success) {
      _inProgress = false;
      Future.delayed(Duration.zero, () {
        Get.snackbar("Success", "Club category added successfully!");
      });
      fetchCategories(); // Refresh the category list
      return true;
    } else {
      _inProgress = false;
      _errorMessage = "Failed to add club category.";
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
      return false;
    }
  }

  Future<void> fetchCategories() async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _categories = await _repository.fetchClubCategories();
      print("Fetched categories: $_categories");
    } catch (e) {
      _errorMessage = 'Failed to load categories: $e';
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
  }

  Future<bool> deleteCategory(String categoryId) async {
    _inProgress = true;
    _errorMessage = null;
    update(); // Notify UI to rebuild before deletion starts

    bool isSuccess = await _repository.deleteClubCategory(categoryId);
    if (isSuccess) {
      // Remove the category from the list after successful deletion
      _categories.removeWhere((category) => category.id == categoryId);

      Get.snackbar("Success", "Club category deleted successfully!");
    } else {
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update(); // Notify UI to rebuild after deletion is completed
    return isSuccess;
  }
}
