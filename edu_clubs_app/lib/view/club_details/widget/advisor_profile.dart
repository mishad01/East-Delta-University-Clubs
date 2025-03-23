import 'package:edu_clubs_app/view/web/web_view.dart';
import 'package:edu_clubs_app/view_model/club_details/club_advisors/club_advisor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ClubAdvisorsWidget extends StatelessWidget {
  final String clubDetailsId;
  final ClubAdvisorsController _controller = Get.put(ClubAdvisorsController());

  ClubAdvisorsWidget({required this.clubDetailsId, super.key}) {
    _controller.fetchAdvisors(clubDetailsId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClubAdvisorsController>(
      builder: (controller) {
        if (controller.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage != null) {
          return Center(
            child: Text(
              controller.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (controller.advisors.isEmpty) {
          return const Center(
            child: Text("No advisors found."),
          );
        }

        return Column(
          children: [
            Center(
              child: Align(
                child: Column(
                  children: [
                    Text(
                      "Club Advisors",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign
                          .center, // This aligns the text to the center
                    ),
                    Text(
                      "Tap on profile for details",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign
                          .center, // This aligns the text to the center
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h), // Add some spacing
            SizedBox(
              height: 200, // Fixed height for the list
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Horizontal scrolling
                itemCount: controller.advisors.length,
                itemBuilder: (context, index) {
                  final advisor = controller.advisors[index];
                  return InkWell(
                    onTap: () {
                      Get.to(() => WebView(link: advisor.advisorInfoLink));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Add spacing between profiles
                      child: ProfileWidget(
                        name: advisor.advisorName,
                        role: advisor.advisorType,
                        email: advisor.advisorEmail,
                        imagePath: advisor.advisorImageLink,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// Example ProfileWidget (replace with your actual implementation)
class ProfileWidget extends StatelessWidget {
  final String name;
  final String role;
  final String email;
  final String imagePath;

  const ProfileWidget({
    required this.name,
    required this.role,
    required this.email,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imagePath),
          radius: 50,
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(role),
        Text(email),
      ],
    );
  }
}
