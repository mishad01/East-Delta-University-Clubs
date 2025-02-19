import 'package:edu_clubs_app/utils/export.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Icon(icon),
                //HorizontalSpacing(3.w),
                Text(title),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.arrow_forward_ios),
            ],
          )
        ],
      ),
    );
  }
}
