import 'package:edu_clubs_app/presentation/widgets/splash_screen_bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
