import 'package:edu_clubs_app/view/auth/forget_password/forget_password_check_view.dart';
import 'package:edu_clubs_app/view/auth/forget_password/forget_password_new_password.dart';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgetPasswordRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'devcode://password-reset',
      );
      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updatePassword(String newPassword) async {
    await _supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  void configDeepLink() {
    final appLinks = AppLinks(); // AppLinks is singleton

    appLinks.uriLinkStream.listen((uri) {
      print("Received deep link: $uri"); // Debug line
      if (uri.host == 'password-reset') {
        // Navigate to the reset password screen
        Get.offAll(() => ForgetPasswordNewPasswordView());
      }
    });
  }
}
