import 'dart:io';
import 'package:edu_clubs_app/data/models/admin/home/banner_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BannerRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String?> uploadBannerImage(File imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'banner_images/$fileName';

      await _supabase.storage
          .from('home_view_images')
          .upload(filePath, imageFile);
      return _supabase.storage.from('home_view_images').getPublicUrl(filePath);
    } catch (e) {
      return null;
    }
  }

  Future<bool> addBanner(BannerModel banner) async {
    try {
      await _supabase.from("banner_or_slider").insert(banner.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<BannerModel>> fetchBanners() async {
    final response = await _supabase.from("banner_or_slider").select();
    return response.map((data) => BannerModel.fromMap(data)).toList();
  }
}
