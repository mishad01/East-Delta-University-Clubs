import 'package:edu_clubs_app/repository/admin/admin_club_details_repository.dart';
import 'package:edu_clubs_app/view_model/club_details/club_details_model.dart';
import 'package:get/get.dart';

class ClubDetailsController extends GetxController {
  final AdminClubDetailsRepository _repository = AdminClubDetailsRepository();
  var isLoading = false.obs;

  var errorMessage = ''.obs;
  var clubDetails = <Map<String, dynamic>>[].obs;

  Future<void> addClubDetails(
      String categoryId,
      String clubName,
      String whatWeDo,
      String whyJoinUs,
      String recentOpenings,
      String upcomingActivities) async {
    isLoading.value = true;

    final newClubDetails = ClubDetailsModel(
      categoryId: categoryId,
      clubName: clubName,
      whatWeDo: whatWeDo,
      whyJoinUs: whyJoinUs,
      recentOpenings: recentOpenings,
      upcomingActivities: upcomingActivities,
    );

    bool result = await _repository.addClubDetails(newClubDetails);

    if (result) {
      Get.snackbar("Success", "Club details added successfully!");
    } else {
      Get.snackbar("Error", "Failed to add club details.");
    }
    isLoading.value = false;
  }

  Future<void> fetchClubCategories(String categoryId) async {
    isLoading.value = true;
    try {
      final response = await _repository.fetchClubDetails(categoryId);
      clubDetails.value = response;
    } catch (e) {
      errorMessage.value = 'Failed to load data: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
