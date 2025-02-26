import 'package:edu_clubs_app/repository/admin/admin_club_details_repository.dart';
import 'package:edu_clubs_app/repository/admin/admin_home_view_content_add/members_opinion_repository.dart';
import 'package:edu_clubs_app/view_model/admin/home/banner_controller.dart';
import 'package:edu_clubs_app/view_model/admin/home/member_opinion_controller.dart';
import 'package:edu_clubs_app/view_model/categories/club_category_controller.dart';
import 'package:edu_clubs_app/view_model/club_details/club_details_controller.dart';
import 'package:edu_clubs_app/view_model/club_events/club_event_controller.dart';
import 'package:edu_clubs_app/view_model/club_faq/club_faq_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(ClubCategoriesController());
    Get.put(ClubDetailsController());
    Get.put(ClubEventController());
    Get.put(ClubFAQController());
    Get.put(
        AdminClubDetailsRepository()); // Ensure AdminClubDetailsRepository is properly registered
    Get.put(MemberOpinionsController());
    Get.put(BannerController());
  }
}
