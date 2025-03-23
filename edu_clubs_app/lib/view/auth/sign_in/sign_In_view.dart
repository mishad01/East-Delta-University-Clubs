import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/custom_text_field.dart';
import 'package:edu_clubs_app/utils/email_and_password_validation.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/forget_password/forget_password_check_view.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/background_widget.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/positioned_widget.dart';
import 'package:edu_clubs_app/view_model/user/sign_in_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final SignInController _signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  _buildLogo(),
                  Flexible(child: _buildWelcomeText()),
                  _buildSubtitleText(),
                  _buildLoginForm(),
                  _buildLoginButton(),
                  _buildSignUpPrompt(textTheme),
                  // _buildForgetPassword(textTheme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return PositionedWidget(
      top: 1,
      child: Center(
        child: SvgPicture.asset(
          AssetsPath.eduLogo,
          height: 26.h,
          width: 29.8.w,
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return PositionedWidget(
      top: 20.h, // Adjusted top position for responsiveness
      child: SizedBox(
        height: 14.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "WELCOME BACK",
              fontSize: 25.sp,
              fontWeight: FontWeight.normal,
            ),
            Baseline(
              baseline: 8.h,
              baselineType: TextBaseline.alphabetic,
              child: CustomText(
                text: "!",
                fontWeight: FontWeight.bold,
                customStyle: GoogleFonts.gruppo(
                  fontSize: 40.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitleText() {
    return PositionedWidget(
      top: 30.h,
      child: Center(
        child: CustomText(
          text: "Please sign in to continue",
          fontSize: 15.sp,
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return PositionedWidget(
      top: 34.h,
      child: Container(
        height: 200, // Adjusted container height for responsiveness
        decoration: BoxDecoration(
          //color: Colors.yellow,
          color: const Color(0xffD0D9FC).withOpacity(0.20),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(2.0.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: "Email",
                  controller: _emailTEController,
                  validator: EmailAndPasswordValidation.validateEmail,
                  prefixIcon: Icons.email,
                ),
                SizedBox(height: 3.h),
                CustomTextFormField(
                  labelText: "Password",
                  controller: _passwordTEController,
                  obscureText: true,
                  validator: EmailAndPasswordValidation.validatePassword,
                  prefixIcon: Icons.lock,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return PositionedWidget(
      top: 58.h, // Adjusted for screen height responsiveness
      child: Center(
        child: GetBuilder<SignInController>(
          builder: (controller) {
            return SizedBox(
              width: 30.8.w, // Width is responsive to screen width
              height: 4.5.h, // Height is responsive to screen height
              child: ElevatedButton(
                onPressed:
                    controller.isLoading ? null : () => _onLoginPressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFDEBB9),
                  minimumSize: Size(30.w, 6.h),
                ),
                child: controller.isLoading
                    ? const CircularProgressIndicator()
                    : CustomText(
                        text: "Login",
                        fontSize: 18.sp, // Font size is responsive
                        fontWeight: FontWeight.bold,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSignUpPrompt(TextTheme textTheme) {
    return PositionedWidget(
      top: 64.h, // Adjusted for screen height responsiveness
      child: Center(
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                text: "Don't Have an account? ",
                style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp // Font size adjusted for responsiveness
                    ),
                children: [
                  TextSpan(
                    text: "Sign Up",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(() => SignUpView());
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h), // Responsive spacing
            InkWell(
              onTap: () {
                Get.to(() => ForgetPasswordCheckView());
              },
              child: Center(
                child: Text(
                  "Forgot Password?",
                  style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      _signInController.signIn(
        _emailTEController.text.trim(),
        _passwordTEController.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
