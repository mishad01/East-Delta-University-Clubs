import 'package:edu_clubs_app/view_model/user/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  // Check if the email already exists in the database
  Future<bool> checkIfEmailExists(String email) async {
    try {
      final response = await supabase
          .from('user')
          .select()
          .eq('email_address', email.trim())
          .single();

      // If the response is not empty, the email exists
      return response != null;
    } catch (e) {
      // In case of error (e.g., network issue), return false
      return false;
    }
  }

  Future<UserModel?> signUp({
    required String fullName,
    required String email,
    required String mobile,
    required String studentId,
    required String password,
  }) async {
    try {
      // Check if the email already exists
      final isEmailExist = await checkIfEmailExists(email);
      if (isEmailExist) {
        return null; // Email already in use, so return null
      }

      // Proceed with the sign-up if email is unique
      final authResponse = await supabase.auth.signUp(
        email: email.trim(),
        password: password,
      );

      if (authResponse.user == null) {
        return null;
      }

      final newUser = UserModel(
        id: authResponse.user!.id,
        fullName: fullName.trim(),
        emailAddress: email.trim(),
        mobile: int.parse(mobile),
        studentId: int.parse(studentId.trim()),
        password: password,
        memberType: "student",
      );

      final response =
          await supabase.from('user').insert(newUser.toMap()).select();

      if (response.isEmpty) {
        return null;
      }

      return newUser;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> fetchUserInfo() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return null;

      final response =
          await supabase.from('user').select().eq('id', user.id).single();

      return UserModel.fromMap(response);
    } catch (e) {
      return null;
    }
  }
}
