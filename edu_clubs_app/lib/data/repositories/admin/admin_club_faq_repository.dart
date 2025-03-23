import 'package:edu_clubs_app/data/models/club_faq_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClubFAQRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> addClubFAQ(ClubFAQModel clubFAQ) async {
    try {
      final response = await _supabase.from('club_faq').insert(clubFAQ.toMap());
      print("Supabase Response: $response");
      return true;
    } catch (e) {
      print("Error adding club FAQ: $e");
      return false;
    }
  }

  Future<List<ClubFAQModel>> fetchFAQ(String clubDetailsId) async {
    try {
      final response = await _supabase
          .from('club_faq')
          .select()
          .eq('club_details_id', clubDetailsId)
          .order('created_at', ascending: true);

      return response.map((data) => ClubFAQModel.fromMap(data)).toList();
    } catch (e) {
      print("Fetch club FAQ error: $e");
      return [];
    }
  }

  Future<bool> deleteFAQ(String clubId) async {
    try {
      final response =
          await _supabase.from('club_faq').delete().eq('id', clubId);

      if (response.error != null) {
        print('Error deleting club details: ${response.error!.message}');
        return false;
      }

      print('Successfully deleted club details');
      return true;
    } catch (e) {
      print('Error deleting club details: $e');
      return false;
    }
  }
}
