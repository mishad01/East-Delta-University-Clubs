import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/splash/widget/splash_screen_bg_widget.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenBgWidget(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Club Up!",
                    style: GoogleFonts.roboto(
                        fontSize: 55, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Find your dream club that fits your passion",
                    style: GoogleFonts.inter(fontSize: 23),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
