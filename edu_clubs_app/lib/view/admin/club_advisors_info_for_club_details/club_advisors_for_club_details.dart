import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/club_details/club_advisors/club_advisor_controller.dart';

class ClubAdvisorsForClubDetails extends StatefulWidget {
  const ClubAdvisorsForClubDetails({super.key, required this.clubCategoryId});
  final String clubCategoryId;

  @override
  State<ClubAdvisorsForClubDetails> createState() =>
      _ClubAdvisorsForClubDetailsState();
}

class _ClubAdvisorsForClubDetailsState
    extends State<ClubAdvisorsForClubDetails> {
  final TextEditingController _advisorNameController = TextEditingController();
  final TextEditingController _advisorTypeController = TextEditingController();
  final TextEditingController _advisorEmailController = TextEditingController();
  final TextEditingController _advisorInfoController = TextEditingController();
  final TextEditingController _advisorImageLinkController =
      TextEditingController();

  void _clearFields() {
    _advisorNameController.clear();
    _advisorTypeController.clear();
    _advisorEmailController.clear();
    _advisorInfoController.clear();
    _advisorImageLinkController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advisor Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildAddCard(),
                    const SizedBox(height: 20),
                    SizedBox(height: 400, child: fetchClubAdvisorInfo()),
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
              "Advisor Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTextField(_advisorNameController, 'Advisor Name'),
            _buildTextField(_advisorTypeController, 'Advisor Type'),
            _buildTextField(_advisorEmailController, 'Advisor Email'),
            _buildTextField(_advisorInfoController, 'Advisor Info'),
            _buildTextField(_advisorImageLinkController, 'Advisor Image Link'),
            const SizedBox(height: 20),
            GetBuilder<ClubAdvisorsController>(
              builder: (controller) {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.inProgress
                        ? null
                        : () async {
                            final success = await controller.addAdvisor(
                              widget.clubCategoryId,
                              _advisorNameController.text,
                              _advisorTypeController.text,
                              _advisorEmailController.text,
                              _advisorInfoController.text,
                              _advisorImageLinkController.text,
                            );
                            if (success) {
                              _clearFields();
                              controller.fetchAdvisors(widget.clubCategoryId);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: controller.inProgress
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Submit",
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

  Widget fetchClubAdvisorInfo() {
    return GetBuilder<ClubAdvisorsController>(builder: (controller) {
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
          itemCount: controller.advisors.length,
          itemBuilder: (context, index) {
            final category = controller.advisors[index];
            return ListTile(
              title: Text(category.advisorName),
              subtitle: Column(
                children: [
                  Text(category.advisorType),
                  Text(category.advisorEmail),
                  Text(category.advisorInfoLink),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await controller.deleteClubAdvisor(category.id!);
                  controller.fetchAdvisors(
                      category.clubDetailsId); // Refresh list after delete
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
}
