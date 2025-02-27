import 'package:edu_clubs_app/data/repositories/admin/admin_club_details_repository.dart';
import 'package:edu_clubs_app/data/repositories/admin/admin_home_view_content_add/members_opinion_repository.dart';
import 'package:edu_clubs_app/user_app.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qbeosuqjlcmeaiunnthw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFiZW9zdXFqbGNtZWFpdW5udGh3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk4MTk3OTcsImV4cCI6MjA1NTM5NTc5N30.43oQJViwiIX6_nIM6gglfB4P4dpAHDdlPAWFD7_sQXM',
  );

  Get.lazyPut(() => AdminClubDetailsRepository());
  Get.lazyPut(() => MemberOpinionRepository());
  runApp(EduClubsUser());
}
