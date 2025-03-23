import 'package:edu_clubs_app/resources/app_colors.dart';
import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/export.dart';

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
      controller.fetchClubFAQs(clubDetailsId);
    });

    return GetBuilder<ClubFAQController>(
      builder: (controller) {
        if (controller.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage != null) {
          return Center(child: Text(controller.errorMessage!));
        }

        if (controller.clubFAQs.isEmpty) {
          return const Center(child: Text("No FAQs found."));
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: Colors.grey.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.clubFAQs.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final faq = controller.clubFAQs[index];
                return FAQCard(
                  question: faq.question,
                  answer: faq.answer,
                );
              },
            ),
          ),
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
            trailing: const Icon(Icons.more_horiz_outlined, size: 40),
            expandedCrossAxisAlignment: CrossAxisAlignment.end,
            //childrenPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AssetsPath.faqIcon),
                SizedBox(width: 1.w),
                Flexible(
                  child: Container(
                    height: 50,
                    width: 260,
                    child: CustomText(
                      text: question,
                      customStyle: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: CustomText(
                    text: answer,
                    customStyle: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
