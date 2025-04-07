import 'package:flutter/material.dart';
import 'package:takeout/pages/auth/login_page.dart';
import 'package:takeout/utils/colors.dart';
import 'package:takeout/widgets/customtextfield.dart';
import 'package:flutter/gestures.dart';
import 'package:takeout/widgets/primarybutton.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isAgreetoTerms = false;
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
                          const Text(
                            'Create your new account',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Create an account to start looking for the food you like',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                          ),
                          const SizedBox(height: 32),

                          CustomTextField(
                            label: "Email Address",
                            hint: "Enter Email",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),

                          CustomTextField(
                            label: "User Name",
                            hint: "Enter User Name",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),

                          CustomTextField(
                            label: "Password",
                            hint: "Enter Password",
                            obscureText: true,
                            suffixIcon: Icon(Icons.visibility_off),
                          ),

                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: Checkbox(
                                  value: isAgreetoTerms,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAgreetoTerms = value!;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 5),

                              RichText(
                                text: TextSpan(
                                  text: "I Agree with ",
                                  style: const TextStyle(
                                    color: AppColors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Terms of Service',
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()..onTap = () {},
                                    ),
                                    TextSpan(
                                      text: ' and ',
                                      style: const TextStyle(
                                        color: AppColors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          PrimaryButton(text: "Register", onPressed: () => {}),

                          const SizedBox(height: 24),

                          Row(
                            children: const [
                              Expanded(child: Divider(thickness: 1)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Or sign in with'),
                              ),
                              Expanded(child: Divider(thickness: 1)),
                            ],
                          ),

                          const SizedBox(height: 16),

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

                          SizedBox(height: 20),

                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Already have an account? ",
                                style: const TextStyle(color: AppColors.black),
                                children: [
                                  TextSpan(
                                    text: 'Sign In',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => LoginPage(),
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
}
