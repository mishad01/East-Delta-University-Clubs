import 'package:edu_clubs_app/repository/admin/admin_home_view_content_add/members_opinion_repository.dart';
import 'package:get/get.dart';
import 'package:edu_clubs_app/view_model/admin/home/club_member_opinion_model.dart';

class MemberOpinionsController extends GetxController {
  final MemberOpinionRepository _repository =
      Get.find<MemberOpinionRepository>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Use the reactive RxList for state management
  var memberOpinionList = <ClubMemberOpinionModel>[].obs;

  Future<bool> addOpinion(
    String userId,
    String clubMemberName,
    String clubNameWithPosition,
    String clubOpinionDescription,
  ) async {
    _inProgress = true;
    update();

    final newOpinion = ClubMemberOpinionModel(
      userId: userId,
      clubMemberName: clubMemberName,
      clubNameWithPosition: clubNameWithPosition,
      clubOpinionDescription: clubOpinionDescription,
    );

    final bool response = await _repository.addMemberOpinion(newOpinion);

    if (response) {
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to add member opinion';
    }

    _inProgress = false;
    update();
    return response;
  }

  Future<void> fetchOpinions() async {
    try {
      _inProgress = true;
      update();

      final fetchedOpinions = await _repository.fetchMemberOpinions();
      memberOpinionList.assignAll(fetchedOpinions);
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Failed to load opinions: $error';
    }

    _inProgress = false;
    update();
  }
}
