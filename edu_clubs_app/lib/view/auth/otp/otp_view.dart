import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/sign_in/sign_In_view.dart';
import 'package:edu_clubs_app/view/auth/sign_in/widget/background_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final TextEditingController otpTEController = TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BackgroundWidget(
        check: true,
        child: SafeArea(
          child: Form(
            key: _formState,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Verify Your Email",
                      style: GoogleFonts.roboto(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      "We've sent a confirmation code to your email. Please enter the code below to verify your account.",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => SignInView());
                    },
                    style: OutlinedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: const Color(0xffFDEBB6),
                      minimumSize: const Size(108, 40),
                    ),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
