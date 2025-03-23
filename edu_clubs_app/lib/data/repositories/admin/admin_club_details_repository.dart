import 'package:edu_clubs_app/data/models/club_details_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminClubDetailsRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> addClubDetails(ClubDetailsModel clubDetails) async {
    try {
      final response =
          await _supabase.from("club_details").insert(clubDetails.toMap());
      print("Supabase Response: $response");
      return true;
    } catch (e) {
      print('Error adding club details: $e');
      return false;
    }
  }

  Future<List<ClubDetailsModel>> fetchClubDetails(String categoryId) async {
    try {
      final response = await _supabase
          .from('club_details')
          .select()
          .eq('category_id', categoryId);

      return response
          .map<ClubDetailsModel>((data) => ClubDetailsModel.fromMap(data))
          .toList();
    } catch (e) {
      print("Fetch club details error: $e");
      return [];
    }
  }

  // New method to delete club details
  Future<bool> deleteClubDetails(String clubId) async {
    try {
      final response =
          await _supabase.from('club_details').delete().eq('id', clubId);

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
