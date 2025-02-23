import 'package:edu_clubs_app/utils/custom_text_field.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/background_widget.dart';
import 'package:edu_clubs_app/view_model/user/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formState = GlobalKey<FormState>();
  final TextEditingController _fullNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _studentTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();

  final SupabaseClient supabase =
      Supabase.instance.client; // Initialize Supabase

  Future<void> _signUp() async {
    if (!_formState.currentState!.validate()) return;

    try {
      // Sign up with Supabase Auth
      final authResponse = await supabase.auth.signUp(
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text.trim(),
      );

      if (authResponse.user != null) {
        // Create user model
        final newUser = UserModel(
          id: authResponse.user!.id,
          fullName: _fullNameTEController.text.trim(),
          emailAddress: _emailTEController.text.trim(),
          mobile: int.parse(_mobileTEController.text),
          studentId: int.parse(_studentTEController.text.trim()),
          password: _passwordTEController.text,
          memberType: "student", // Default member type
        );

        // Insert user data into the database and handle errors properly
        final response =
            await supabase.from('user').insert(newUser.toMap()).select();

        // Ensure response is not empty (insert was successful)
        if (response.isEmpty) {
          Get.snackbar("Error", "Failed to save user data.");
          return;
        }

        Get.to(() => OtpView()); // Navigate to OTP Verification
      }
    } catch (e) {
      Get.snackbar("Signup Failed", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BackgroundWidget(
        check: true,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 190),
                    Center(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffD0D9FC).withOpacity(0.20),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            CustomTextFormField(
                              controller: _fullNameTEController,
                              labelText: "Full Name",
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "Please Enter Full Name"
                                      : null,
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: _emailTEController,
                              labelText: "Email",
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Please Input Correct Email";
                                String pattern =
                                    r'^[a-zA-Z0-9._%+-]+@eastdelta\.edu\.bd$';
                                if (!RegExp(pattern).hasMatch(value))
                                  return 'Please enter a valid email address';
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: _mobileTEController,
                              labelText: "Mobile Number",
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "Please Enter Mobile Number"
                                      : null,
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: _studentTEController,
                              labelText: "Student Id",
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "Please Enter Student ID"
                                      : null,
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: _passwordTEController,
                              labelText: "Password",
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Please Enter Password";
                                if (value.length < 8)
                                  return 'Password must be at least 8 characters long';
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: _confirmPasswordTEController,
                              labelText: "Confirm Password",
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Please Confirm Password";
                                if (value != _passwordTEController.text)
                                  return 'Passwords do not match';
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFDEBB9),
                        minimumSize: const Size(108, 40),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 17),
                        children: const [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameTEController.dispose();
    _emailTEController.dispose();
    _mobileTEController.dispose();
    _studentTEController.dispose();
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
