import 'package:edu_clubs_app/view/admin/all_club_details/admin_club_details_view.dart';
import 'package:edu_clubs_app/view_model/categories/club_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminClubDetailsGridView extends StatelessWidget {
  AdminClubDetailsGridView({super.key});

  final ClubCategoriesController controller =
      Get.put(ClubCategoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club Category Management')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GetBuilder<ClubCategoriesController>(
          builder: (controller) {
            if (controller.errorMessage != null) {
              return Center(child: Text(controller.errorMessage!));
            }
            if (controller.clubCategories.isEmpty) {
              return const Center(child: Text("No club categories found."));
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: controller.clubCategories.length,
              itemBuilder: (context, index) {
                var category = controller.clubCategories[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(
                        () => AdminClubDetailsView(categoryId: category['id']));
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
                          category['icon_img'] != null
                              ? Image.network(
                                  category['icon_img'],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.group,
                                  size: 50, color: Colors.white),
                          const SizedBox(height: 8),
                          Text(
                            category['club_name'],
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
