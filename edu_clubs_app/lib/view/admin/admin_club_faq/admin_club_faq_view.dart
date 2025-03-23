import 'package:edu_clubs_app/view_model/club_faq/club_faq_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminClubFAQView extends StatefulWidget {
  const AdminClubFAQView({super.key, required this.categoriesId});
  final String categoriesId;

  @override
  State<AdminClubFAQView> createState() => _AdminClubFAQViewState();
}

class _AdminClubFAQViewState extends State<AdminClubFAQView> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  final ClubFAQController _controller = Get.put(ClubFAQController());

  @override
  void initState() {
    super.initState();
    _controller.fetchClubFAQs(widget.categoriesId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club FAQs')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// **FAQ Submission Form**
              buildAddCard(),
              const SizedBox(height: 16),

              /// **Display FAQs List**
              fetchClubFAQs(),
            ],
          ),
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
              "Add New FAQ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTextField(questionController, 'Question'),
            _buildTextField(answerController, 'Answer'),
            const SizedBox(height: 20),
            GetBuilder<ClubFAQController>(builder: (controller) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.inProgress
                      ? null
                      : () async {
                          final success = await controller.addClubFAQ(
                            widget.categoriesId,
                            questionController.text,
                            answerController.text,
                          );
                          if (success) {
                            _clearFields();
                            controller.fetchClubFAQs(widget.categoriesId);
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

  Widget fetchClubFAQs() {
    return GetBuilder<ClubFAQController>(builder: (controller) {
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
          itemCount: controller.clubFAQs.length,
          itemBuilder: (context, index) {
            final faq = controller.clubFAQs[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                title: Text(faq.question),
                subtitle: Text(faq.answer),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await controller.deleteClubDetails(faq.id!);
                    controller.fetchClubFAQs(widget.categoriesId);
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
    questionController.clear();
    answerController.clear();
  }
}
