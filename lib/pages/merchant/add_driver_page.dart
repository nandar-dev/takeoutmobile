import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/formfields/custom_phone_field.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:takeout/widgets/formfields/image_upload.dart';

class AddDriverPage extends StatefulWidget {
  const AddDriverPage({super.key});

  @override
  State<AddDriverPage> createState() => _AddDriverPageState();
}

class _AddDriverPageState extends State<AddDriverPage> {
  PlatformFile? uploadedDriverPhoto;
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final title = "title.add_driver".tr();
    final label1 = "input.name_label".tr();
    final label2 = "input.email_label".tr();
    final label3 = "input.phone_label".tr();
    final photoDes = "input.photo_description".tr();
    final label4 = "input.photo_label".tr();
    final label5 = "input.password_label".tr();
    final label6 = "input.c_password_label".tr();
    final placeholer1 = "input.name_placeholder".tr();
    final placeholer2 = "input.email_placeholder".tr();
    final placeholer3 = "input.phone_placeholder".tr();
    final placeholer5 = "input.password_placeholder".tr();
    final placeholer6 = "input.c_password_placeholder".tr();
    final btnLabel = "button.reg_driver".tr();

    FocusNode focusNode = FocusNode();

    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(height: 12),
              CustomTextField(label: label1, hint: placeholer1),
              const SizedBox(height: 12),
              CustomTextField(label: label2, hint: placeholer2),
              const SizedBox(height: 12),
              CustomPhoneField(
                label: label3,
                hint: placeholer3,
                focusNode: focusNode,
                onChanged: (phone) {
                  debugPrint(phone);
                },
                onCountryChanged: (country) {
                  debugPrint(country);
                },
              ),
              const SizedBox(height: 12),
              ImageUpload(
                label: label4,
                description: photoDes,
                onFileChanged: (file) {
                  setState(() {
                    uploadedDriverPhoto = file;
                  });
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: label5,
                hint: placeholer5,
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: label6,
                hint: placeholer6,
                obscureText: true,
                controller: cPasswordController,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: CustomPrimaryButton(
                  backgroundColor: AppColors.primaryDark,
                  borderRadius: 8,
                  text: btnLabel,
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
