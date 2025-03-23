import 'package:edu_clubs_app/view/admin/club_advisors_info_for_club_details/club_advisors_for_club_details.dart';
import 'package:edu_clubs_app/view_model/categories/club_category_controller.dart'; // Assuming you have a controller for this
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminClubAdvisorsGridView extends StatelessWidget {
  AdminClubAdvisorsGridView({super.key});

  final ClubCategoryController controller =
      Get.put(ClubCategoryController()); // Get controller for state management

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club Advisors Management')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GetBuilder<ClubCategoryController>(
          // Using GetBuilder to manage state
          builder: (controller) {
            // Error handling
            if (controller.errorMessage != null) {
              return Center(child: Text(controller.errorMessage!));
            }

            // Display loading indicator while fetching data
            if (controller.inProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            // Show message if no data is available
            if (controller.categories.isEmpty) {
              return const Center(child: Text("No club advisors found."));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                var category = controller.categories[index];
                var advisorName = category.clubName;
                var image = category.iconImg;
                var clubCategoryId = category.id;

                return GestureDetector(
                  onTap: () {
                    // Navigate to the club advisors details view
                    Get.to(() => ClubAdvisorsForClubDetails(
                        clubCategoryId:
                            clubCategoryId!)); // Navigate to the correct view
                  },
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.lightBlue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          category.iconImg != null
                              ? Image.network(
                                  category.iconImg,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.group,
                                  size: 50, color: Colors.white),
                          const SizedBox(height: 8),
                          Text(
                            category.clubName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
