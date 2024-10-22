import 'package:edu_clubs_app/presentation/ui/screens/auth_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EduClubs extends StatelessWidget {
  const EduClubs({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: SignInScreen(),
    );
  }
}
