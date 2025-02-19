import 'package:edu_clubs_app/utils/export.dart';

class CenteredAppLogo extends StatelessWidget {
  const CenteredAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        //Image.asset(AssetsPath.appLogo),
        SizedBox(height: 1.h),
      ],
    );
  }
}
