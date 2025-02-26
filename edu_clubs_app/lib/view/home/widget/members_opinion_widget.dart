import 'package:edu_clubs_app/view_model/admin/home/member_opinion_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembersOpinionsWidgets extends StatelessWidget {
  const MembersOpinionsWidgets({Key? key}) : super(key: key);

  // Helper method to build a member opinion card
  Widget buildMembersOpinion(
      String name, String club, String opinion, Widget? spacer, Color color) {
    return Row(
      children: [
        if (spacer != null) spacer,
        Container(
          height: 110,
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final MemberOpinionsController controller =
        Get.put(MemberOpinionsController());

    // Fetch opinions when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchOpinions();
    });

    return GetBuilder<MemberOpinionsController>(
      builder: (controller) {
        if (controller.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage != null) {
          return Center(child: Text(controller.errorMessage!));
        }

        if (controller.memberOpinionList.isEmpty) {
          return const Center(child: Text("No opinions found."));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: controller.memberOpinionList.map((opinion) {
              // Alternate colors for each opinion card
              final color =
                  controller.memberOpinionList.indexOf(opinion) % 3 == 0
                      ? const Color(0xffFDEBB9)
                      : controller.memberOpinionList.indexOf(opinion) % 3 == 1
                          ? const Color(0xffD0D9FC)
                          : const Color(0xffD5D0FB);

              // Add a spacer for every second opinion
              final spacer =
                  controller.memberOpinionList.indexOf(opinion) % 2 == 1
                      ? const Spacer()
                      : null;

              return Column(
                children: [
                  buildMembersOpinion(
                    opinion.clubMemberName,
                    opinion.clubNameWithPosition,
                    opinion.clubOpinionDescription,
                    spacer,
                    color,
                  ),
                  const SizedBox(height: 15),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
