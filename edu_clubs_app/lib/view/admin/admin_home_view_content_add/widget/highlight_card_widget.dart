import 'dart:io';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/home/prize_giving_ceremony_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase for uploading

class HighlightCardWidget extends StatefulWidget {
  @override
  _HighlightCardWidgetState createState() => _HighlightCardWidgetState();
}

class _HighlightCardWidgetState extends State<HighlightCardWidget> {
  TextEditingController ceremonyController = TextEditingController();
  TextEditingController dateController = TextEditingController();
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

  Future<String?> _uploadPrizeGivingImage(File imageFile) async {
    try {
      setState(() => _isUploading = true);
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'prize_giving_images/$fileName';

      final response = await _supabase.storage
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
  Future<void> _addPrizeGivingCeremony() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    final imageUrl = await _uploadPrizeGivingImage(_selectedImage!);
    if (imageUrl == null) return;

    final banner = PrizeGivingCeremonyModel(
      userId: '4902e25b-18ab-43cd-8e86-5d0cd57cf737',
      prizeGivingImage: imageUrl, // Use the uploaded image URL
      prizeGivingDate: dateController.text,
    );

    await _supabase.from("prize_giving_ceremony").insert(banner.toMap());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Banner uploaded successfully!')),
    );

    // Clear inputs after upload
    ceremonyController.clear();
    dateController.clear();
    setState(() {
      _selectedImage = null;
    });

    Navigator.of(context).pop(); // Close dialog
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            title: Text('Add Ceremony Details'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                controller: ceremonyController,
                decoration: InputDecoration(
                  labelText: 'Add Ceremony Name',
                ),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Add Date',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: !_isUploading
                    ? () async {
                        await pickFile();
                        setDialogState(() {}); // Trigger rebuild of the dialog
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
            ]),
            actions: [
              TextButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: _isUploading
                    ? null
                    : _addPrizeGivingCeremony, // Disable Save button during upload
                child: Text('Save'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDialog();
      },
      child: Container(
        child: Stack(
          children: [
            SvgPicture.asset(
              AssetsPath.card,
              width: 300,
              height: 320,
            ),
            _buildHighlightText("Add Ceremony Name", 20, 10),
            _buildHighlightText("Add Date", 220, 10, fontSize: 10),
            _buildAddImageButton(),
          ],
        ),
      ),
    );
  }

  Positioned _buildHighlightText(String text, double left, double top,
      {double fontSize = 14}) {
    return Positioned(
      left: left,
      top: top,
      child: Text(
        text,
        style: GoogleFonts.sourceSerif4(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }

  Positioned _buildAddImageButton() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              _showDialog();
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Text(
            "Add Prize Giving ceremony Image",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
