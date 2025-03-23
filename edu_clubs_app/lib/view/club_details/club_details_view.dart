import 'package:edu_clubs_app/resources/app_colors.dart';
import 'package:edu_clubs_app/view/club_details/widget/ActivityInfoSection2.dart';
import 'package:edu_clubs_app/view/club_details/widget/activity_info_sction1.dart';
import 'package:edu_clubs_app/view/club_details/widget/advisor_profile.dart';
import 'package:edu_clubs_app/view/club_details/widget/club_events_slider.dart';
import 'package:edu_clubs_app/view/club_details/widget/faq_section.dart';
import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/web/web_view.dart';
import 'package:edu_clubs_app/view_model/club_details/club_details_controller.dart';
import 'package:edu_clubs_app/view_model/club_details/recent_and_upcoming_activites/activities_controller.dart';

class ClubDetailsView extends StatelessWidget {
  const ClubDetailsView({
    super.key,
    required this.categoriesId,
    required this.clubName,
  });
  final String categoriesId;
  final String clubName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          clubName,
          style: GoogleFonts.roboto(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: GetBuilder<ClubDetailsController>(
          initState: (state) {
            Get.find<ClubDetailsController>().fetchClubDetails(categoriesId);
          },
          builder: (controller) {
            if (controller.clubDetails.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClubEventsSlider(
                    clubDetailsId: categoriesId,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle("What We Do"),
                        _buildSectionContent(
                            controller.clubDetails.first.whatWeDo),
                        SizedBox(height: 2.h),
                        _buildSectionTitle("Why Join Us"),
                        SizedBox(height: 1.h),
                        _buildImageTextOverlay(
                          AssetsPath.join_us_card,
                          controller.clubDetails.first.whyJoinUsReason1,
                          controller.clubDetails.first.whyJoinUsReason2,
                        ),
                        SizedBox(height: 2.h),
                        ClubAdvisorsWidget(clubDetailsId: categoriesId),
                        SizedBox(height: 1.h),
                        _buildRecentOpeningsSection(controller),
                        SizedBox(height: 1.h),
                        _buildSectionTitle("FAQ"),
                        FAQSection(
                          clubDetailsId: categoriesId,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return CustomText(
      text: title,
      customStyle: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return SizedBox(
      child: CustomText(
        text: content.isNotEmpty ? content : "No information available",
        textAlign: TextAlign.center,
        customStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 12,
        ),
        maxLine: 3,
      ),
    );
  }

  Widget _buildImageTextOverlay(String imagePath, String text1, String text2) {
    return Container(
      width: double.maxFinite,
      height: 210,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: AppColors.themeColor1),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            CustomText(
                text: "WE Are Innovative",
                customStyle: GoogleFonts.sourceSerif4(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                )),
            SizedBox(height: 1.h),
            SizedBox(
              width: 287,
              child: CustomText(
                text: text1,
                customStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 10,
                ),
                textAlign: TextAlign.justify,
                maxLine: 5,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  AssetsPath.eduLogo,
                  height: 70,
                  width: 100,
                ),
                Flexible(
                  child: SizedBox(
                    width: 220,
                    child: CustomText(
                      text: text1,
                      customStyle: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.justify,
                      maxLine: 4,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Refactored _buildRecentOpeningsSection
  Widget _buildRecentOpeningsSection(ClubDetailsController clubController) {
    // Use Get.put to initialize the controller if it's not already initialized.
    final activitiesController = Get.put(ActivitiesController());

    // Ensure activitiesController is fetched before the UI builds.
    activitiesController.fetchActivities(categoriesId!);

    return GetBuilder<ActivitiesController>(
      builder: (controller) {
        if (controller.activities.isEmpty) {
          // Optionally handle empty state (e.g., loading or no data)
          return Center(child: CircularProgressIndicator());
        }

        final activity = controller.activities.first;

        return Container(
          width: double.infinity,
          height: 234,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: AppColors.themeColor2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: SizedBox(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ActivityInfoSection1(
                      title: "Recent\nOpenings",
                      description: activity.recentOpeningDetails,
                      link: activity.recentOpeningLink,
                    ),
                  ),
                ),
              ),
              // Vertical Divider
              const SizedBox(
                height: double.infinity,
                child: VerticalDivider(
                  thickness: 2,
                  width: 20, // Adjust spacing
                  color: Colors.white,
                ),
              ),
              Flexible(
                child: SizedBox(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ActivityInfoSection2(
                      title: "Upcoming\nActivities",
                      description: activity.upcomingActivitiesDetails,
                      link: activity.upcomingActivitiesLink,
                      isUpcoming: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
