import 'package:edu_clubs_app/resources/app_colors.dart';
import 'package:edu_clubs_app/view/club_details/widget/club_events_slider.dart';
import 'package:edu_clubs_app/view/club_details/widget/faq_section.dart';
import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/club_details/club_details_controller.dart';

class ClubDetailsView extends StatelessWidget {
  const ClubDetailsView({
    super.key,
    required this.categoriesId,
  });
  final String categoriesId;

  @override
  Widget build(BuildContext context) {
    // Initializing GetX Controller to manage club details
    final ClubDetailsController controller = Get.put(ClubDetailsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: app_bar_title(controller), // Setting dynamic app bar title
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: controller.fetchClubCategories(categoriesId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: CustomTextForPdf(text: "Error loading data"));
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Displaying club events in a slider
                    ClubEventsSlider(
                      clubDetailsId: controller.clubDetails.first['id'],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section for club activities
                          _buildSectionTitle("What We Do"),
                          _buildSectionContent(
                              controller.clubDetails.first['what_we_do']),
                          SizedBox(height: 2.h),
                          // Section highlighting club benefits
                          _buildSectionTitle("Why Join Us"),
                          SizedBox(height: 1.h),
                          _buildImageTextOverlay(
                            AssetsPath.join_us_card,
                            controller.clubDetails.first['why_join_us_reason1'],
                            controller.clubDetails.first['why_join_us_reason2'],
                          ),
                          SizedBox(height: 2.h),
                          clubAdvisors(),
                          SizedBox(height: 2.h),
                          // Section for recent openings & upcoming activities
                          _buildRecentOpeningsSection(controller),
                          SizedBox(height: 1.h),
                          _buildSectionTitle("FAQ"),
                          FAQSection(
                            clubDetailsId: controller.clubDetails.first['id'],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Column clubAdvisors() {
    return Column(
      children: [
        Center(child: _buildSectionTitle("Club Advisors")),
        Container(
          height: 200,
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First Profile
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(AssetsPath.avatar),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "John Doe",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Advisor"),
                    SizedBox(
                      width: 120, // Limit width to prevent overflow
                      child: Text(
                        "221000412@eastdelta.edu.bd",
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 1.w), // Space between profiles
              // Second Profile
              const Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(AssetsPath.avatar),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Jane Smith",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Co-Advisor"),
                    SizedBox(
                      width: 120, // Limit width to prevent overflow
                      child: Text(
                        "221000412@eastdelta.edu.bd",
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Fetches and sets the app bar title dynamically
  FutureBuilder<bool> app_bar_title(ClubDetailsController controller) {
    return FutureBuilder(
      future: controller.fetchClubCategories(categoriesId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        } else if (snapshot.hasError) {
          return const Text("Error");
        } else {
          return CustomTextForPdf(
            text: controller.clubDetails.isNotEmpty
                ? controller.clubDetails.first['club_name']
                : "Club Details",
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          );
        }
      },
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return CustomTextForPdf(
      text: title,
      customStyle: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Helper method to build section content
  Widget _buildSectionContent(String content) {
    return SizedBox(
      child: CustomTextForPdf(
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

  // Builds an image overlay section with text
  Widget _buildImageTextOverlay(String imagePath, String text1, String text2) {
    /*return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(imagePath),
        Positioned(
          left: 5.w,
          right: 6.w,
          top: 13.h,
          child: Column(
            children: [
              CustomText(
                text: text1,
                customStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 13.sp,
                ),
                textAlign: TextAlign.justify,
                maxLine: 5,
              ),
            ],
          ),
        ),
        Positioned(
          left: 23.w,
          right: 5.w,
          bottom: 3.h,
          child: Column(
            children: [
              CustomText(
                text: text2,
                customStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 13.sp,
                ),
                textAlign: TextAlign.justify,
                maxLine: 4,
              ),
            ],
          ),
        ),
      ],
    );*/
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
            CustomTextForPdf(
                text: "WE Are Innovative",
                customStyle: GoogleFonts.sourceSerif4(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                )),
            SizedBox(height: 1.h),
            SizedBox(
              width: 287,
              child: CustomTextForPdf(
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
                    child: CustomTextForPdf(
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

  // Section displaying recent openings and upcoming activities
  Widget _buildRecentOpeningsSection(ClubDetailsController controller) {
    return Container(
      width: double.maxFinite,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomTextForPdf(
                      text: "Recent\nOpenings",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                    _buildSectionContent(
                      controller.clubDetails.first['recent_openings'] ??
                          "No data available",
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 25),
                          backgroundColor: AppColors.themeColor3),
                      child: const Text(
                        "Click Here",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Vertical Divider
          const SizedBox(
            height: double.maxFinite,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 25),
                          backgroundColor: AppColors.themeColor3),
                      child: const Text(
                        "Click Here",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Flexible(
                      child: _buildSectionContent(
                        controller.clubDetails.first['upcoming_activities'] ??
                            "No data available",
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const CustomTextForPdf(
                      text: "Upcoming\nActivities",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
