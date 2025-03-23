import 'package:edu_clubs_app/data/models/recent_and_upcoming_activities_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActivitiesRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> addRecentUpcomingActivity(ActivitiesModel activity) async {
    try {
      await _supabase
          .from('recent_and_upcoming_activities')
          .insert(activity.toMap());
      return true;
    } catch (e) {
      print("Add recent/upcoming activity error: \$e");
      return false;
    }
  }

  Future<bool> updateRecentUpcomingActivity(
      String id, ActivitiesModel activity) async {
    try {
      await _supabase
          .from('recent_and_upcoming_activities')
          .update(activity.toMap())
          .eq('id', id);
      return true;
    } catch (e) {
      print("Update recent/upcoming activity error: \$e");
      return false;
    }
  }

  Future<List<ActivitiesModel>> fetchRecentUpcomingActivities(
      String clubDetailsId) async {
    try {
      final response = await _supabase
          .from('recent_and_upcoming_activities')
          .select()
          .eq('club_details_id', clubDetailsId)
          .order('created_at', ascending: true);

      return response.map((data) => ActivitiesModel.fromMap(data)).toList();
    } catch (e) {
      print("Fetch recent/upcoming activities error: \$e");
      return [];
    }
  }

  Future<bool> deleteClubActivities(String clubId) async {
    try {
      final response = await _supabase
          .from('recent_and_upcoming_activities')
          .delete()
          .eq('id', clubId);

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
