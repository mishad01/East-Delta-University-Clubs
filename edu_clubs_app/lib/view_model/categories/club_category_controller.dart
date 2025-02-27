import 'dart:io';
import 'package:edu_clubs_app/data/models/categories_model.dart';
import 'package:edu_clubs_app/data/repositories/admin/club_category_repository.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:image_picker/image_picker.dart';

class ClubCategoriesController extends GetxController {
  final ClubCategoryRepository _repository = ClubCategoryRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  File? _iconImage;
  File? get iconImage => _iconImage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Map<String, dynamic>> _clubCategories = [];
  List<Map<String, dynamic>> get clubCategories => _clubCategories;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchClubCategories();
  }

  void pickIconImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _iconImage = File(pickedFile.path);
      update();
    }
  }

  Future<bool> addClubCategory(String clubName, String description) async {
    if (clubName.isEmpty || description.isEmpty || _iconImage == null) {
      Get.snackbar("Error", "Please fill in all fields and select an image");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final iconImageUrl = await _repository.uploadIconImage(_iconImage!);
    if (iconImageUrl != null) {
      final newCategory = ClubCategoryModel(
        clubName: clubName,
        createdAt: DateTime.now().toIso8601String(),
        iconImg: iconImageUrl,
        description: description,
      );

      final success = await _repository.addClubCategory(newCategory);
      if (success) {
        isSuccess = true;
        fetchClubCategories();
        Get.snackbar("Success", "Club category added successfully!");
      } else {
        _errorMessage = "Failed to add club category.";
        Get.snackbar("Error", _errorMessage!);
      }
    } else {
      _errorMessage = "Image upload failed.";
      Get.snackbar("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<void> fetchClubCategories() async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      final response = await _repository.fetchClubCategories();
      _clubCategories = response;
    } catch (e) {
      _errorMessage = 'Failed to load data: $e';
    }

    _inProgress = false;
    update();
  }

  void clearFields() {
    _iconImage = null;
    update();
  }
}
