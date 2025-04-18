import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/sign_in/sign_In_view.dart';
import 'package:edu_clubs_app/view/home/home_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

    final user = Supabase.instance.client.auth.currentUser;

    if (mounted) {
      // Check if the user is already logged in
      if (user != null) {
        // If the user is logged in, navigate to the HomeView
        Get.offAll(() => HomeView());
      } else {
        // If the user is not logged in, navigate to the SignInView
        Get.offAll(() => SignInView());
      }
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
