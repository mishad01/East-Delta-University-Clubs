import 'package:edu_clubs_app/utils/export.dart';

class SplashScreenBgWidget extends StatefulWidget {
  const SplashScreenBgWidget({super.key, required this.child});
  final Widget child;

  @override
  State<SplashScreenBgWidget> createState() => _SplashScreenBgWidgetState();
}

class _SplashScreenBgWidgetState extends State<SplashScreenBgWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    // Define the scaling animation
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      Get.offAll(() => SignInView());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        ScaleTransition(
          scale: _animation,
          child: widget.child,
        ),
      ],
    );
  }
}