import 'package:flutter/material.dart';
import 'package:takeout/pages/auth/login_page.dart';
import 'package:takeout/pages/auth/otp_page.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ResetpassPage extends StatefulWidget {
  const ResetpassPage({super.key});

  @override
  State<ResetpassPage> createState() => _ResetpassPageState();
}

class _ResetpassPageState extends State<ResetpassPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBarWidget(
          title: "Reset Password",
          onBackTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OtpPage()),
            );
          },
        ),
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleText(text: "Reset Password"),
                            const SizedBox(height: 8),
                            const SubText(
                              text:
                                  "Your new password must be different from the previously used password",
                            ),
                            const SizedBox(height: 32),

                            CustomTextField(
                              label: "New Password",
                              hint: "Enter New Password",
                              obscureText: true,
                              controller: _newPasswordController,
                              suffixIcon: const Icon(Icons.visibility_off),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'New password is required';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            CustomTextField(
                              label: "Confirm Password",
                              hint: "Enter Confirm Password",
                              obscureText: true,
                              controller: _confirmPasswordController,
                              suffixIcon: const Icon(Icons.visibility_off),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm password is required';
                                } else if (value !=
                                    _newPasswordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 32),

                            SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                text: "Verify Account",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _showpasswordChangedSheet(context);
                                  }
                                },
                              ),
                            ),

                            const SizedBox(height: 32),
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
  }

  void _showpasswordChangedSheet(BuildContext context) {
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
                const SizedBox(height: 32),

                Image.asset(
                  'assets/images/illustration_success.png',
                  height: 168,
                  width: 203,
                ),
                const SizedBox(height: 32),

                const TitleText(
                  text: "Password Changed",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const SubText(
                  textAlign: TextAlign.center,
                  text:
                      "Password changed successfully, you can login again with a new password",
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: "Verify Account",
                  onPressed:
                      () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
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
