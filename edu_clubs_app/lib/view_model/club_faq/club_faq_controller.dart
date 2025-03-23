import 'package:edu_clubs_app/data/models/club_faq_model.dart';
import 'package:edu_clubs_app/data/repositories/admin/admin_club_faq_repository.dart';
import 'package:get/get.dart';

class ClubFAQController extends GetxController {
  final ClubFAQRepository _repository = ClubFAQRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ClubFAQModel> _clubFAQs = [];
  List<ClubFAQModel> get clubFAQs => _clubFAQs;

  // Add a new FAQ to the club
  Future<bool> addClubFAQ(
    String clubDetailsId,
    String question,
    String answer,
  ) async {
    if (clubDetailsId.isEmpty || question.isEmpty || answer.isEmpty) {
      Get.snackbar("Error", "Please fill in all required fields.");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final newClubFAQ = ClubFAQModel(
      clubDetailsId: clubDetailsId,
      question: question,
      answer: answer,
    );

    final success = await _repository.addClubFAQ(newClubFAQ);
    if (success) {
      isSuccess = true;
      Future.delayed(Duration.zero, () {
        Get.snackbar("Success", "Club FAQ added successfully!");
      });
    } else {
      _errorMessage = "Failed to add club FAQ.";
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  // Fetch all FAQs for a specific club
  Future<void> fetchClubFAQs(String clubDetailsId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _clubFAQs = await _repository.fetchFAQ(clubDetailsId);
      print("Fetched club FAQs: $_clubFAQs");
    } catch (e) {
      _errorMessage = 'Failed to load club FAQs: $e';
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
  }

  Future<bool> deleteClubDetails(String clubId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    bool isSuccess = false;

    final success = await _repository.deleteFAQ(clubId);
    if (success) {
      isSuccess = true;
      _clubFAQs.removeWhere((club) => club.id == clubId);

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
