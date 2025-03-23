import 'package:edu_clubs_app/data/models/club_advisors_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClubAdvisorsRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> addClubAdvisor(ClubAdvisorsModel advisor) async {
    try {
      final response = await _supabase
          .from('club_advisors')
          .insert(advisor.toMap())
          .select();
      print("Insert Response: $response"); // Debugging response
      return true;
    } catch (e) {
      print("Add club advisor error: $e");
      return false;
    }
  }

  Future<bool> updateClubAdvisor(String id, ClubAdvisorsModel advisor) async {
    try {
      await _supabase
          .from('club_advisors')
          .update(advisor.toMap())
          .eq('id', id);
      return true;
    } catch (e) {
      print("Update club advisor error: \$e");
      return false;
    }
  }

  Future<List<ClubAdvisorsModel>> fetchClubAdvisors(
      String clubDetailsId) async {
    try {
      final response = await _supabase
          .from('club_advisors')
          .select()
          .eq('club_details_id', clubDetailsId)
          .order('created_at', ascending: true);

      return response.map((data) => ClubAdvisorsModel.fromMap(data)).toList();
    } catch (e) {
      print("Fetch club advisors error: \$e");
      return [];
    }
  }

  Future<bool> deleteClubAdvisor(String clubId) async {
    try {
      final response =
          await _supabase.from('club_advisors').delete().eq('id', clubId);

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
