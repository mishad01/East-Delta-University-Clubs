import 'package:edu_clubs_app/data/models/recent_and_upcoming_activities_model.dart';
import 'package:edu_clubs_app/data/repositories/admin/recent_upcoming_activities_repository.dart';
import 'package:get/get.dart';

class ActivitiesController extends GetxController {
  final ActivitiesRepository _repository = ActivitiesRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ActivitiesModel> _activities = [];
  List<ActivitiesModel> get activities => _activities;

  Future<bool> addActivity(
    String clubDetailsId,
    String recentOpeningDetails,
    String recentOpeningLink,
    String upcomingActivitiesDetails,
    String upcomingActivitiesLink,
  ) async {
    if (clubDetailsId.isEmpty ||
        recentOpeningDetails.isEmpty ||
        recentOpeningLink.isEmpty ||
        upcomingActivitiesDetails.isEmpty ||
        upcomingActivitiesLink.isEmpty) {
      Get.snackbar("Error", "Please fill in all required fields.");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final newActivity = ActivitiesModel(
      clubDetailsId: clubDetailsId,
      recentOpeningDetails: recentOpeningDetails,
      recentOpeningLink: recentOpeningLink,
      upcomingActivitiesDetails: upcomingActivitiesDetails,
      upcomingActivitiesLink: upcomingActivitiesLink,
    );

    final success = await _repository.addRecentUpcomingActivity(newActivity);
    if (success) {
      isSuccess = true;
      Future.delayed(Duration.zero, () {
        Get.snackbar("Success", "Activity added successfully!");
      });
    } else {
      _errorMessage = "Failed to add activity.";
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    fetchActivities(clubDetailsId);
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<void> fetchActivities(String clubDetailsId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _activities =
          await _repository.fetchRecentUpcomingActivities(clubDetailsId);
    } catch (e) {
      _errorMessage = 'Failed to load activities: $e';
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
  }

  // New method to delete club details
  Future<bool> deleteActivities(String clubId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    bool isSuccess = false;

    final success = await _repository.deleteClubActivities(clubId);
    if (success) {
      isSuccess = true;
      _activities.removeWhere((club) => club.id == clubId);

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
