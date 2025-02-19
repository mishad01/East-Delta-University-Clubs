import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/custom_text_field.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/background_widget.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/positioned_widget.dart';
import 'package:edu_clubs_app/view/home/home_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
                      height: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "WELCOME BACK",
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                          Baseline(
                            baseline: 80,
                            baselineType: TextBaseline.alphabetic,
                            child: CustomText(
                              text: "!",
                              fontSize: 120,
                              fontWeight: FontWeight.bold,
                              customStyle: GoogleFonts.gruppo(
                                fontSize: 120,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  PositionedWidget(
                    top: 280,
                    child: Center(
                      child: CustomText(
                        text: "Please sign in to continue",
                        fontSize: 15,
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
                              CustomTextFormField(
                                labelText: "Email",
                                controller: _emailTEController,
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
                                prefixIcon: Icons.email,
                              ),
                              SizedBox(height: 30),
                              CustomTextFormField(
                                labelText: "Password",
                                controller: _passwordTEController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Input Correct Password";
                                  }
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters long';
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.lock,
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
                      child: Container(
                        width: 108,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formState.currentState!.validate()) {
                              //Get.to(() => HomeView());
                            }
                            Get.to(() => HomeView());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFDEBB9),
                              minimumSize: Size(108, 50)),
                          child: CustomText(
                            text: "Login",
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  PositionedWidget(
                    top: 590,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't Have an account? ",
                          style: textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => SignUpView());
                                },
                            ),
                          ],
                        ),
                      ),
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
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
