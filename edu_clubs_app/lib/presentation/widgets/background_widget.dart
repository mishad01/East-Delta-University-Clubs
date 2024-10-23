import 'package:edu_clubs_app/presentation/utility/assets_path.dart';
import 'package:edu_clubs_app/presentation/widgets/sign_in_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
