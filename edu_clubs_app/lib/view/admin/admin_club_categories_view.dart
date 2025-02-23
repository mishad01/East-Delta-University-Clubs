import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:edu_clubs_app/view_model/categories/categories_model.dart';

class AdminClubCategoryView extends StatefulWidget {
  const AdminClubCategoryView({super.key});

  @override
  _AdminClubCategoryViewState createState() => _AdminClubCategoryViewState();
}

class _AdminClubCategoryViewState extends State<AdminClubCategoryView> {
  final TextEditingController _clubNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;
  bool _isLoading = false;

  File? _iconImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickIconImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _iconImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadIconImage(File imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'category_icons/$fileName';
      await _supabase.storage
          .from('club_category_images')
          .upload(filePath, imageFile);
      return _supabase.storage
          .from('club_category_images')
          .getPublicUrl(filePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image upload failed: $e')),
      );
      return null;
    }
  }

  Future<void> _addClubCategory() async {
    if (_clubNameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _iconImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill in all fields and select an image')),
      );
      return;
    }

    setState(() => _isLoading = true);

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

    setState(() => _isLoading = false);
  }

  void _clearFields() {
    _clubNameController.clear();
    _descriptionController.clear();
    setState(() => _iconImage = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club Category Management')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _clubNameController,
                      decoration: InputDecoration(
                        labelText: 'Club Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.group),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _iconImage == null
                        ? ElevatedButton(
                            onPressed: _pickIconImage,
                            child: const Text('Pick Icon Image'),
                          )
                        : Column(
                            children: [
                              Image.file(_iconImage!, height: 100),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: _pickIconImage,
                                child: const Text('Change Image'),
                              ),
                            ],
                          ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.description),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _addClubCategory,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
