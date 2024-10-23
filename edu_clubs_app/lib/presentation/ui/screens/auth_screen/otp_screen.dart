import 'package:edu_clubs_app/presentation/widgets/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 190),
                  Center(
                    child: Text(
                      "Enter OTP Code",
                      style: GoogleFonts.roboto(fontSize: 38),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "A 4 digit OTP code has been sent to you",
                      style: GoogleFonts.roboto(
                          fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 30),
                  PinCodeTextField(
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    appContext: context,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 48,
                      fieldWidth: 66,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedColor: Colors.white,
                      inactiveColor: Colors.grey,
                      activeColor: Colors.green,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: otpTEController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formState.currentState!.validate()) {
                        // Perform sign up action
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: const Color(0xffFDEBB6),
                      minimumSize: const Size(108, 40),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      text: "Didn't receive code? ",
                      style: textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                      children: const [
                        TextSpan(
                          text: "Resend",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
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
}
