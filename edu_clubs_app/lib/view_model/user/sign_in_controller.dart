import 'package:edu_clubs_app/view/auth/sign_in/sign_In_view.dart';
import 'package:edu_clubs_app/view/home/home_view.dart';
import 'package:edu_clubs_app/view_model/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInController extends GetxController {
  bool isLoading = false;
  String errorMessage = '';

  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> signIn(String email, String password) async {
    isLoading = true;
    errorMessage = '';
    update();

    try {
      print('Attempting to sign in with email: $email');
      final AuthResponse response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        print('User authenticated successfully');
        Get.offAll(() => HomeView());
      } else {
        errorMessage = 'Invalid email or password';
        print(errorMessage);
        Get.snackbar('Error', errorMessage,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      errorMessage = 'Sign-in failed: ${e.toString()}';
      print(errorMessage);
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // Add sign-out functionality
  Future<void> signOut() async {
    isLoading = true;
    errorMessage = '';
    update();

    try {
      print('Attempting to sign out');
      await supabase.auth.signOut();
      print('User signed out successfully');
      Get.offAll(() => SignInView()); // Replace with your sign-in screen widget
    } catch (e) {
      errorMessage = 'Sign-out failed: ${e.toString()}';
      print(errorMessage);
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
