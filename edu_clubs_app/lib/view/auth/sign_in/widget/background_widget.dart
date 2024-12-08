import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/sign_in_logo_widget.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.child, this.check = false});
  final Widget child;
  final bool? check;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: SvgPicture.asset(
            AssetsPath.bgSvg,
            fit: BoxFit.cover,
          ),
        ),
        if (check!) SignInLogoWidget(),
        child,
      ],
    );
  }
}
