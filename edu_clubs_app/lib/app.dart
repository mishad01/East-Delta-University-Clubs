import 'package:edu_clubs_app/presentation/ui/screens/auth_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EduClubs extends StatelessWidget {
  const EduClubs({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: _themeData(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
      ],
    );
  }

  ThemeData _themeData() {
    return ThemeData(
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        bodySmall: GoogleFonts.roboto(color: Colors.black),
        bodyLarge: GoogleFonts.roboto(color: Colors.black),
        titleSmall: GoogleFonts.roboto(color: Colors.black),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.roboto(color: Colors.grey, fontSize: 15),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 0.9),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
