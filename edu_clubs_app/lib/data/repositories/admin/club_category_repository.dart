import 'dart:io';
import 'package:edu_clubs_app/data/models/categories_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClubCategoryRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String?> uploadIconImage(File imageFile) async {
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
      print("Error uploading icon image: $e");
      return null;
    }
  }

  Future<bool> addClubCategory(ClubCategoryModel category) async {
    try {
      await _supabase.from("club_categories").insert(category.toMap());
      return true;
    } catch (e) {
      print("Error adding club category: $e");
      return false;
    }
  }

  Future<List<ClubCategoryModel>> fetchClubCategories() async {
    try {
      final response = await _supabase
          .from('club_categories')
          .select()
          .order('created_at', ascending: true);

      print("API Response: $response"); // Add this line for debugging

      return response.map((data) => ClubCategoryModel.fromMap(data)).toList();
    } catch (e) {
      print("Error fetching club categories: $e");
      return [];
    }
  }

  Future<bool> deleteClubCategory(String categoryId) async {
    try {
      final response =
          await _supabase.from('club_categories').delete().eq('id', categoryId);

      print("Response status: ${response.status}");
      print("Response error: ${response.error?.message}");

      if (response.status == 204) {
        print("Category with id $categoryId deleted successfully");
        return true;
      } else {
        print("Error deleting category: ${response.error?.message}");
        return false;
      }
    } catch (e) {
      print("Error deleting club category: $e");
      return false;
    }
  }
}
