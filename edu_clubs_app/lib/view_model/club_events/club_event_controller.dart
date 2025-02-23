import 'dart:io';
import 'package:edu_clubs_app/repository/admin/admin_club_event_repository.dart';
import 'package:edu_clubs_app/view_model/club_events/club_events.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ClubEventController extends GetxController {
  final ClubEventRepository _repository = ClubEventRepository();
  var sessionName = ''.obs;
  var sessionImage = Rx<File?>(null);
  var isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();
  var errorMessage = ''.obs;
  var allEvents = <Map<String, dynamic>>[].obs;

  void pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      sessionImage.value = File(pickedFile.path);
    }
  }

  Future<void> addClubEvent(String clubDetailsId) async {
    if (sessionImage.value == null || sessionName.value.isEmpty) {
      Get.snackbar(
          "Error", "Please select an image and provide a session name");
      return;
    }

    isLoading.value = true;

    try {
      final sessionImageUrl =
          await _repository.uploadImage(sessionImage.value!, 'session_images');

      if (sessionImageUrl == null) {
        Get.snackbar("Error", "Image upload failed.");
        return;
      }

      final newEvent = ClubEventModel(
        clubDetailsId: clubDetailsId,
        sessionImages: sessionImageUrl,
        sessionName: sessionName.value,
      );

      final success = await _repository.addClubEvent(newEvent);
      if (success) {
        Get.snackbar("Success", "Club event added successfully!");
        clearFields();
      } else {
        Get.snackbar("Error", "Failed to add club event.");
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred.");
      print("Add event error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    sessionName.value = '';
    sessionImage.value = null;
  }

  Future<void> fetchEvents(String clubDetailsId) async {
    isLoading.value = true;
    try {
      final response = await _repository.fetchEventDetails(clubDetailsId);
      allEvents.value = response;
    } catch (e) {
      errorMessage.value = 'Failed to load data';
      print("Fetch events error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
