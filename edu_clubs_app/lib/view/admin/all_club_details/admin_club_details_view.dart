import 'package:edu_clubs_app/view_model/club_details/club_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminClubDetailsView extends StatefulWidget {
  AdminClubDetailsView({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  @override
  State<AdminClubDetailsView> createState() => _AdminClubDetailsViewState();
}

class _AdminClubDetailsViewState extends State<AdminClubDetailsView> {
  final ClubDetailsController _clubController =
      Get.put(ClubDetailsController());

  final TextEditingController _clubNameController = TextEditingController();
  final TextEditingController _whatWeDoController = TextEditingController();
  final TextEditingController _whyJoinUsController = TextEditingController();
  final TextEditingController _recentOpeningsController =
      TextEditingController();
  final TextEditingController _upcomingActivitiesController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Fetch club details when the widget is built
    _clubController.fetchClubCategories(widget.categoryId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Club Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildAddCard(),
                    GetBuilder<ClubDetailsController>(
                      builder: (controller) {
                        if (controller.inProgress) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (controller.errorMessage != null &&
                            controller.errorMessage!.isNotEmpty) {
                          return Center(
                            child: Text(controller.errorMessage!),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.clubDetails.length,
                          itemBuilder: (context, index) {
                            final club = controller.clubDetails[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(club['club_name']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("What We Do: ${club['what_we_do']}"),
                                    Text("Why Join Us: ${club['why_join_us']}"),
                                    Text(
                                        "Recent Openings: ${club['recent_openings']}"),
                                    Text(
                                        "Upcoming Activities: ${club['upcoming_activities']}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitClubDetails() {
    _clubController.addClubDetails(
      widget.categoryId,
      _clubNameController.text,
      _whatWeDoController.text,
      _whyJoinUsController.text,
      _recentOpeningsController.text,
      _upcomingActivitiesController.text,
    );

    // Optionally clear the fields after submission
    _clubNameController.clear();
    _whatWeDoController.clear();
    _whyJoinUsController.clear();
    _recentOpeningsController.clear();
    _upcomingActivitiesController.clear();
  }

  Widget buildAddCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
            GetBuilder<ClubDetailsController>(
              builder: (controller) => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.inProgress ? null : _submitClubDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: controller.inProgress
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Submit',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
          ],
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
