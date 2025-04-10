import 'package:flutter/material.dart';
import 'package:takeout/pages/auth/otp_page.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ForgotPassPage extends StatelessWidget {
  const ForgotPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  const TitleText(text: "Forgot password?"),
                  const SizedBox(height: 8),
                  const SubText(
                    text:
                        "Enter your email address and we’ll send you confirmation code to reset your password",
                  ),
                  const SizedBox(height: 32),

                  CustomTextField(
                    label: "Email Address",
                    hint: "Enter Email",
                    keyboardType: TextInputType.visiblePassword,
                  ),

                  const SizedBox(height: 30),

                  PrimaryButton(
                    text: "Continue",
                    onPressed:
                        () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OtpPage()),
                          ),
                        },
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
