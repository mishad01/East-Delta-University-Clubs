import 'package:edu_clubs_app/view_model/club_events/club_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestView extends StatelessWidget {
  final ClubEventController _controller = Get.put(ClubEventController());
  final String clubDetailsId; // Add clubDetailsId as a required parameter

  TestView({required this.clubDetailsId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Club Events Fetch'),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (_controller.errorMessage.isNotEmpty) {
          return Center(child: Text(_controller.errorMessage.value));
        }

        if (_controller.allEvents.isEmpty) {
          return Center(child: Text('No events found.'));
        }

        return ListView.builder(
          itemCount: _controller.allEvents.length,
          itemBuilder: (context, index) {
            final event = _controller.allEvents[index];
            return ListTile(
              title: Text(event['sessionName'] ?? 'No Name'),
              subtitle: Text('Event ID: ${event['id']}'),
              leading: event['sessionImages'] != null
                  ? Image.network(event['sessionImages'])
                  : Icon(Icons.image_not_supported),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use the clubDetailsId passed in the constructor
          _controller.fetchEvents(clubDetailsId);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
