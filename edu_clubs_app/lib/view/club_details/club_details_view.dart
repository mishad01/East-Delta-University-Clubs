import 'package:edu_clubs_app/view/club_details/widget/club_events_slider.dart';
import 'package:edu_clubs_app/view/club_details/widget/faq_section.dart';
import 'package:flutter/material.dart';
import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/export.dart';

import 'package:edu_clubs_app/view_model/club_details/club_details_controller.dart';
import 'package:get/get.dart';

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
              return Center(child: CustomText(text: "Error loading data"));
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Displaying club events in a slider
                    ClubEventsSlider(
                      clubDetailsId: controller.clubDetails.first['id'],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Section for club activities
                          _buildSectionTitle("What We Do"),
                          _buildSectionContent(
                              controller.clubDetails.first['what_we_do']),
                          SizedBox(height: 2.h),
                          // Section highlighting club benefits
                          _buildSectionTitle("Why Join Us"),
                          _buildImageTextOverlay(
                            AssetsPath.join_us_card,
                            controller.clubDetails.first['why_join_us_reason1'],
                            controller.clubDetails.first['why_join_us_reason2'],
                          ),
                          // Section for recent openings & upcoming activities
                          _buildRecentOpeningsSection(controller),
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
          return CustomText(
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
    return CustomText(
      text: title,
      customStyle: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Helper method to build section content
  Widget _buildSectionContent(String content) {
    return CustomText(
      text: content.isNotEmpty ? content : "No information available",
      textAlign: TextAlign.start,
      customStyle: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 14.sp,
      ),
      maxLine: 3,
    );
  }

  // Builds an image overlay section with text
  Widget _buildImageTextOverlay(String imagePath, String text1, String text2) {
    return Stack(
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
    );
  }

  // Section displaying recent openings and upcoming activities
  Widget _buildRecentOpeningsSection(ClubDetailsController controller) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.newsCard,
          height: 350,
          width: double.infinity,
        ),
        Positioned(
          top: 4.h,
          left: 10.w,
          child: CustomText(
            text: "Recent\nOpenings",
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Positioned(
          top: 11.h,
          left: 10.w,
          child: SizedBox(
            height: 10.h,
            width: 42.w,
            child: _buildSectionContent(
              controller.clubDetails.first['recent_openings'] ??
                  "No data available",
            ),
          ),
        ),
        Positioned(
          bottom: 18.h,
          right: 4.5.w,
          child: CustomText(
            text: "Upcoming\nActivities",
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Positioned(
          bottom: 8.h,
          right: 10.w,
          child: SizedBox(
            height: 10.h,
            width: 42.w,
            child: _buildSectionContent(
              controller.clubDetails.first['upcoming_activities'] ??
                  "No data available",
            ),
          ),
        ),
      ],
    );
  }
}
