import 'dart:io';
import 'package:edu_clubs_app/view_model/categories/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminClubCategoryView extends StatefulWidget {
  const AdminClubCategoryView({super.key});

  @override
  _AdminClubCategoryViewState createState() => _AdminClubCategoryViewState();
}

class _AdminClubCategoryViewState extends State<AdminClubCategoryView> {
  final TextEditingController _clubNameController = TextEditingController();
  final TextEditingController _iconImgController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;
  bool _isLoading = false;

  File? _iconImage;
  final ImagePicker _picker = ImagePicker();

  // Function to pick the icon image from the gallery
  Future<void> _pickIconImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _iconImage = File(pickedFile.path);
        _iconImgController.text =
            pickedFile.path; // Set the file path to the controller
      });
    }
  }

  // Function to upload the image to Supabase and return the public URL
  Future<String?> _uploadIconImage(File imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'category_icons/$fileName';
      await _supabase.storage
          .from('club_category_images')
          .upload(filePath, imageFile);
      final String publicUrl =
          _supabase.storage.from('club_category_images').getPublicUrl(filePath);
      return publicUrl;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Image upload failed: $e')));
      return null;
    }
  }

  // Function to add a new club category
  Future<void> _addClubCategory() async {
    if (_iconImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an icon image')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final iconImageUrl = await _uploadIconImage(_iconImage!);

    if (iconImageUrl != null) {
      final newClubCategory = ClubCategoryModel(
        clubName: _clubNameController.text,
        createdAt: DateTime.now().toIso8601String(),
        iconImg: iconImageUrl,
        description: _descriptionController.text,
      );

      try {
        await _supabase.from("club_categories").insert(newClubCategory.toMap());
        _clearFields();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Club category added successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add club category: $e')),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Function to clear the form fields
  void _clearFields() {
    _clubNameController.clear();
    _iconImgController.clear();
    _descriptionController.clear();
    setState(() {
      _iconImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club Category Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _clubNameController,
                decoration: const InputDecoration(labelText: 'Club Name')),
            const SizedBox(height: 10),
            // Button to pick an icon image
            _iconImage == null
                ? ElevatedButton(
                    onPressed: _pickIconImage,
                    child: const Text('Pick Icon Image'),
                  )
                : Column(
                    children: [
                      Image.file(_iconImage!, height: 100),
                      const SizedBox(height: 10),
                      Text(_iconImage!.path), // Display the file path
                    ],
                  ),
            const SizedBox(height: 10),
            TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _addClubCategory,
                    child: const Text('Submit'),
                  ),
          ],
        ),
      ),
    );
  }
}
