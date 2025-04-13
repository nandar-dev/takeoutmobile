import 'package:flutter/material.dart';
import 'package:takeout/pages/auth/forgotpass_page.dart';
import 'package:takeout/pages/auth/signup_page.dart';
import 'package:takeout/pages/home/home_page.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          const TitleText(text: "Login to your account."),
                          const SizedBox(height: 8),
                          const SubText(text: "Please sign in to your account"),
                          const SizedBox(height: 32),
                          CustomTextField(
                            label: "Email Address",
                            hint: "Enter Email",
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 14),

                          CustomTextField(
                            label: "Password",
                            hint: "Enter Password",
                            obscureText: true,
                            suffixIcon: Icon(Icons.visibility_off),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                overlayColor: Colors.transparent,
                              ),
                              onPressed:
                                  () => _showForgotPasswordSheet(context),
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: FontSizes.body,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                              text: "Sign In",
                              onPressed:
                                  () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    ),
                                  },
                            ),
                          ),

                          const SizedBox(height: 24),

                          Row(
                            children: const [
                              Expanded(child: Divider(thickness: 1)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Or sign in with',
                                  style: TextStyle(fontSize: FontSizes.body),
                                ),
                              ),
                              Expanded(child: Divider(thickness: 1)),
                            ],
                          ),

                          const SizedBox(height: 24),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _socialIcon('assets/icons/google.png'),
                              const SizedBox(width: 16),
                              _socialIcon('assets/icons/facebook.png'),
                              const SizedBox(width: 16),
                              _socialIcon('assets/icons/apple.png'),
                            ],
                          ),

                          SizedBox(height: 32),

                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: const TextStyle(
                                  color: AppColors.neutral100,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Register',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => SignupPage(),
                                              ),
                                            );
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Image.asset(assetPath, height: 40, width: 40),
    );
  }

  void _showForgotPasswordSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: AppColors.neutral10,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              children: [
                const TitleText(
                  text: "Forgot password?",
                  fontSize: FontSizes.heading2,
                ),
                const SizedBox(height: 8),
                const SubText(
                  text:
                      "Create an account to start looking for the food you like",
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                  text: "Continue",
                  onPressed:
                      () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassPage(),
                          ),
                        ),
                      },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
