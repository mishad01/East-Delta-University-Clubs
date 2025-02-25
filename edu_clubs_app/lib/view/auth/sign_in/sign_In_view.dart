import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/custom_text_field.dart';
import 'package:edu_clubs_app/utils/email_and_password_validation.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/forget_password/forget_password_check_view.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/background_widget.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/positioned_widget.dart';
import 'package:edu_clubs_app/view_model/user/sign_in_controller.dart';
import 'package:get/get.dart';

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
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  _buildLogo(),
                  _buildWelcomeText(),
                  _buildSubtitleText(),
                  _buildLoginForm(),
                  _buildLoginButton(),
                  _buildSignUpPrompt(textTheme),
                  _buildForgetPassword(textTheme),
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
          height: 241,
          width: 288,
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return PositionedWidget(
      top: 180,
      child: SizedBox(
        height: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
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
    );
  }

  Widget _buildSubtitleText() {
    return PositionedWidget(
      top: 280,
      child: const Center(
        child: CustomText(
          text: "Please sign in to continue",
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return PositionedWidget(
      top: 320,
      child: Container(
        width: 352,
        height: 220,
        decoration: BoxDecoration(
          color: const Color(0xffD0D9FC).withOpacity(0.20),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: "Email",
                  controller: _emailTEController,
                  validator: EmailAndPasswordValidation.validateEmail,
                  prefixIcon: Icons.email,
                ),
                const SizedBox(height: 30),
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
      top: 535,
      child: Center(
        child: GetBuilder<SignInController>(
          builder: (controller) {
            return SizedBox(
              width: 108,
              height: 40,
              child: ElevatedButton(
                onPressed:
                    controller.isLoading ? null : () => _onLoginPressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFDEBB9),
                  minimumSize: const Size(108, 50),
                ),
                child: controller.isLoading
                    ? const CircularProgressIndicator()
                    : const CustomText(
                        text: "Login",
                        fontSize: 19,
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
                style: const TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.to(() => SignUpView());
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgetPassword(TextTheme textTheme) {
    return PositionedWidget(
      left: 0,
      right: 0,
      bottom: 160,
      child: InkWell(
        onTap: () {
          Get.to(() => ForgetPasswordCheckView());
        },
        child: Center(
          child: Text(
            "Forgot Password?",
            style: textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
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
