import 'package:flutter/material.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/loading/loading_screen.dart';
import 'package:takeout/widgets/toast_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/user/user_cubit.dart';
import 'package:takeout/cubit/user/user_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isAgreetoTerms = false;

  bool _isPasswordValid(String password) {
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~])[A-Za-z\d!@#\$&*~]{6,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  bool _doPasswordsMatch() {
    return _passwordController.text.trim() ==
        _confirmPasswordController.text.trim();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();
      context.read<UserCubit>().register(username, email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoading) {
          LoadingScreen.instance().show(context: context);
        } else {
          LoadingScreen.instance().hide();
        }

        if (state is Authenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        } else if (state is UserError) {
          showToast(message: state.message);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBarWidget(title: ""),
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                const TitleText(
                                  text: "Create your new account",
                                ),
                                const SizedBox(height: 8),
                                const SubText(
                                  text:
                                      "Create an account to start looking for the food you like",
                                ),
                                const SizedBox(height: 32),

                                CustomTextField(
                                  label: "Email Address",
                                  hint: "Enter Email",
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email is required';
                                    } else if (!value.contains('@')) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 14),

                                CustomTextField(
                                  controller: _usernameController,
                                  label: "User Name",
                                  hint: "Enter User Name",
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'User name is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 14),

                                CustomTextField(
                                  controller: _passwordController,
                                  label: "Password",
                                  hint: "Enter Password",
                                  obscureText: true,
                                  suffixIcon: Icon(Icons.visibility_off),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'New password is required';
                                    } else if (!_isPasswordValid(
                                      _passwordController.text.trim(),
                                    )) {
                                      return 'Password must be at least 6 characters, include an uppercase letter, a number, and a special character.';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 14),

                                CustomTextField(
                                  controller: _confirmPasswordController,
                                  label: "Confirm Password",
                                  hint: "Confirm your Password",
                                  obscureText: true,
                                  suffixIcon: Icon(Icons.visibility_off),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Confirm password is required';
                                    } else if (!_doPasswordsMatch()) {
                                      return 'Passwords do not match.';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: 14),
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
                                          fontSize: FontSizes.sm,
                                          color: AppColors.neutral100,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Terms of Service',
                                            style: const TextStyle(
                                              color: AppColors.primary,
                                              fontSize: FontSizes.sm,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap = () {},
                                          ),
                                          TextSpan(
                                            text: ' and ',
                                            style: const TextStyle(
                                              fontSize: FontSizes.sm,
                                              color: AppColors.neutral100,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Privacy Policy',
                                            style: const TextStyle(
                                              fontSize: FontSizes.sm,
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                SizedBox(
                                  width: double.infinity,
                                  child: CustomPrimaryButton(
                                    text:
                                        state is UserLoading
                                            ? "Registering..."
                                            : "Register",
                                    onPressed: () {
                                      if (state is! UserLoading) _register();
                                    },
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: const [
                                    Expanded(child: Divider(thickness: 1)),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        'Or sign in with',
                                        style: TextStyle(
                                          fontSize: FontSizes.body,
                                        ),
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
                                      text: "Already have an account? ",
                                      style: const TextStyle(
                                        color: AppColors.neutral100,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Sign In',
                                          style: const TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          recognizer:
                                              TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    AppRoutes.login,
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
}
