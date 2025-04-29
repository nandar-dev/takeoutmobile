import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/user/user_cubit.dart';
import 'package:takeout/cubit/user/user_state.dart';
import 'package:takeout/data/models/user_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:takeout/widgets/loading/loading_screen.dart';
import 'package:takeout/widgets/toast_widget.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  UserModel? user;
  PlatformFile? _pickedFile;
  final _fullNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final List<String> genderOptions = ["Male", "Female", "Other"];
  final _formKey = GlobalKey<FormState>();

  Future<bool> _onWillPop() async {
    Navigator.pushNamed(
      context,
      AppRoutes.appNavigation,
      arguments: {'initialIndex': 2},
    );
    return false;
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _pickedFile = result.files.first;
        });
        context.read<UserCubit>().updateProfileImage(_pickedFile!);
      }
    } catch (e) {
      if (mounted) {
        showToast(message: 'Error picking file: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    user = context.read<UserCubit>().repository.getLoggedInUser()!;
    _fullNameController.text = user!.name!;
    _locationController.text = user!.address!;
    _phoneController.text = user!.phone!;
    _emailController.text = user!.email!;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _savePersonalData() {
    if (_formKey.currentState!.validate()) {
      final String name = _fullNameController.text.trim();
      final String email = _emailController.text.trim();
      final String phone = _phoneController.text.trim();
      final String address = _locationController.text.trim();
      context.read<UserCubit>().updateProfile(name, email, phone, address);
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
        if (state is UserError) {
          showToast(message: state.message);
        } else if (state is Authenticated) {
          Navigator.pushNamed(context, AppRoutes.profile);
        }
      },
      builder: (context, snapshot) {
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            appBar: AppBarWidget(title: 'Personal Data', onBackTap: _onWillPop),
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    const SizedBox(height: 32),

                    GestureDetector(onTap: _pickFile, child: _buildPreview()),

                    const SizedBox(height: 24),
                    CustomTextField(
                      label: "Full Name",
                      hint: "Enter full name",
                      controller: _fullNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: "Location",
                      hint: "Enter location",
                      controller: _locationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    // CustomDropdownFormField<String>(
                    //   label: "Gender",
                    //   value: _selectedGender,
                    //   items: genderOptions,
                    //   hintText: "Select gender",
                    //   onChanged: (val) {
                    //     setState(() {
                    //       _selectedGender = val;
                    //     });
                    //   },
                    //   validator:
                    //       (val) =>
                    //           val == null || val.isEmpty
                    //               ? "Please select a gender"
                    //               : null,
                    // ),
                    // const SizedBox(height: 12),
                    CustomTextField(
                      label: "Phone",
                      hint: "Enter phone",
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: "Email",
                      hint: "Enter email",
                      controller: _emailController,
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 36),
                    CustomPrimaryButton(
                      text: "Save",
                      onPressed: _savePersonalData,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreview() {
    if (_pickedFile != null) {
      final String? filePath = _pickedFile!.path;
      return Center(
        child: Stack(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: Image.file(
                  File(filePath!),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Error loading preview',
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),
            _buildCameraIcon(),
          ],
        ),
      );
    } else if (user?.image?.isNotEmpty == true) {
      return _buildImagePreview(NetworkImage(user!.image!));
    } else {
      return _buildInitialAvatar(user!.name ?? '');
    }
  }

  Widget _buildImagePreview(ImageProvider image) => Center(
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(48),
          child: Image(
            image: image,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        _buildCameraIcon(),
      ],
    ),
  );

  Widget _buildInitialAvatar(String name) => Center(
    child: Stack(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: AppColors.surface,
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : '',
            style: const TextStyle(
              fontSize: FontSizes.heading1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _buildCameraIcon(),
      ],
    ),
  );

  Widget _buildCameraIcon() => Positioned(
    bottom: 0,
    right: 0,
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surface,
        border: Border.all(color: AppColors.neutral10, width: 2),
      ),
      child: const Icon(Icons.camera_alt, color: AppColors.primary, size: 20),
    ),
  );
}
