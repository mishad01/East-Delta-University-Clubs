import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/club_profile/widget/club_events_slider.dart';
import 'package:edu_clubs_app/view/club_profile/widget/faq_section.dart';
import 'package:edu_clubs_app/view_model/club_details/club_details_controller.dart';

class ClubDetailsView extends StatelessWidget {
  const ClubDetailsView({
    super.key,
    required this.categoriesId,
  });
  final String categoriesId;

  @override
  Widget build(BuildContext context) {
    final ClubDetailsController controller = Get.put(ClubDetailsController());

    // Fetch data when the view is built
    controller.fetchClubCategories(categoriesId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<ClubDetailsController>(
            builder: (controller) {
              return controller.inProgress
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text: controller.clubDetails.isNotEmpty
                                ? controller.clubDetails.first['club_name']
                                : "Club Details",
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        ClubEventsSlider(
                          clubDetailsId: controller.clubDetails.first['id'],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const CustomText(
                                text: "What We Do",
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: controller.clubDetails.isNotEmpty
                                    ? controller.clubDetails.first['what_we_do']
                                    : "No information available",
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 2.h),
                              const CustomText(
                                text: "Why Join Us",
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              _buildImageTextOverlay(
                                AssetsPath.join_us_card,
                                controller.clubDetails.isNotEmpty
                                    ? controller
                                        .clubDetails.first['why_join_us']
                                    : "No information available",
                              ),
                              _buildRecentOpeningsSection(controller),
                              FAQSection(
                                clubDetailsId:
                                    controller.clubDetails.first['id'],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImageTextOverlay(String imagePath, String text) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(imagePath),
        Positioned(
          left: 40,
          right: 40,
          top: 120,
          child: CustomText(
            text: text,
            fontSize: 10,
            maxLine: 5,
            customStyle: const TextStyle(overflow: TextOverflow.ellipsis),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentOpeningsSection(ClubDetailsController controller) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.newsCard,
          height: 350,
          width: double.infinity,
        ),
        Positioned(
          top: 27,
          left: 45,
          child: const CustomText(
            text: "Recent\nOpenings",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Positioned(
          top: 100,
          left: 45,
          child: SizedBox(
            width: 200,
            child: CustomText(
              text: controller.clubDetails.isNotEmpty
                  ? controller.clubDetails.first['recent_openings'] ??
                      "No data available"
                  : "No data available",
              fontSize: 12,
            ),
          ),
        ),
        Positioned(
          bottom: 140,
          right: 45,
          child: const CustomText(
            text: "Upcoming\nActivities",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Positioned(
          bottom: 65,
          right: 45,
          child: SizedBox(
            width: 200,
            child: CustomText(
              text: controller.clubDetails.isNotEmpty
                  ? controller.clubDetails.first['upcoming_activities'] ??
                      "No data available"
                  : "No data available",
              fontSize: 12,
              maxLine: 3,
            ),
          ),
        ),
      ],
    );
  }
}
