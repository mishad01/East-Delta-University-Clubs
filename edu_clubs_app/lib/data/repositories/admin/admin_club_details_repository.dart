import 'package:edu_clubs_app/data/models/club_details_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminClubDetailsRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> addClubDetails(ClubDetailsModel clubDetails) async {
    try {
      await _supabase.from("club_details").insert(clubDetails.toMap());
      return true;
    } catch (error) {
      print('Error adding club details: $error');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchClubDetails(String categoryId) async {
    try {
      final response = await _supabase
          .from('club_details')
          .select()
          .eq('category_id', categoryId) // Filter by category_id
          .order('category_id', ascending: true);

      List<Map<String, dynamic>> _data = response.map((item) {
        final dataModel = ClubDetailsModel.fromMap(item);
        return {
          'id': dataModel.id,
          'category_id': dataModel.categoryId,
          'club_name': dataModel.clubName,
          'what_we_do': dataModel.whatWeDo,
          'why_join_us_reason1': dataModel.whyJoinUsReason1,
          'why_join_us_reason2': dataModel.whyJoinUsReason2,
          'recent_openings': dataModel.recentOpenings,
          'upcoming_activities': dataModel.upcomingActivities,
        };
      }).toList();

      return _data;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
