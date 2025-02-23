import 'package:edu_clubs_app/view_model/club_faq/club_faq_controller.dart';
import 'package:edu_clubs_app/view_model/club_details/club_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminClubFAQView extends StatefulWidget {
  const AdminClubFAQView({super.key, required this.categoriesId});
  final String categoriesId;

  @override
  State<AdminClubFAQView> createState() => _AdminClubFAQViewState();
}

class _AdminClubFAQViewState extends State<AdminClubFAQView> {
  late ClubFAQController faqController;
  late ClubDetailsController detailsController;
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    faqController = Get.put(ClubFAQController());
    detailsController = Get.put(ClubDetailsController());

    detailsController.fetchClubCategories(widget.categoriesId);

    /// Listen for club details update and fetch FAQs once data is available
    ever(detailsController.clubDetails, (details) {
      if (details.isNotEmpty) {
        faqController
            .fetchFAQs(details.first['id']); // Fetch FAQs using club ID
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club FAQs')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// **Club Details Card**
            Obx(() {
              if (detailsController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (detailsController.clubDetails.isEmpty) {
                return const Center(child: Text("No club details found."));
              }

              final club = detailsController.clubDetails.first;

              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Club ID: ${club['id']}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text("What We Do: ${club['what_we_do']}"),
                      const SizedBox(height: 8),
                      Text("Why Join Us: ${club['why_join_us']}"),
                      const SizedBox(height: 8),
                      Text("Recent Openings: ${club['recent_openings']}"),
                      const SizedBox(height: 8),
                      Text(
                          "Upcoming Activities: ${club['upcoming_activities']}"),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),

            /// **FAQ Submission Form**
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: questionController,
                      decoration: InputDecoration(
                        labelText: 'Question',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.question_answer),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: answerController,
                      decoration: InputDecoration(
                        labelText: 'Answer',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.edit),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Obx(() => ElevatedButton(
                            onPressed: faqController.isLoading.value
                                ? null
                                : () async {
                                    if (detailsController
                                        .clubDetails.isNotEmpty) {
                                      await faqController.addClubFAQ(
                                        questionController.text,
                                        answerController.text,
                                        detailsController.clubDetails.first[
                                            'id'], // Correct clubDetails ID
                                      );
                                      questionController.clear();
                                      answerController.clear();
                                      faqController.fetchFAQs(detailsController
                                          .clubDetails.first['id']);
                                    } else {
                                      Get.snackbar("Error",
                                          "Club details not loaded yet.");
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: faqController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// **Display FAQs List**
            Obx(() {
              if (faqController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (faqController.allFAQ.isEmpty) {
                return const Center(child: Text("No FAQs found."));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: faqController.allFAQ.length,
                itemBuilder: (context, index) {
                  final faq = faqController.allFAQ[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        faq['question'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(faq['answer']),
                      leading: const Icon(Icons.question_answer,
                          color: Colors.blueAccent),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
