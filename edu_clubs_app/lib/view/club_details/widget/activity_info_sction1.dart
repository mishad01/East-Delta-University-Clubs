// Extracted widget for the button and text block
import 'package:edu_clubs_app/resources/app_colors.dart';
import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/web/web_view.dart';

class ActivityInfoSection1 extends StatelessWidget {
  final String title;
  final String description;
  final String link;
  final bool isUpcoming;

  const ActivityInfoSection1({
    required this.title,
    required this.description,
    required this.link,
    this.isUpcoming = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: title,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
        CustomText(
          text: description,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),
        ElevatedButton(
          onPressed: () {
            Get.to(() => WebView(link: link));
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(120, 25),
            backgroundColor: AppColors.themeColor3,
          ),
          child: const Text(
            "Click Here",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (isUpcoming) SizedBox(height: 1.h),
      ],
    );
  }
}
