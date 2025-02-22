import 'dart:io';
import 'package:edu_clubs_app/view_model/club_events/club_events.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminClubEventView extends StatefulWidget {
  const AdminClubEventView({super.key});

  @override
  _AdminClubEventViewState createState() => _AdminClubEventViewState();
}

class _AdminClubEventViewState extends State<AdminClubEventView> {
  final TextEditingController _sessionNameController = TextEditingController();
  final TextEditingController _prizeGivingTitleController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;

  File? _sessionImage;
  File? _prizeGivingImage;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isSessionImage) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isSessionImage) {
          _sessionImage = File(pickedFile.path);
        } else {
          _prizeGivingImage = File(pickedFile.path);
        }
      });
    }
  }

  Future<String?> _uploadImage(File imageFile, String path) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = '$path/$fileName';
      await _supabase.storage.from('club_event_images').upload(filePath, imageFile);
      final String publicUrl = _supabase.storage.from('club_event_images').getPublicUrl(filePath);
      return publicUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image upload failed: $e')));
      return null;
    }
  }

  Future<void> _addClubEvent() async {
    if (_sessionImage == null || _prizeGivingImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both images')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final sessionImageUrl = await _uploadImage(_sessionImage!, 'session_images');
    final prizeGivingImageUrl = await _uploadImage(_prizeGivingImage!, 'prize_giving_images');

    if (sessionImageUrl != null && prizeGivingImageUrl != null) {
      final newClubEvent = ClubEventModel(
        clubDetailsId: '656c5b7f-fbd1-4807-a620-b878c3c1c583', // Replace with actual ID
        createdAt: DateTime.now(),
        sessionImages: sessionImageUrl,
        sessionName: _sessionNameController.text,
        prizeGivingImage: prizeGivingImageUrl,
        prizeGivingTitle: _prizeGivingTitleController.text,
      );

      await _supabase.from('club_events').insert(newClubEvent.toMap());
      _clearFields();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Club event added successfully!')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _clearFields() {
    _sessionNameController.clear();
    _prizeGivingTitleController.clear();
    setState(() {
      _sessionImage = null;
      _prizeGivingImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club Events')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _sessionNameController,
                decoration: const InputDecoration(labelText: 'Session Name')),
            const SizedBox(height: 10),
            _sessionImage == null
                ? ElevatedButton(
              onPressed: () => _pickImage(true),
              child: const Text('Pick Session Image'),
            )
                : Column(
              children: [
                Image.file(_sessionImage!, height: 100),
                const SizedBox(height: 10),
                Text(_sessionImage!.path), // Display the file path
              ],
            ),
            const SizedBox(height: 10),
            TextField(
                controller: _prizeGivingTitleController,
                decoration: const InputDecoration(labelText: 'Prize Giving Title')),
            const SizedBox(height: 10),
            _prizeGivingImage == null
                ? ElevatedButton(
              onPressed: () => _pickImage(false),
              child: const Text('Pick Prize Giving Image'),
            )
                : Column(
              children: [
                Image.file(_prizeGivingImage!, height: 100),
                const SizedBox(height: 10),
                Text(_prizeGivingImage!.path), // Display the file path
              ],
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _addClubEvent,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

}
