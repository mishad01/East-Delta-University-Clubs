import 'dart:io';
import 'package:edu_clubs_app/view_model/home/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  TextEditingController imageLinkController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _isUploading = false;

  // Function to pick a file from the gallery

  Future<void> pickFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage =
            File(pickedFile.path); // Ensure state is updated immediately
      });
    }
  }

  // Function to upload the file to Supabase Storage
  Future<String?> _uploadBannerImage(File imageFile) async {
    try {
      setState(() => _isUploading = true);
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'banner_images/$fileName';

      await _supabase.storage
          .from('home_view_images')
          .upload(filePath, imageFile);
      final String publicUrl =
          _supabase.storage.from('home_view_images').getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image upload failed: $e')),
      );
      return null;
    } finally {
      setState(() => _isUploading = false);
    }
  }

  // Function to add a banner entry to the database
  Future<void> _addBanner() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    final imageUrl = await _uploadBannerImage(_selectedImage!);
    if (imageUrl == null) return;

    final banner = BannerModel(
      userId: '4902e25b-18ab-43cd-8e86-5d0cd57cf737',
      bannerImage: imageUrl,
      bannerLink: imageLinkController.text,
    );

    await _supabase.from("banner_or_slider").insert(banner.toMap());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Banner uploaded successfully!')),
    );

    // Clear inputs after upload
    imageLinkController.clear();
    setState(() {
      _selectedImage = null;
    });

    Navigator.of(context).pop(); // Close dialog
  }

  // Function to show the dialog and allow user to pick and upload the image
  void _showBannerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            title: Text('Add Banner and Link'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image Link Input
                TextField(
                  controller: imageLinkController,
                  decoration: InputDecoration(labelText: 'Image Link'),
                  enabled: !_isUploading, // Disable input while uploading
                ),
                SizedBox(height: 10),

                // Button to pick the image
                ElevatedButton(
                  onPressed: !_isUploading
                      ? () async {
                          await pickFile();
                          setDialogState(
                              () {}); // Trigger rebuild of the dialog
                        }
                      : null, // Disable button while uploading
                  child: Text('Pick Image'),
                ),
                SizedBox(height: 10),

                // If an image is selected, show the preview
                if (_selectedImage != null) ...[
                  Image.file(
                    _selectedImage!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover, // Add fit to ensure proper image scaling
                  ),
                  SizedBox(height: 10),
                ],

                // Show a circular progress indicator if uploading
                if (_isUploading) Center(child: CircularProgressIndicator()),
              ],
            ),
            actions: [
              // Cancel Button
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),

              // Save Button
              TextButton(
                onPressed: _isUploading
                    ? null
                    : _addBanner, // Disable Save button during upload
                child: Text('Save'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _showBannerDialog,
        child: Container(
          width: 368,
          height: 212,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(26)),
            color: Colors.black,
          ),
          child: Center(
            child: Text(
              "Add Banner and Link If have any",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
