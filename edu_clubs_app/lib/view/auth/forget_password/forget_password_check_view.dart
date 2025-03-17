import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/custom_text_field.dart';
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
          height: 25.h,
          width: 60.w,
        ),
      ),
    );
  }

  Widget _buildTitleText() {
    return PositionedWidget(
      top: 23.h,
      child: Center(
        child: CustomTextForPdf(
          text: "Forgot Password?",
          customStyle: GoogleFonts.roboto(
            fontSize: 25.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitleText() {
    return PositionedWidget(
      top: 29.h,
      child: Center(
        child: CustomTextForPdf(
          text: "Enter your email to reset your password",
          fontSize: 15.sp,
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return PositionedWidget(
      top: 36.h,
      child: Container(
        width: 90.w,
        decoration: BoxDecoration(
          color: const Color(0xffD0D9FC).withOpacity(0.20),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomTextFormField(
            labelText: "Email",
            controller: _emailTEController,
            prefixIcon: Icons.email,
            showUnderline: false,
          ),
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return PositionedWidget(
      top: 50.h,
      child: Center(
        child: GetBuilder<ForgetPasswordController>(
          builder: (controller) {
            return SizedBox(
              width: 40.w,
              height: 6.h,
              child: ElevatedButton(
                onPressed:
                    controller.isLoading ? null : () => _onResetPressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFDEBB9),
                  minimumSize: Size(40.w, 6.h),
                ),
                child: controller.isLoading
                    ? const CircularProgressIndicator()
                    : CustomTextForPdf(
                        text: "Submit",
                        fontSize: 19.sp,
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
