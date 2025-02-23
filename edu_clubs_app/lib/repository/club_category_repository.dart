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
      return null;
    }
  }

  Future<bool> addClubCategory(ClubCategoryModel category) async {
    try {
      await _supabase.from("club_categories").insert(category.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
