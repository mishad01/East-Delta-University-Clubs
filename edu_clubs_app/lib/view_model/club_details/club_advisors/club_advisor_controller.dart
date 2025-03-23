import 'package:edu_clubs_app/data/models/club_advisors_model.dart';
import 'package:edu_clubs_app/data/repositories/admin/admin_home_view_content_add/club_advisors_repository.dart';
import 'package:get/get.dart';

class ClubAdvisorsController extends GetxController {
  final ClubAdvisorsRepository _repository = ClubAdvisorsRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ClubAdvisorsModel> _advisors = [];
  List<ClubAdvisorsModel> get advisors => _advisors;

  Future<bool> addAdvisor(
    String clubDetailsId,
    String advisorName,
    String advisorType,
    String advisorEmail,
    String advisorInfoLink,
    String advisorImageLink,
  ) async {
    if (clubDetailsId.isEmpty ||
        advisorName.isEmpty ||
        advisorType.isEmpty ||
        advisorEmail.isEmpty ||
        advisorInfoLink.isEmpty ||
        advisorImageLink.isEmpty) {
      Get.snackbar("Error", "Please fill in all required fields.");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final newAdvisor = ClubAdvisorsModel(
      clubDetailsId: clubDetailsId,
      advisorName: advisorName,
      advisorType: advisorType,
      advisorEmail: advisorEmail,
      advisorInfoLink: advisorInfoLink,
      advisorImageLink: advisorImageLink,
    );

    final success = await _repository.addClubAdvisor(newAdvisor);
    if (success) {
      isSuccess = true;
      Future.delayed(Duration.zero, () {
        Get.snackbar("Success", "Advisor added successfully!");
      });
    } else {
      _errorMessage = "Failed to add advisor.";
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    fetchAdvisors(clubDetailsId);
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<void> fetchAdvisors(String clubDetailsId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _advisors = await _repository.fetchClubAdvisors(clubDetailsId);
    } catch (e) {
      _errorMessage = 'Failed to load advisors: $e';
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
  }

  Future<bool> deleteClubAdvisor(String clubId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    bool isSuccess = false;

    final success = await _repository.deleteClubAdvisor(clubId);
    if (success) {
      isSuccess = true;
      _advisors.removeWhere((club) => club.id == clubId);

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
