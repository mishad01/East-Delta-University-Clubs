import 'dart:io';
import 'package:edu_clubs_app/data/models/club_events_model.dart';
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

      final String imageUrl =
          _supabase.storage.from('club_event_images').getPublicUrl(filePath);

      print("Image uploaded successfully: $imageUrl");
      return imageUrl;
    } catch (e) {
      print("Image upload error: $e");
      return null;
    }
  }

  Future<bool> addClubEvent(ClubEventModel event) async {
    try {
      final response =
          await _supabase.from('club_events').insert(event.toMap());
      print("Supabase Response: $response");
      return true;
    } catch (e) {
      print("Add club event error: $e");
      return false;
    }
  }

  Future<List<ClubEventModel>> fetchEventDetails(String clubDetailsId) async {
    try {
      final response = await _supabase
          .from('club_events')
          .select()
          .eq('club_details_id', clubDetailsId)
          .order('created_at', ascending: true);

      return response.map((data) => ClubEventModel.fromMap(data)).toList();
    } catch (e) {
      print("Fetch event details error: $e");
      return [];
    }
  }

  Future<bool> deleteClubEvent(String clubId) async {
    try {
      final response =
          await _supabase.from('club_events').delete().eq('id', clubId);

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
