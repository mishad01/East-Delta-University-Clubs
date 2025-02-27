import 'dart:io';
import 'package:edu_clubs_app/data/repositories/admin/admin_club_event_repository.dart';
import 'package:edu_clubs_app/data/models/club_events_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ClubEventController extends GetxController {
  final ClubEventRepository _repository = ClubEventRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String sessionName = ''; // Just a normal String, no RxString
  File? sessionImage;
  List<Map<String, dynamic>> allEvents = [];

  final ImagePicker _picker = ImagePicker();

  void pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      sessionImage = File(pickedFile.path);
    }
  }

  Future<bool> addClubEvent(String clubDetailsId) async {
    bool isSuccess = false;
    if (sessionImage == null || sessionName.isEmpty) {
      Get.snackbar(
          "Error", "Please select an image and provide a session name");
      return false;
    }

    _inProgress = true;
    update(); // Call update to refresh the UI after the change

    try {
      final sessionImageUrl =
          await _repository.uploadImage(sessionImage!, 'session_images');

      if (sessionImageUrl == null) {
        Get.snackbar("Error", "Image upload failed.");
        return false;
      }

      final newEvent = ClubEventModel(
        clubDetailsId: clubDetailsId,
        sessionImages: sessionImageUrl,
        sessionName: sessionName,
      );

      final success = await _repository.addClubEvent(newEvent);
      if (success) {
        Get.snackbar("Success", "Club event added successfully!");
        clearFields();
        isSuccess = true;
      } else {
        Get.snackbar("Error", "Failed to add club event.");
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
      Get.snackbar("Error", _errorMessage!);
      print("Add event error: $e");
    } finally {
      _inProgress = false;
      update();
    }

    return isSuccess;
  }

  void clearFields() {
    sessionName = '';
    sessionImage = null;
  }

  Future<bool> fetchEvents(String clubDetailsId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    try {
      final response = await _repository.fetchEventDetails(clubDetailsId);
      allEvents = response;
      isSuccess = true;
    } catch (e) {
      _errorMessage = 'Failed to load events.';
      print("Fetch events error: $e");
    } finally {
      _inProgress = false;
      update();
    }

    return isSuccess;
  }
}
