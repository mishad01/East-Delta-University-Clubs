import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:edu_clubs_app/data/models/admin/home/club_member_opinion_model.dart';

class MemberOpinionRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> addMemberOpinion(ClubMemberOpinionModel opinion) async {
    try {
      await _supabase.from("club_member_opinion").insert(opinion.toMap());
      return true;
    } catch (error) {
      print("Error adding opinion: $error");
      return false;
    }
  }

  Future<List<ClubMemberOpinionModel>> fetchMemberOpinions() async {
    try {
      final response = await _supabase.from("club_member_opinion").select();
      return response
          .map<ClubMemberOpinionModel>(
              (data) => ClubMemberOpinionModel.fromMap(data))
          .toList();
    } catch (error) {
      print("Error fetching opinions: $error");
      return [];
    }
  }
}
