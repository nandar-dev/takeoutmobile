import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
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
    final title = "reset_password.title".tr();
    final description = "reset_password.description".tr();
    final newPasswordLabel = "reset_password.new_pass_label".tr();
    final newPasswordPlaceholder = "reset_password.new_pass_placeholder".tr();
    final confirmPasswordLabel = "reset_password.confirm_pass_label".tr();
    final confirmPasswordPlaceholder = "reset_password.confirm_pass_placeholder".tr();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBarWidget(
          title: "",
          onBackTap: () {
            Navigator.pushNamed(context, AppRoutes.otp);
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
                            TitleText(text: title, fontSize: FontSizes.heading3,),
                            const SizedBox(height: 8),
                            SubText(text: description, fontSize: FontSizes.sm,),
                            const SizedBox(height: 32),

                            CustomTextField(
                              label: newPasswordLabel,
                              hint: newPasswordPlaceholder,
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
                              label: confirmPasswordLabel,
                              hint: confirmPasswordPlaceholder,
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
                              child: CustomPrimaryButton(
                                text: "button.verify_acc".tr(),
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
                CustomPrimaryButton(
                  text: "Verify Account",
                  onPressed:
                      () => {Navigator.pushNamed(context, AppRoutes.login)},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
