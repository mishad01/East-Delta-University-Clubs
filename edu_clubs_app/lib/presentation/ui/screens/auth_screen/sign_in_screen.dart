import 'package:edu_clubs_app/presentation/ui/screens/auth_screen/sign_up_screen.dart';
import 'package:edu_clubs_app/presentation/utility/assets_path.dart';
import 'package:edu_clubs_app/presentation/widgets/background_widget.dart';
import 'package:edu_clubs_app/presentation/widgets/positioned_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formState,
              child: Stack(
                children: [
                  Stack(
                    children: [
                      PositionedWidget(
                        top: 1,
                        child: Center(
                          child: SvgPicture.asset(
                            AssetsPath.eduLogo,
                            height: 241,
                            width: 288,
                          ),
                        ),
                      ),
                      PositionedWidget(
                          top: 180,
                          child: Container(
                            //color: Colors.yellow,
                            height: 140,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "WELCOME BACK",
                                  style: GoogleFonts.roboto(fontSize: 38),
                                ),
                                Baseline(
                                  baseline: 80,
                                  baselineType: TextBaseline.alphabetic,
                                  child: Text(
                                    "!",
                                    style: GoogleFonts.gruppo(
                                      fontSize: 120,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      PositionedWidget(
                        top: 280,
                        child: Center(
                          child: Text(
                            "Please sign in to continue",
                            style: GoogleFonts.roboto(fontSize: 15),
                          ),
                        ),
                      ),
                      PositionedWidget(
                        top: 320,
                        child: Container(
                          width: 352,
                          height: 220,
                          decoration: BoxDecoration(
                            color: const Color(0xffD0D9FC).withOpacity(0.20),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: _emailTEController,
                                    decoration:
                                        InputDecoration(hintText: "Email"),
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
                                  SizedBox(height: 30),
                                  TextFormField(
                                    controller: _passwordTEController,
                                    decoration: const InputDecoration(
                                        hintText: "Password"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Input Correct Email";
                                      }
                                      if (value.length < 8) {
                                        return 'Password must be at least 8 characters long';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      PositionedWidget(
                        top: 535,
                        child: Center(
                          // Center aligns the button within the available space
                          child: Container(
                            width: 108,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formState.currentState!.validate()) {}
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFDEBB9),
                                  minimumSize: Size(108, 50)),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      PositionedWidget(
                        top: 590,
                        child: Center(
                          // Center aligns the button within the available space
                          child: RichText(
                            text: TextSpan(
                              text: "Don't Have an account? ",
                              style: textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => SignUpScreen());
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
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
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
