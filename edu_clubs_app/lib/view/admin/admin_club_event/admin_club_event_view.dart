import 'dart:io';
import 'package:edu_clubs_app/view_model/club_events/club_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminClubEventView extends StatefulWidget {
  AdminClubEventView({
    super.key,
    required this.clubDetailsId,
  });

  final String clubDetailsId;

  @override
  _AdminClubEventViewState createState() => _AdminClubEventViewState();
}

class _AdminClubEventViewState extends State<AdminClubEventView> {
  final TextEditingController _sessionNameController = TextEditingController();
  final TextEditingController _sessionDatesController = TextEditingController();

  final ClubEventController _controller = Get.put(ClubEventController());
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  // Constants for styling
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 15.0;

  @override
  void initState() {
    super.initState();
    // Call fetchClubEvents when the widget is loaded
    _controller.fetchClubEvents(widget.clubDetailsId);
  }

  // This function will open the date picker and set the picked date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _sessionDatesController.text = "${pickedDate.toLocal()}"
            .split(' ')[0]; // Display the date in yyyy-MM-dd format
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club Category Management')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildAddCard(),
            const SizedBox(height: 20),
            const Divider(),
            buildEventList(),
          ],
        ),
      ),
    );
  }

  Widget buildAddCard() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            buildTextField(
                controller: _sessionNameController,
                labelText: 'Session Name',
                icon: Icons.group),
            const SizedBox(height: defaultPadding),
            buildDatePickerField(),
            const SizedBox(height: defaultPadding),
            buildImagePicker(),
            const SizedBox(height: 20),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius)),
        prefixIcon: Icon(icon),
      ),
    );
  }

  // This widget will be the DatePicker for selecting the session date
  Widget buildDatePickerField() {
    return GestureDetector(
      onTap: () => _selectDate(context), // Opens the date picker
      child: AbsorbPointer(
        child: TextField(
          controller: _sessionDatesController,
          decoration: InputDecoration(
            labelText: 'Session Date',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultBorderRadius)),
            prefixIcon: Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }

  Widget buildImagePicker() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final pickedFile =
                await _imagePicker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              setState(() {
                _selectedImage = File(pickedFile.path);
              });
            }
          },
          child: const Text('Pick Icon Image'),
        ),
        if (_selectedImage != null) ...[
          const SizedBox(height: defaultPadding),
          Image.file(
            _selectedImage!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ],
    );
  }

  Widget buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          // Validate inputs
          if (_sessionNameController.text.isEmpty ||
              _sessionDatesController.text.isEmpty ||
              _selectedImage == null) {
            Get.snackbar("Error", "Please fill in all required fields.");
            return;
          }

          // Upload the image and get the URL
          String? imageUrl =
              await _controller.uploadEventImage(_selectedImage!);

          if (imageUrl != null) {
            // Add the event if the image is uploaded successfully
            bool success = await _controller.addClubEvent(
              widget.clubDetailsId,
              imageUrl,
              _sessionNameController.text,
              _sessionDatesController.text,
            );

            if (success) {
              // Clear inputs after successful submission
              _sessionNameController.clear();
              _sessionDatesController.clear();
              setState(() {
                _selectedImage = null;
              });
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius)),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildEventList() {
    return GetBuilder<ClubEventController>(builder: (controller) {
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
          itemCount: controller.clubEvents.length,
          itemBuilder: (context, index) {
            final category = controller.clubEvents[index];
            return ListTile(
              title: Text(category.sessionName),
              subtitle: Text(category.sessionDate),
              leading: category.sessionImages.isNotEmpty
                  ? Image.network(category.sessionImages)
                  : const Icon(Icons.group),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await controller.deleteClubEvent(category.id!);
                  controller.fetchClubEvents(
                      widget.clubDetailsId); // Refresh list after delete
                },
              ),
            );
          },
        ),
      );
    });
  }
}
