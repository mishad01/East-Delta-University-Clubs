import 'package:edu_clubs_app/view_model/club_details/club_details_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminClubDetailsView extends StatefulWidget {
  const AdminClubDetailsView({super.key});

  @override
  _AdminClubDetailsViewState createState() => _AdminClubDetailsViewState();
}

class _AdminClubDetailsViewState extends State<AdminClubDetailsView> {
  final TextEditingController _clubNameController = TextEditingController();
  final TextEditingController _whatWeDoController = TextEditingController();
  final TextEditingController _whyJoinUsController = TextEditingController();
  final TextEditingController _recentOpeningsController =
  TextEditingController();
  final TextEditingController _upcomingActivitiesController =
  TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;

  final bool _isLoading = false;

  /*Future<void> _addClubDetails() async {
    setState(() {
      _isLoading = true;
    });

    final response = await _supabase.from('clubs').insert({
      'category_id': '6d03e8b6-fb63-4b55-8ffd-be06eba94abb',
      'club_name': _clubNameController.text,
      'what_we_do': _whatWeDoController.text,
      'why_join_us': _whyJoinUsController.text,
      'recent_openings': _recentOpeningsController.text,
      'upcoming_activities': _upcomingActivitiesController.text,
      'created_at': DateTime.now().toIso8601String(),
    });

    if (response.error == null) {
      _clearFields();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Club details added successfully!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Failed to add club details: ${response.error!.message}')));
    }

    setState(() {
      _isLoading = false;
    });
  }*/

  Future<void> _addClubDetails() async {
    final newClubDetails = ClubDetailsModel(
      categoryId: '3a157201-0e6a-468e-9d19-fe84f45a1b2a',
      clubName: _clubNameController.text,
      whatWeDo: _whatWeDoController.text,
      whyJoinUs: _whyJoinUsController.text,
      recentOpenings: _recentOpeningsController.text,
      upcomingActivities: _upcomingActivitiesController.text,


    );

    await Supabase.instance.client
        .from("club_details")
        .insert(newClubDetails.toMap());
  }

  void _clearFields() {
    _clubNameController.clear();
    _whatWeDoController.clear();
    _whyJoinUsController.clear();
    _recentOpeningsController.clear();
    _upcomingActivitiesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Club Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _clubNameController,
                decoration: const InputDecoration(labelText: 'Club Name')),
            TextField(
                controller: _whatWeDoController,
                decoration: const InputDecoration(labelText: 'What We Do')),
            TextField(
                controller: _whyJoinUsController,
                decoration: const InputDecoration(labelText: 'Why Join Us')),
            TextField(
                controller: _recentOpeningsController,
                decoration: const InputDecoration(labelText: 'Recent Openings')),
            TextField(
                controller: _upcomingActivitiesController,
                decoration: const InputDecoration(labelText: 'Upcoming Activities')),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _addClubDetails,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
