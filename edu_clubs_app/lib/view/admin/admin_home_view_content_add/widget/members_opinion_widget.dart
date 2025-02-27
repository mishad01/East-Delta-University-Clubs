import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/admin/home/member_opinion_controller.dart';
import 'package:get/get.dart';

class MemberOpinionsWidget extends StatefulWidget {
  @override
  State<MemberOpinionsWidget> createState() => _MemberOpinionsWidgetState();
}

class _MemberOpinionsWidgetState extends State<MemberOpinionsWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
    String name,
    String club,
    String opinion,
    Widget? spacer,
    Color color,
  ) {
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
    final MemberOpinionsController controller =
        Get.find<MemberOpinionsController>();

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
            GetBuilder<MemberOpinionsController>(
              builder: (controller) {
                return TextButton(
                  onPressed: controller.inProgress
                      ? null
                      : () async {
                          bool success = await controller.addOpinion(
                            "user_id", // Replace with actual user ID
                            nameController.text,
                            positionController.text,
                            descriptionController.text,
                          );

                          if (success) {
                            Get.snackbar(
                                "Success", "Opinion added successfully!",
                                snackPosition: SnackPosition.BOTTOM);
                            nameController.clear();
                            positionController.clear();
                            descriptionController.clear();
                            Navigator.of(context).pop();
                          } else {
                            Get.snackbar("Error", "Failed to add opinion!",
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                  child: controller.inProgress
                      ? CircularProgressIndicator()
                      : Text('Submit'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
