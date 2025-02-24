import 'package:edu_clubs_app/repository/admin/admin_club_faq_repository.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/club_faq/club_faq_model.dart';

class ClubFAQController extends GetxController {
  final ClubFAQRepository _repository = ClubFAQRepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Map<String, dynamic>> _allFAQ = [];
  List<Map<String, dynamic>> get allFAQ => _allFAQ;

  Future<bool> addClubFAQ(
      String question, String answer, String clubDetailsId) async {
    bool isSuccess = false;
    if (question.isEmpty || answer.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields");
      return isSuccess;
    }

    _isLoading = true;
    update();

    final newClubFAQ = ClubFAQModel(
      clubDetailsId: clubDetailsId,
      question: question,
      answer: answer,
    );

    final success = await _repository.addClubFAQ(newClubFAQ);
    if (success) {
      Get.snackbar("Success", "FAQ added successfully!");
      await fetchFAQs(clubDetailsId); // ✅ Automatically refresh FAQs
      isSuccess = true;
    } else {
      _errorMessage = "Failed to add FAQ.";
      Get.snackbar("Error", _errorMessage!);
    }

    _isLoading = false;
    update();
    return isSuccess;
  }

  Future<void> fetchFAQs(String clubDetailsId) async {
    _isLoading = true;
    update();
    try {
      final response = await _repository.fetchFAQ(clubDetailsId);
      _allFAQ = response;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load data: $e';
      Get.snackbar("Error", _errorMessage!);
    } finally {
      _isLoading = false;
      update();
    }
  }
}
