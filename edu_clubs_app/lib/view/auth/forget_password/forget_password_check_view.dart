import 'package:app_links/app_links.dart';
import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/custom_text_field.dart';
import 'package:edu_clubs_app/utils/email_and_password_validation.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/background_widget.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/positioned_widget.dart';
import 'package:edu_clubs_app/view_model/user/forget_password_controller.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgetPasswordCheckView extends StatefulWidget {
  const ForgetPasswordCheckView({super.key});

  @override
  State<ForgetPasswordCheckView> createState() =>
      _ForgetPasswordCheckViewState();
}

class _ForgetPasswordCheckViewState extends State<ForgetPasswordCheckView> {
  final TextEditingController _emailTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ForgetPasswordController _forgetPasswordController =
      Get.put(ForgetPasswordController());

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
                  _buildTitleText(),
                  _buildSubtitleText(),
                  _buildEmailInput(),
                  _buildResetButton(),
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
          height: 200,
          width: 250,
        ),
      ),
    );
  }

  Widget _buildTitleText() {
    return PositionedWidget(
      top: 170,
      child: const Center(
        child: CustomText(
          text: "Forgot Password?",
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSubtitleText() {
    return PositionedWidget(
      top: 220,
      child: const Center(
        child: CustomText(
          text: "Enter your email to reset your password",
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return PositionedWidget(
      top: 280,
      child: Container(
        width: 352,
        decoration: BoxDecoration(
          color: const Color(0xffD0D9FC).withOpacity(0.20),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomTextFormField(
            labelText: "Email",
            controller: _emailTEController,
            //validator: EmailAndPasswordValidation.validateEmail,
            prefixIcon: Icons.email,
          ),
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return PositionedWidget(
      top: 380,
      child: Center(
        child: GetBuilder<ForgetPasswordController>(
          builder: (controller) {
            return SizedBox(
              width: 140,
              height: 45,
              child: ElevatedButton(
                onPressed:
                    controller.isLoading ? null : () => _onResetPressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFDEBB9),
                  minimumSize: const Size(140, 45),
                ),
                child: controller.isLoading
                    ? const CircularProgressIndicator()
                    : const CustomText(
                        text: "Submit",
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

  void _onResetPressed() {
    if (_formKey.currentState!.validate()) {
      _forgetPasswordController.resetPassword(
        _emailTEController.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
