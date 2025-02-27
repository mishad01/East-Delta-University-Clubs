import 'package:edu_clubs_app/data/models/club_details_model.dart';
import 'package:edu_clubs_app/data/repositories/admin/admin_club_details_repository.dart';
import 'package:get/get.dart';

class ClubDetailsController extends GetxController {
  final AdminClubDetailsRepository _repository =
      Get.find<AdminClubDetailsRepository>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  // Use the reactive RxList for state management
  var clubDetails = <Map<String, dynamic>>[].obs;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addClubDetails(
      String categoryId,
      String clubName,
      String whatWeDo,
      String whyJoinUsReason1,
      String whyJoinUsReason2,
      String recentOpenings,
      String upcomingActivities) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final newClubDetails = ClubDetailsModel(
      categoryId: categoryId,
      clubName: clubName,
      whatWeDo: whatWeDo,
      whyJoinUsReason1: whyJoinUsReason1,
      whyJoinUsReason2: whyJoinUsReason2,
      recentOpenings: recentOpenings,
      upcomingActivities: upcomingActivities,
    );

    final bool response = await _repository.addClubDetails(newClubDetails);

    if (response) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to add club details';
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> fetchClubCategories(String categoryId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    try {
      clubDetails.value = await _repository
          .fetchClubDetails(categoryId); // update the RxList directly
      isSuccess = true;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load data: $e';
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
