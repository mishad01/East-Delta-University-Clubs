import 'package:edu_clubs_app/utils/custom_text_field.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/background_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BackgroundWidget(
        check: true,
        child: SafeArea(
          child: SingleChildScrollView(
            // Wrap this widget in a SingleChildScrollView
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 190),
                    Center(
                      child: Container(
                        width: double.infinity, // Make the container responsive
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Full Name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: _emailTEController,
                              labelText: "Email",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Input Correct Email";
                                }
                                String pattern =
                                    r'^[a-zA-Z0-9._%+-]+@[eastdelta\.edu\.bd]$';
                                RegExp regex = RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: _mobileTEController,
                              labelText: "Mobile Number",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Mobile Number";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              controller: _studentTEController,
                              labelText: "Student Id",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Student ID";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: _passwordTEController,
                              labelText: "Password",
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Password";
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters long';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: _confirmPasswordTEController,
                              labelText: "Confirm Password",
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Confirm Password";
                                }
                                if (value != _passwordTEController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formState.currentState!.validate()) {
                          Get.to(() => OtpView());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFDEBB9),
                        minimumSize: const Size(108, 40),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
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
