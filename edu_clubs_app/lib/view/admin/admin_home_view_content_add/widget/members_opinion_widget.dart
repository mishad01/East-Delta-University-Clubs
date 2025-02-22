import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/home/club_member_opinion_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MemberOpinionsWidget extends StatefulWidget {
  @override
  State<MemberOpinionsWidget> createState() => _MemberOpinionsWidgetState();
}

class _MemberOpinionsWidgetState extends State<MemberOpinionsWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> _addMemberOpinion() async {
    try {
      final banner = ClubMemberOpinionModel(
        userId: '4902e25b-18ab-43cd-8e86-5d0cd57cf737',
        clubMemberName: nameController.text,
        clubNameWithPosition: positionController.text,
        clubOpinionDescription: descriptionController.text,
      );

      final response =
          await _supabase.from("club_member_opinion").insert(banner.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Banner uploaded successfully!')),
      );

      nameController.clear();
      positionController.clear();
      descriptionController.clear();
      Navigator.of(context).pop();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          buildMembersOpinion(
            "Add Name",
            "GM of commuter club",
            "Add description",
            null,
            Color(0xffFDEBB9),
          ),
        ],
      ),
    );
  }

  Widget buildMembersOpinion(
      String name, String club, String opinion, Widget? spacer, Color color) {
    return GestureDetector(
      onTap: () => _showDialog(),
      child: Container(
        height: 110,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Colors.black,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                club,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              Text(
                opinion,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to show the AlertDialog
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Member Opinion'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: positionController,
                decoration: InputDecoration(labelText: 'Position'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addMemberOpinion();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
