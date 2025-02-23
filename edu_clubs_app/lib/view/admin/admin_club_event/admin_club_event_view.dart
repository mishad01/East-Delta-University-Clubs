import 'package:edu_clubs_app/view_model/club_details/club_details_controller.dart';
import 'package:edu_clubs_app/view_model/club_events/club_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminClubEventView extends StatefulWidget {
  final String categoriesId;

  const AdminClubEventView({super.key, required this.categoriesId});

  @override
  _AdminClubEventViewState createState() => _AdminClubEventViewState();
}

class _AdminClubEventViewState extends State<AdminClubEventView> {
  late ClubEventController eventController;
  late ClubDetailsController detailsController;

  @override
  void initState() {
    super.initState();
    eventController = Get.put(ClubEventController());
    detailsController = Get.put(ClubDetailsController());
    detailsController.fetchClubCategories(widget.categoriesId);

    /// Listen for club details update and fetch FAQs once data is available
    ever(detailsController.clubDetails, (details) {
      if (details.isNotEmpty) {
        eventController
            .fetchEvents(details.first['id']); // Fetch FAQs using club ID
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club Events')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                        "Club id: ${club['id']}",
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

            /// Event Adding Section
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Session Name Field
                    TextField(
                      onChanged: (value) =>
                          eventController.sessionName.value = value,
                      decoration: InputDecoration(
                        labelText: 'Session Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.event),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Session Image Picker
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => eventController.pickImage(),
                            icon: const Icon(Icons.image),
                            label: const Text('Pick Session Image'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Obx(() => eventController.sessionImage.value != null
                            ? Image.file(
                                eventController.sessionImage.value!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox.shrink()),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Submit Button
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            eventController.addClubEvent(
                                detailsController.clubDetails.first['id']);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: eventController.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                        ),
                      ),
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
}
