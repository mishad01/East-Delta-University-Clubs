import 'package:edu_clubs_app/presentation/utility/assets_path.dart';
import 'package:edu_clubs_app/presentation/widgets/positioned_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
