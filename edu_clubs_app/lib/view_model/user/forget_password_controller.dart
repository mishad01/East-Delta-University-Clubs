import 'package:edu_clubs_app/data/repositories/auth/forget_password_repository.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final ForgetPasswordRepository _authRepository = ForgetPasswordRepository();

  bool isLoading = false;
  String errorMessage = '';

  @override
  void onInit() {
    super.onInit();
    configureDeepLink();
  }

  void configureDeepLink() {
    _authRepository.configDeepLink();
  }

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      errorMessage = "Email can't be empty";
      update();
      return;
    }

    isLoading = true;
    errorMessage = '';
    update();

    try {
      bool success = await _authRepository.sendPasswordResetEmail(email);
      if (success) {
        Get.snackbar("Success", "Password reset email sent.");
      }
    } catch (e) {
      errorMessage = e.toString();
      Get.snackbar("Error", errorMessage);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      await _authRepository.updatePassword(newPassword);
      Get.snackbar("Success", "Password updated successfully.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
