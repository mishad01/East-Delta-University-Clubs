import 'package:edu_clubs_app/view_model/categories/categories_model.dart';
import 'package:flutter/material.dart';
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

  Future<void> _addClubCategory() async {
    setState(() {
      _isLoading = true;
    });

    final newClubCategory = ClubCategoryModel(
      clubName: _clubNameController.text,
      createdAt: DateTime.now().toIso8601String(),
      iconImg: _iconImgController.text,
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

    setState(() {
      _isLoading = false;
    });
  }

  void _clearFields() {
    _clubNameController.clear();
    _iconImgController.clear();
    _descriptionController.clear();
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
            TextField(
                controller: _iconImgController,
                decoration: const InputDecoration(labelText: 'Icon Image URL')),
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
