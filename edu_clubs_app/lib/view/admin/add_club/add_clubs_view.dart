import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:edu_clubs_app/view_model/categories/club_category_controller.dart';

class AddClub extends StatefulWidget {
  const AddClub({super.key});

  @override
  _AddClubState createState() => _AddClubState();
}

class _AddClubState extends State<AddClub> {
  final TextEditingController clubNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ClubCategoryController _controller = Get.put(ClubCategoryController());
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  // Constants for styling
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 15.0;

  @override
  void initState() {
    super.initState();
    _controller
        .fetchCategories(); // Ensure categories are fetched on screen load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club Category Management')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildAddCard(),
            const SizedBox(height: 20),
            const Divider(),
            buildCategoryList(),
          ],
        ),
      ),
    );
  }

  Widget buildAddCard() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            buildTextField(
                controller: clubNameController,
                labelText: 'Club Name',
                icon: Icons.group),
            const SizedBox(height: defaultPadding),
            buildImagePicker(),
            const SizedBox(height: defaultPadding),
            buildTextField(
                controller: descriptionController,
                labelText: 'Description',
                icon: Icons.description),
            const SizedBox(height: 20),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius)),
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget buildImagePicker() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final pickedFile =
                await _imagePicker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              setState(() {
                _selectedImage = File(pickedFile.path);
              });
            }
          },
          child: const Text('Pick Icon Image'),
        ),
        if (_selectedImage != null) ...[
          const SizedBox(height: defaultPadding),
          Image.file(
            _selectedImage!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ],
    );
  }

  Widget buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          final clubName = clubNameController.text;
          final description = descriptionController.text;

          if (_selectedImage == null) {
            Get.snackbar("Error", "Please pick an icon image.");
            return;
          }

          final success = await _controller.addCategory(
              clubName, _selectedImage!, description);
          if (success) {
            clubNameController.clear();
            descriptionController.clear();
            setState(() {
              _selectedImage = null;
            });
            _controller.fetchCategories(); // Refresh categories after adding
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius)),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildCategoryList() {
    return GetBuilder<ClubCategoryController>(builder: (_) {
      if (_controller.inProgress) {
        return const Center(child: CircularProgressIndicator());
      }
      if (_controller.errorMessage != null) {
        return Center(child: Text(_controller.errorMessage!));
      }
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5, // Ensure full display
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
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
                  await _controller.deleteCategory(category.id!);
                  _controller.fetchCategories(); // Refresh list after delete
                },
              ),
            );
          },
        ),
      );
    });
  }
}
