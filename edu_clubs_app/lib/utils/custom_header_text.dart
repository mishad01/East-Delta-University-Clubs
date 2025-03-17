import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/export.dart';

class CustomHeaderText extends StatelessWidget {
  const CustomHeaderText({
    super.key,
    required this.text1,
    required this.text2,
  });
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextForPdf(
            text: text1,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          CustomTextForPdf(
            text: text2,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            //color: AppColors.blackGray,
          ),
        ],
      ),
    );
  }
}
