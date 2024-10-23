import 'package:edu_clubs_app/presentation/widgets/background_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formState = GlobalKey<FormState>();
  final TextEditingController _fullNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _studentTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();

  // FocusNodes for next option
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _studentFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BackgroundWidget(
        check: true,
        child: SafeArea(
          child: Form(
            key: _formState,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 190),
                  Center(
                    child: Container(
                      width: 317,
                      height: 510,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xffD0D9FC).withOpacity(0.20),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _fullNameTEController,
                            decoration:
                                const InputDecoration(hintText: "Full Name"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Full Name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _emailTEController,
                            decoration:
                                const InputDecoration(hintText: "Email"),
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
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _mobileTEController,
                            decoration: const InputDecoration(
                                hintText: "Mobile Number"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Mobile Number";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _studentTEController,
                            decoration:
                                const InputDecoration(hintText: "Student Id"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Student ID";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _passwordTEController,
                            decoration:
                                const InputDecoration(hintText: "Password"),
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
                          TextFormField(
                            controller: _confirmPasswordTEController,
                            decoration: const InputDecoration(
                                hintText: "Confirm Password"),
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
                        // Perform sign up action
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
