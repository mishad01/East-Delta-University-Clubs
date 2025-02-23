import 'package:edu_clubs_app/app.dart';
import 'package:edu_clubs_app/view_model/categories/club_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminClubCategoryView extends StatelessWidget {
  AdminClubCategoryView({super.key});

  final ClubCategoriesController controller =
      Get.put(ClubCategoriesController());
  final TextEditingController clubNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Club Category Management')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Add Option
            buildAddCard(),
            // Fetch Already stored data
            SizedBox(height: 20),
            Divider(),
            Obx(
              () {
                if (controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                }
                if (controller.clubCategories.isEmpty) {
                  return const Center(child: Text("No club categories found."));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.clubCategories.length,
                  itemBuilder: (context, index) {
                    var category = controller.clubCategories[index];
                    return ListTile(
                      title: Text(category['club_name']),
                      subtitle: Text(category['description']),
                      leading: category['icon_img'] != null
                          ? Image.network(category['icon_img'])
                          : null,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: clubNameController,
              decoration: InputDecoration(
                labelText: 'Club Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.group),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => controller.iconImage.value == null
                ? ElevatedButton(
                    onPressed: controller.pickIconImage,
                    child: const Text('Pick Icon Image'),
                  )
                : Column(
                    children: [
                      Image.file(controller.iconImage.value!),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: controller.pickIconImage,
                        child: const Text('Change Image'),
                      ),
                    ],
                  )),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          controller.addClubCategory(
                            clubNameController.text,
                            descriptionController.text,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Submit',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
