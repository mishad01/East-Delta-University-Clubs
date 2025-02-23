import 'package:edu_clubs_app/view_model/club_faq/club_faq_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClubFAQRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> addClubFAQ(ClubFAQModel clubFAQ) async {
    try {
      await _supabase.from('club_faq').insert(clubFAQ.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchFAQ(String clubDetailsId) async {
    try {
      final response = await _supabase
          .from('club_faq') // ✅ Corrected Table Name
          .select()
          .eq('club_details_id', clubDetailsId) // ✅ Corrected Filtering Column
          .order('created_at', ascending: false); // Sorting by latest FAQ

      return response
          .map((item) => {
                'club_details_id': item['club_details_id'],
                'question': item['question'],
                'answer': item['answer'],
              })
          .toList();
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
