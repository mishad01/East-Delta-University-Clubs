import 'dart:io';
import 'package:edu_clubs_app/view_model/categories/categories_model.dart';
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

  Future<List<Map<String, dynamic>>> fetchClubCategories() async {
    try {
      final response = await _supabase
          .from('club_categories')
          .select()
          .order('created_at', ascending: true);

      List<Map<String, dynamic>> _data = [];
      for (var item in response) {
        final dataModel = ClubCategoryModel.fromMap(item);
        _data.add({
          'id': dataModel.id,
          'club_name': dataModel.clubName,
          'created_at': dataModel.createdAt,
          'icon_img': dataModel.iconImg,
          'description': dataModel.description,
        });
      }
      return _data;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
