import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/bloc/auth/bloc.dart';
import 'package:takeout/bloc/auth/state.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          // Optional: show a loader dialog or snack
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.appNavigation,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
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
                              const SubText(
                                text: "Please sign in to your account",
                              ),
                              const SizedBox(height: 32),

                              // Email field
                              CustomTextField(
                                label: "Email Address",
                                hint: "Enter Email",
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 14),

                              // Password field
                              CustomTextField(
                                label: "Password",
                                hint: "Enter Password",
                                controller: _passwordController,
                                obscureText: true,
                                suffixIcon: const Icon(Icons.visibility_off),
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
                                child: CustomPrimaryButton(
                                  text:
                                      state is AuthLoading
                                          ? "Signing in..."
                                          : "Sign In",
                                  onPressed: () {},
                                  // onPressed: state is AuthLoading
                                  //     ? null
                                  //     : () {
                                  //         final email = _emailController.text.trim();
                                  //         final password = _passwordController.text.trim();
                                  //         context.read<AuthBloc>().add(LoginRequested(email, password));
                                  //       },
                                ),
                              ),

                              const SizedBox(height: 24),
                              const DividerRow(),
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

                              const SizedBox(height: 32),

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
                                                Navigator.pushNamed(
                                                  context,
                                                  AppRoutes.signup,
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
      },
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
                CustomPrimaryButton(
                  text: "Continue",
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgotpass);
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

class DividerRow extends StatelessWidget {
  const DividerRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
