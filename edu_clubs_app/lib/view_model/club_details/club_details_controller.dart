import 'package:edu_clubs_app/data/models/club_details_model.dart';
import 'package:edu_clubs_app/data/repositories/admin/admin_club_details_repository.dart';
import 'package:get/get.dart';

class ClubDetailsController extends GetxController {
  final AdminClubDetailsRepository _repository = AdminClubDetailsRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ClubDetailsModel> _clubDetails = [];
  List<ClubDetailsModel> get clubDetails => _clubDetails;

  Future<bool> addClubDetails(
    String categoryId,
    String clubName,
    String whatWeDo,
    String whyJoinUsReason1,
    String whyJoinUsReason2,
  ) async {
    if (categoryId.isEmpty ||
        clubName.isEmpty ||
        whatWeDo.isEmpty ||
        whyJoinUsReason1.isEmpty ||
        whyJoinUsReason2.isEmpty) {
      Get.snackbar("Error", "Please fill in all required fields.");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final newClubDetails = ClubDetailsModel(
      categoryId: categoryId,
      clubName: clubName,
      whatWeDo: whatWeDo,
      whyJoinUsReason1: whyJoinUsReason1,
      whyJoinUsReason2: whyJoinUsReason2,
    );

    print('Test: \$newClubDetails');

    final success = await _repository.addClubDetails(newClubDetails);
    if (success) {
      isSuccess = true;
      Future.delayed(Duration.zero, () {
        Get.snackbar("Success", "Club details added successfully!");
      });
    } else {
      _errorMessage = "Failed to add club details.";
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    fetchClubDetails(categoryId);
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<void> fetchClubDetails(String categoryId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _clubDetails = await _repository.fetchClubDetails(categoryId);
      print("Fetched club details: $_clubDetails");
    } catch (e) {
      _errorMessage = 'Failed to load club details: $e';
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
  }

  // New method to delete club details
  Future<bool> deleteClubDetails(String clubId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    bool isSuccess = false;

    final success = await _repository.deleteClubDetails(clubId);
    if (success) {
      isSuccess = true;
      _clubDetails.removeWhere((club) => club.id == clubId);

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
