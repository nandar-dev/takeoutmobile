import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ForgotPassPage extends StatelessWidget {
  const ForgotPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    final title = "login.forgot".tr();
    final description = "login.forgot_description".tr();
    final email = "login.email".tr();
    final emailPlaceholder = "login.email_placeholder".tr();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBarWidget(title: "", onBackTap: () => Navigator.pushNamed(context, AppRoutes.login),),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  TitleText(text: title, fontSize: FontSizes.heading2,),
                  const SizedBox(height: 8),
                  SubText(text: description, fontSize: FontSizes.sm,),
                  const SizedBox(height: 32),

                  CustomTextField(
                    label: email,
                    hint: emailPlaceholder,
                    keyboardType: TextInputType.visiblePassword,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: CustomPrimaryButton(
                      text: "button.continue".tr(),
                      onPressed:
                          () => {Navigator.pushNamed(context, AppRoutes.otp)},
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
