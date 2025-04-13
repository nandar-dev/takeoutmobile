import 'package:flutter/material.dart';
import 'package:takeout/pages/auth/forgotpass_page.dart';
import 'package:takeout/pages/auth/resetpass_page.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/appbar_wdget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "OTP",
          onBackTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPassPage()),
            );
          },
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleText(text: "Email verification"),
                  const SizedBox(height: 8),
                  const SubText(
                    text:
                        "Enter the verification code we send you on: customer******@gmail.com",
                  ),
                  const SizedBox(height: 32),

                  _otpBox(),
                  const SizedBox(height: 16),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Didn’t receive code? ",
                        style: const TextStyle(color: AppColors.textSecondary),
                        children: [
                          TextSpan(
                            text: 'Resend',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 44),

                  Center(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        overlayColor: Colors.transparent,
                      ),
                      onPressed: null,
                      icon: Icon(Icons.access_time_rounded, size: 20),
                      label: Text(
                        "09.00",
                        style: TextStyle(fontSize: FontSizes.body),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      text: "Continue",
                      onPressed:
                          () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetpassPage(),
                              ),
                            ),
                          },
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _otpBox() {
  final defaultPinTheme = PinTheme(
    width: 75,
    height: 75,
    margin: EdgeInsets.all(5),
    textStyle: TextStyle(
      fontSize: FontSizes.heading1,
      color: AppColors.neutral100,
      fontWeight: FontWeight.w500,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.textfieldborder),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: AppColors.primary),
  );
  return Align(
    alignment: Alignment.center,
    child: Pinput(
      // keyboardType: TextInputType.number,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      validator: (s) {
        return s == '2222' ? null : 'Pin is incorrect';
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => debugPrint(pin),
    ),
  );
}
