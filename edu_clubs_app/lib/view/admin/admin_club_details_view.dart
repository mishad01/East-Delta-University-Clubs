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

  bool _isLoading = false;

  Future<void> _addClubDetails() async {
    setState(() => _isLoading = true);

    final newClubDetails = ClubDetailsModel(
      categoryId: '3a157201-0e6a-468e-9d19-fe84f45a1b2a',
      clubName: _clubNameController.text,
      whatWeDo: _whatWeDoController.text,
      whyJoinUs: _whyJoinUsController.text,
      recentOpenings: _recentOpeningsController.text,
      upcomingActivities: _upcomingActivitiesController.text,
    );

    try {
      await _supabase.from("club_details").insert(newClubDetails.toMap());
      _clearFields();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Club details added successfully!')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add club details: $error')),
      );
    }

    setState(() => _isLoading = false);
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
      appBar: AppBar(
        title: const Text('Admin Club Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(_clubNameController, 'Club Name'),
                _buildTextField(_whatWeDoController, 'What We Do'),
                _buildTextField(_whyJoinUsController, 'Why Join Us'),
                _buildTextField(_recentOpeningsController, 'Recent Openings'),
                _buildTextField(
                    _upcomingActivitiesController, 'Upcoming Activities'),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _addClubDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Submit',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
