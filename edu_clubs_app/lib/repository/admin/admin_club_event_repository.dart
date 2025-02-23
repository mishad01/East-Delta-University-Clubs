import 'dart:io';
import 'package:edu_clubs_app/view_model/club_events/club_events.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClubEventRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String?> uploadImage(File imageFile, String path) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = '$path/$fileName';

      await _supabase.storage
          .from('club_event_images')
          .upload(filePath, imageFile);

      return _supabase.storage.from('club_event_images').getPublicUrl(filePath);
    } catch (e) {
      print("Image upload error: $e");
      return null;
    }
  }

  Future<bool> addClubEvent(ClubEventModel event) async {
    try {
      await _supabase.from('club_events').insert(event.toMap());
      return true;
    } catch (e) {
      print("Add club event error: $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchEventDetails(
      String clubDetailsId) async {
    try {
      final response = await _supabase
          .from('club_events') // Fixed table name to match event data
          .select()
          .eq('club_details_id', clubDetailsId) // Corrected filtering condition
          .order('created_at', ascending: true);

      List<Map<String, dynamic>> _data = response.map((item) {
        final _data = ClubEventModel.fromMap(item);
        return {
          'club_details_id': clubDetailsId,
          'session_images': _data.sessionImages,
          'session_name': _data.sessionName,
        };
      }).toList();

      return _data;
    } catch (e) {
      print("Fetch event details error: $e");
      throw Exception('Failed to load data');
    }
  }
}
