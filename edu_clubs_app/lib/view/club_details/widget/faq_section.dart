import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edu_clubs_app/view_model/club_faq/club_faq_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart'; // Import the controller

class FAQSection extends StatelessWidget {
  const FAQSection({
    super.key,
    required this.clubDetailsId,
  });
  final String clubDetailsId;

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final ClubFAQController controller = Get.put(ClubFAQController());

    // Fetch FAQs when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchFAQs(clubDetailsId);
    });

    return GetBuilder<ClubFAQController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage != null) {
          return Center(child: Text(controller.errorMessage!));
        }

        if (controller.allFAQ.isEmpty) {
          return const Center(child: Text("No FAQs found."));
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.allFAQ.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final faq = controller.allFAQ[index];
            return FAQCard(
              question: faq['question'],
              answer: faq['answer'],
            );
          },
        );
      },
    );
  }
}

class FAQCard extends StatelessWidget {
  final String question;
  final String answer;

  const FAQCard({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blue,
      color: const Color(0xffD2D8D4),
      child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            trailing: const Icon(Icons.more_vert_rounded),
            expandedCrossAxisAlignment: CrossAxisAlignment.end,
            //childrenPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            title: CustomText(
              text: question,
              customStyle: GoogleFonts.roboto(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: Color(0xffcdd3ce),
                child: CustomText(
                  text: answer,
                  customStyle: GoogleFonts.roboto(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
