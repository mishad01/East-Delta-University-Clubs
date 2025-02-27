/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edu_clubs_app/view_model/club_details/club_details_controller.dart';

class Test2View extends StatelessWidget {
  final ClubDetailsController _controller = Get.put(ClubDetailsController());
  final TextEditingController categoryIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Club Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: categoryIdController,
              decoration: InputDecoration(labelText: 'Category ID'),
            ),
            SizedBox(height: 20),
            Obx(
              () {
                if (_controller.isLoading.value) {
                  return CircularProgressIndicator();
                }

                if (_controller.errorMessage.isNotEmpty) {
                  return Text(_controller.errorMessage.value,
                      style: TextStyle(color: Colors.red));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: _controller.clubDetails.length,
                    itemBuilder: (context, index) {
                      final club = _controller.clubDetails[index];
                      return ListTile(
                        title: Text(club['club_name']),
                        subtitle: Text(club['what_we_do']),
                      );
                    },
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                _controller.fetchClubCategories(categoryIdController.text);
              },
              child: Text('Fetch Club Details'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
