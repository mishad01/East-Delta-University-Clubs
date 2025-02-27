import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/custom_text_field.dart';
import 'package:edu_clubs_app/utils/email_and_password_validation.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/background_widget.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/positioned_widget.dart';
import 'package:edu_clubs_app/view_model/user/forget_password_controller.dart';
import 'package:sizer/sizer.dart'; // Import Sizer

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
            padding: EdgeInsets.all(4.w), // Use Sizer for padding
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  _buildLogo(),
                  _buildTitleText(),
                  _buildSubtitleText(),
                  _buildNewPasswordInput(),
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
      top: 1.h, // Use Sizer for position
      child: Center(
        child: SvgPicture.asset(
          AssetsPath.eduLogo,
          height: 20.h, // Use Sizer for height
          width: 50.w, // Use Sizer for width
        ),
      ),
    );
  }

  Widget _buildTitleText() {
    return PositionedWidget(
      top: 20.h,
      child: Center(
        child: CustomText(
          text: "Update Password",
          customStyle: GoogleFonts.roboto(
            fontSize: 22.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitleText() {
    return PositionedWidget(
      top: 25.h, // Use Sizer for position
      child: Center(
        child: CustomText(
          text: "Enter your new password",
          fontSize: 1.5.h, // Use Sizer for font size
        ),
      ),
    );
  }

  Widget _buildNewPasswordInput() {
    return PositionedWidget(
      top: 30.h, // Use Sizer for position
      child: Column(
        children: [
          _buildPasswordField(
            controller: _newPasswordTEController,
            labelText: "New Password",
            validator: EmailAndPasswordValidation.validatePassword,
          ),
          _buildPasswordField(
            controller: _confirmPasswordTEController,
            labelText: "Confirm Password",
            validator: (value) {
              if (value != _newPasswordTEController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
  }) {
    return Container(
      width: 88.w, // Use Sizer for width
      decoration: BoxDecoration(
        color: const Color(0xffD0D9FC).withOpacity(0.20),
        borderRadius: BorderRadius.circular(2.w), // Use Sizer for border radius
      ),
      child: Padding(
        padding: EdgeInsets.all(2.w), // Use Sizer for padding
        child: CustomTextFormField(
          labelText: labelText,
          controller: controller,
          obscureText: true,
          validator: validator,
          prefixIcon: Icons.lock,
        ),
      ),
    );
  }

  Widget _buildUpdateButton() {
    return PositionedWidget(
      top: 48.h, // Use Sizer for position
      child: Center(
        child: GetBuilder<ForgetPasswordController>(
          builder: (controller) {
            return SizedBox(
              width: 40.w,
              height: 5.5.h,
              child: ElevatedButton(
                onPressed:
                    controller.isLoading ? null : () => _onUpdatePressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFDEBB9),
                ),
                child: controller.isLoading
                    ? const CircularProgressIndicator()
                    : CustomText(
                        text: "Update",
                        fontSize: 19.sp, // Use Sizer for font size
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
