import 'package:edu_clubs_app/repository/admin/admin_club_faq_repository.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/club_faq/club_faq_model.dart';

class ClubFAQController extends GetxController {
  final ClubFAQRepository _repository = ClubFAQRepository();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var allFAQ = <Map<String, dynamic>>[].obs;

  Future<void> addClubFAQ(
      String question, String answer, String clubDetailsId) async {
    if (question.isEmpty || answer.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields");
      return;
    }

    isLoading.value = true;

    final newClubFAQ = ClubFAQModel(
      clubDetailsId: clubDetailsId,
      question: question,
      answer: answer,
    );

    final success = await _repository.addClubFAQ(newClubFAQ);
    if (success) {
      Get.snackbar("Success", "FAQ added successfully!");
      fetchFAQs(clubDetailsId); // ✅ Automatically refresh FAQs
    } else {
      Get.snackbar("Error", "Failed to add FAQ.");
    }

    isLoading.value = false;
  }

  Future<void> fetchFAQs(String clubDetailsId) async {
    // ✅ Renamed for clarity
    isLoading.value = true;
    try {
      final response = await _repository.fetchFAQ(clubDetailsId);
      allFAQ.value = response;
    } catch (e) {
      errorMessage.value = 'Failed to load data: $e';
      Get.snackbar("Error", "Failed to fetch FAQs.");
    } finally {
      isLoading.value = false;
    }
  }
}
