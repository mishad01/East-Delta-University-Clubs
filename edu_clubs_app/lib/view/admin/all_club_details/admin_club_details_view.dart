import 'package:edu_clubs_app/view_model/club_details/club_details_controller.dart';
import 'package:edu_clubs_app/view_model/club_events/club_event_controller.dart';
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
  final TextEditingController _clubNameController = TextEditingController();
  final TextEditingController _whatWeDoController = TextEditingController();
  final TextEditingController _whyJoinUsReason1Controller =
      TextEditingController();
  final TextEditingController _whyJoinUsReason2Controller =
      TextEditingController();

  final ClubDetailsController _controller = Get.put(ClubDetailsController());
  final ClubEventController _eventController = Get.put(ClubEventController());

  @override
  void initState() {
    super.initState();
    // Fetch club details when the view is loaded
    _controller.fetchClubDetails(widget.categoryId);
    _eventController.fetchClubEvents(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
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
                    fetchClubDetailsInfo(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
            _buildTextField(
                _whyJoinUsReason1Controller, 'Why Join Us Reason 1'),
            _buildTextField(
                _whyJoinUsReason2Controller, 'Why Join Us Reason 2'),
            const SizedBox(height: 20),
            // Submit button with logic for adding club details
            GetBuilder<ClubDetailsController>(
              builder: (controller) {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.inProgress
                        ? null // Disable button if in progress
                        : () async {
                            final success = await controller.addClubDetails(
                              widget.categoryId,
                              _clubNameController.text,
                              _whatWeDoController.text,
                              _whyJoinUsReason1Controller.text,
                              _whyJoinUsReason2Controller.text,
                            );
                            if (success) {
                              _clearFields();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: controller.inProgress
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget fetchClubDetailsInfo() {
    return GetBuilder<ClubDetailsController>(builder: (_) {
      if (_controller.inProgress) {
        return const Center(child: CircularProgressIndicator());
      }
      if (_controller.errorMessage != null) {
        return Center(child: Text(_controller.errorMessage!));
      }
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5, // Ensure full display
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _controller.clubDetails.length,
          itemBuilder: (context, index) {
            final category = _controller.clubDetails[index];
            return ListTile(
              title: Text(category.clubName),
              subtitle: Column(
                children: [
                  Text(category.whatWeDo),
                  Text(category.whyJoinUsReason1),
                  Text(category.whyJoinUsReason2),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await _controller.deleteClubDetails(category.id!);
                  _controller.fetchClubDetails(
                      category.categoryId); // Refresh list after delete
                },
              ),
            );
          },
        ),
      );
    });
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

  void _clearFields() {
    _clubNameController.clear();
    _whatWeDoController.clear();
    _whyJoinUsReason1Controller.clear();
    _whyJoinUsReason2Controller.clear();
  }
}
