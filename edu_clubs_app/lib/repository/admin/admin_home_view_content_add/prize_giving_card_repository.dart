import 'dart:io';
import 'package:edu_clubs_app/view_model/admin/home/prize_giving_ceremony_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PrizeGivingCeremonyRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String?> uploadPrizeGivingImage(File imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'prize_giving_images/$fileName';

      await _supabase.storage
          .from('home_view_images')
          .upload(filePath, imageFile);
      return _supabase.storage.from('home_view_images').getPublicUrl(filePath);
    } catch (e) {
      return null;
    }
  }

  Future<bool> addPrizeGivingCeremony(PrizeGivingCeremonyModel ceremony) async {
    try {
      await _supabase.from("prize_giving_ceremony").insert(ceremony.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<PrizeGivingCeremonyModel>> fetchCeremonies() async {
    final response = await _supabase.from("prize_giving_ceremony").select();
    return response
        .map((data) => PrizeGivingCeremonyModel.fromMap(data))
        .toList();
  }
}
