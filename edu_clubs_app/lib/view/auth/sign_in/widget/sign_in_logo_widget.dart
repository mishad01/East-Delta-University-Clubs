import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/positioned_widget.dart';

class SignInLogoWidget extends StatelessWidget {
  const SignInLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedWidget(
      top: 30,
      child: Container(
        alignment: Alignment.topCenter, // Aligns the image at the top
        child: SvgPicture.asset(
          AssetsPath.eduLogo,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
