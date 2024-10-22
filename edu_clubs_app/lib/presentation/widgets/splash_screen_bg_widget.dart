import 'package:edu_clubs_app/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreenBgWidget extends StatelessWidget {
  const SplashScreenBgWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: SvgPicture.asset(
            AssetsPath.splashBgSvg,
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
