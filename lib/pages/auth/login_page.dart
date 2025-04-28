import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/auth/auth_cubit.dart';
import 'package:takeout/cubit/auth/auth_state.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/loading/loading_screen.dart';
import 'package:takeout/widgets/toast_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    context.read<AuthCubit>().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final title = "login.title".tr();
    final des = "login.description".tr();
    final email = "login.email".tr();
    final emailPlaceholder = "login.email_placeholder".tr();
    final password = "login.password".tr();
    final passwordPlaceholder = "login.password_placeholder".tr();
    final forgot = "login.forgot".tr();
    final noAcc = "login.no_acc".tr();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          LoadingScreen.instance().show(context: context);
        } else {
          LoadingScreen.instance().hide();
        }

        if (state is AuthError) {
          showToast(message: state.message);
        } else if (state is Authenticated) {
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 32),
                                TitleText(
                                  text: title,
                                  fontSize: FontSizes.heading2,
                                ),
                                const SizedBox(height: 8),
                                SubText(text: des, fontSize: FontSizes.sm),
                                const SizedBox(height: 32),

                                CustomTextField(
                                  label: email,
                                  hint: emailPlaceholder,
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
                                  label: password,
                                  hint: passwordPlaceholder,
                                  controller: _passwordController,
                                  obscureText: true,
                                  suffixIcon: const Icon(Icons.visibility_off),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      overlayColor: Colors.transparent,
                                    ),
                                    onPressed:
                                        () => _showForgotPasswordSheet(context),
                                    child: Text(
                                      forgot,
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
                                            : "button.signin".tr(),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (state is! AuthLoading) login();
                                      }
                                    },
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
                                      text: noAcc,
                                      style: const TextStyle(
                                        color: AppColors.neutral100,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "button.register".tr(),
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
    final forgot = "login.forgot".tr();
    final forgotDes = "login.forgot_description".tr();

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
                TitleText(text: forgot, fontSize: FontSizes.heading2),
                const SizedBox(height: 8),
                SubText(text: forgotDes),
                const SizedBox(height: 30),
                CustomPrimaryButton(
                  text: "button.continue".tr(),
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
    final or = "login.or".tr();
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(or, style: TextStyle(fontSize: FontSizes.body)),
        ),
        Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}
