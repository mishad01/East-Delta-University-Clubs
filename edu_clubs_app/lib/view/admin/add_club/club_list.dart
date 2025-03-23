import 'package:edu_clubs_app/view_model/categories/club_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClubListView extends StatelessWidget {
  const ClubListView({super.key});

  @override
  Widget build(BuildContext context) {
    final ClubCategoryController _controller =
        Get.find<ClubCategoryController>();

    return GetBuilder<ClubCategoryController>(
      builder: (_) {
        if (_controller.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_controller.errorMessage != null) {
          return Center(child: Text(_controller.errorMessage!));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _controller.categories.length,
          itemBuilder: (context, index) {
            final category = _controller.categories[index];
            return ListTile(
              title: Text(category.clubName),
              subtitle: Text(category.description),
              leading: category.iconImg.isNotEmpty
                  ? Image.network(category.iconImg)
                  : const Icon(Icons.group),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  bool isDeleted = await _controller.deleteCategory(
                    category.id!,
                  );
                  if (isDeleted) {
                    await _controller
                        .fetchCategories(); // Refresh the list after deletion
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
