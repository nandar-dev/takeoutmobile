import 'package:flutter/material.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/formfields/customdropdownfield_widget.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  String? selectedGender;
  final List<String> genderOptions = ["Male", "Female", "Other"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Personal Data',
        onBackTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.appNavigation,
            arguments: {'initialIndex': 2},
          );
        },
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 32),
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/person.png'),
                      radius: 48,
                      backgroundColor: AppColors.surface,
                      // child: Text(
                      //   "Z",
                      //   style: TextStyle(
                      //     fontSize: FontSizes.heading1,
                      // fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surface,
                        border: Border.all(
                          color: AppColors.neutral10,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            CustomTextField(label: "Full Name", hint: "Enter full name"),
            SizedBox(height: 12),
            CustomTextField(label: "Location", hint: "Enter location"),
            SizedBox(height: 12),

            CustomDropdownFormField<String>(
              label: "Gender",
              value: selectedGender,
              items: genderOptions,
              hintText: "Select gender",
              onChanged: (val) {
                setState(() {
                  selectedGender = val;
                });
              },
              validator: (val) => val == null ? "Please select a gender" : null,
            ),
            SizedBox(height: 12),
            CustomTextField(label: "Phone", hint: "Enter phone"),
            SizedBox(height: 12),
            CustomTextField(label: "Email", hint: "Enter email"),
            SizedBox(height: 36),
            CustomPrimaryButton(text: "Save", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
