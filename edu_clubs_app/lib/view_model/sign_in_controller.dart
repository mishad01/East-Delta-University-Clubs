import 'package:edu_clubs_app/data/models/auth/auth_repository.dart';
import 'package:edu_clubs_app/view/auth/sign_in/sign_In_view.dart';
import 'package:edu_clubs_app/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      print('Attempting to sign in with email: $email');
      final response = await _authRepository.signIn(email, password);

      if (response.user != null) {
        print('User authenticated successfully');
        Get.offAll(() => HomeView());
      } else {
        errorMessage.value = 'Invalid email or password';
        Get.snackbar('Error', errorMessage.value,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      errorMessage.value = 'Sign-in failed: ${e.toString()}';
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      print('Attempting to sign out');
      await _authRepository.signOut();
      print('User signed out successfully');
      Get.offAll(() => SignInView());
    } catch (e) {
      errorMessage.value = 'Sign-out failed: ${e.toString()}';
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
