import 'package:edu_clubs_app/utils/custom_text_field.dart';
import 'package:edu_clubs_app/utils/email_and_password_validation.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/background_widget.dart';
import 'package:edu_clubs_app/view_model/user/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  final SignUpController authController = Get.put(SignUpController());

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
                                validator:
                                    EmailAndPasswordValidation.validateEmail),
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
                    GetBuilder<SignUpController>(
                      builder: (controller) {
                        return ElevatedButton(
                          onPressed: controller.isLoading
                              ? null
                              : () {
                                  if (_formState.currentState!.validate()) {
                                    controller.signUp(
                                      fullName: _fullNameTEController.text,
                                      email: _emailTEController.text,
                                      mobile: _mobileTEController.text,
                                      studentId: _studentTEController.text,
                                      password: _passwordTEController.text,
                                    );
                                  }
                                },
                          child: controller.isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Sign Up"),
                        );
                      },
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
}
