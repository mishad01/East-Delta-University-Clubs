import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/club_details/recent_and_upcoming_activites/activities_controller.dart';

class AdminActivitiesView extends StatefulWidget {
  const AdminActivitiesView({super.key, required this.clubCategoryId});
  final String clubCategoryId;

  @override
  State<AdminActivitiesView> createState() => _AdminActivitiesViewState();
}

class _AdminActivitiesViewState extends State<AdminActivitiesView> {
  final TextEditingController _recentOpeningDetails = TextEditingController();
  final TextEditingController _recentOpeningLink = TextEditingController();
  final TextEditingController _upcomingActivitiesDetails =
      TextEditingController();
  final TextEditingController _upcomingActivitiesLink = TextEditingController();

  final ActivitiesController _controller = Get.put(ActivitiesController());

  @override
  void initState() {
    super.initState();
    _controller.fetchActivities(widget.clubCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recent & Upcoming Activities')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildAddCard(),
                    fetchClubActivities(),
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
            const Text(
              "Recent & Upcoming Activities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTextField(_recentOpeningDetails, 'Recent Opening Details'),
            _buildTextField(_recentOpeningLink, 'Recent Opening Link'),
            _buildTextField(
                _upcomingActivitiesDetails, 'Upcoming Activities Details'),
            _buildTextField(
                _upcomingActivitiesLink, 'Upcoming Activities Link'),
            const SizedBox(height: 20),
            GetBuilder<ActivitiesController>(builder: (controller) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.inProgress
                      ? null
                      : () async {
                          final success = await controller.addActivity(
                            widget.clubCategoryId,
                            _recentOpeningDetails.text,
                            _recentOpeningLink.text,
                            _upcomingActivitiesDetails.text,
                            _upcomingActivitiesLink.text,
                          );
                          if (success) {
                            _clearFields();
                            controller.fetchActivities(widget.clubCategoryId);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget fetchClubActivities() {
    return GetBuilder<ActivitiesController>(builder: (controller) {
      if (controller.inProgress) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage != null) {
        return Center(child: Text(controller.errorMessage!));
      }
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5, // Ensure full display
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.activities.length,
          itemBuilder: (context, index) {
            final activity = controller.activities[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                title: Text(activity.recentOpeningDetails),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Link: ${activity.id}"),
                    Text("Link: ${activity.recentOpeningLink}"),
                    Text("Upcoming: ${activity.upcomingActivitiesDetails}"),
                    Text("Upcoming Link: ${activity.upcomingActivitiesLink}"),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await controller.deleteActivities(activity.id!);
                    controller.fetchActivities(widget.clubCategoryId);
                  },
                ),
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
    _recentOpeningDetails.clear();
    _recentOpeningLink.clear();
    _upcomingActivitiesDetails.clear();
    _upcomingActivitiesLink.clear();
  }
}
