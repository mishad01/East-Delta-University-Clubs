import 'dart:io';
import 'package:edu_clubs_app/data/models/club_events_model.dart';
import 'package:edu_clubs_app/data/repositories/admin/admin_club_event_repository.dart';
import 'package:get/get.dart';

class ClubEventController extends GetxController {
  final ClubEventRepository _repository = ClubEventRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ClubEventModel> _clubEvents = [];
  List<ClubEventModel> get clubEvents => _clubEvents;

  // Upload event image and return the image URL
  Future<String?> uploadEventImage(File imageFile) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    final String? imageUrl = await _repository.uploadImage(imageFile, 'events');

    _inProgress = false;
    update();

    if (imageUrl != null) {
      return imageUrl;
    } else {
      _errorMessage = "Failed to upload image.";
      update();
      Get.snackbar("Error", _errorMessage!);
      return null;
    }
  }

  // Add a new club event
  Future<bool> addClubEvent(
    String clubDetailsId,
    String sessionImages,
    String sessionName,
    String sessionDate,
  ) async {
    if (clubDetailsId.isEmpty || sessionName.isEmpty || sessionImages.isEmpty) {
      Get.snackbar("Error", "Please fill in all required fields.");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final newClubEvent = ClubEventModel(
        clubDetailsId: clubDetailsId,
        sessionImages: sessionImages,
        sessionName: sessionName,
        sessionDate: sessionDate);

    final success = await _repository.addClubEvent(newClubEvent);
    if (success) {
      isSuccess = true;
      Future.delayed(Duration.zero, () {
        Get.snackbar("Success", "Club event added successfully!");
      });
    } else {
      _errorMessage = "Failed to add club event.";
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  // Fetch all events for a specific club
  Future<void> fetchClubEvents(String clubDetailsId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _clubEvents = await _repository.fetchEventDetails(clubDetailsId);
      print("Fetched club events: $_clubEvents");
    } catch (e) {
      _errorMessage = 'Failed to load club events: $e';
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
  }

  Future<bool> deleteClubEvent(String clubId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    bool isSuccess = false;

    final success = await _repository.deleteClubEvent(clubId);
    if (success) {
      isSuccess = true;
      _clubEvents.removeWhere((club) => club.id == clubId);

      Get.snackbar("Success", "Club details deleted successfully!");
    } else {
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
