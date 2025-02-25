import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/custom_text_field.dart';
import 'package:edu_clubs_app/utils/email_and_password_validation.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/background_widget.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/positioned_widget.dart';
import 'package:edu_clubs_app/view_model/user/forget_password_controller.dart';

class ForgetPasswordNewPasswordView extends StatefulWidget {
  const ForgetPasswordNewPasswordView({super.key});

  @override
  State<ForgetPasswordNewPasswordView> createState() =>
      _ForgetPasswordNewPasswordViewState();
}

class _ForgetPasswordNewPasswordViewState
    extends State<ForgetPasswordNewPasswordView> {
  final TextEditingController _newPasswordTEController =
      TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
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
                  _buildNewPasswordInput(),
                  _buildConfirmPasswordInput(),
                  _buildUpdateButton(),
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
          text: "Update Password",
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
          text: "Enter your new password",
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildNewPasswordInput() {
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
            labelText: "New Password",
            controller: _newPasswordTEController,
            obscureText: true,
            validator: (value) =>
                EmailAndPasswordValidation.validatePassword(value),
            prefixIcon: Icons.lock,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordInput() {
    return PositionedWidget(
      top: 350,
      child: Container(
        width: 352,
        decoration: BoxDecoration(
          color: const Color(0xffD0D9FC).withOpacity(0.20),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomTextFormField(
            labelText: "Confirm Password",
            controller: _confirmPasswordTEController,
            obscureText: true,
            validator: (value) {
              if (value != _newPasswordTEController.text) {
                return "Passwords do not match";
              }
              return null;
            },
            prefixIcon: Icons.lock,
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateButton() {
    return PositionedWidget(
      top: 420,
      child: Center(
        child: GetBuilder<ForgetPasswordController>(
          builder: (controller) {
            return SizedBox(
              width: 140,
              height: 45,
              child: ElevatedButton(
                onPressed:
                    controller.isLoading ? null : () => _onUpdatePressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFDEBB9),
                  minimumSize: const Size(140, 45),
                ),
                child: controller.isLoading
                    ? const CircularProgressIndicator()
                    : const CustomText(
                        text: "Update",
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

  void _onUpdatePressed() {
    if (_formKey.currentState!.validate()) {
      _forgetPasswordController.updatePassword(
        _newPasswordTEController.text,
      );
    }
  }

  @override
  void dispose() {
    _newPasswordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
