import 'package:edu_clubs_app/data/repositories/sign_up_repository.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/data/models/user_model.dart';

class SignUpController extends GetxController {
  final SignUpRepository _authRepository = SignUpRepository();

  UserModel? userModel;
  bool isLoading = false;
  String? errorMessage;

  Future<void> signUp({
    required String fullName,
    required String email,
    required String mobile,
    required String studentId,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;
    update(); // Notify UI

    // Check if the email is already registered
    final isEmailExist = await _authRepository.checkIfEmailExists(email);
    if (isEmailExist) {
      errorMessage = "This email is already registered.";
      isLoading = false;
      update();
      return;
    }

    final user = await _authRepository.signUp(
      fullName: fullName,
      email: email,
      mobile: mobile,
      studentId: studentId,
      password: password,
    );

    if (user != null) {
      userModel = user;
      Get.to(() => OtpView());
    } else {
      errorMessage = "Signup failed. Please try again.";
    }

    isLoading = false;
    update();
  }

  Future<void> fetchUserInfo() async {
    isLoading = true;
    update();

    userModel = await _authRepository.fetchUserInfo();

    if (userModel == null) {
      errorMessage = "Failed to fetch user data.";
    }

    isLoading = false;
    update();
  }
}
