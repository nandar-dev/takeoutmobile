import 'package:flutter/material.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/outlinebutton_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/formfields/customdropdownfield_widget.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class RefillWalletPage extends StatefulWidget {
  const RefillWalletPage({super.key});

  @override
  State<RefillWalletPage> createState() => _RefillWalletPageState();
}

class _RefillWalletPageState extends State<RefillWalletPage> {
  String? selectedPaymentMethod;
  final List<String> paymethodMethodOptiosn = ["K Pay", "CB Pay", "AYA Pay"];

  PlatformFile? _pickedFile;

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
      } else {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('No file selected.')));
        }
      }
    } catch (e) {
      print("Error picking file: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking file: $e')));
      }
    }
  }

  void _clearFile() {
    setState(() {
      _pickedFile = null;
    });
  }

  bool _isImageFile(String? filePath) {
    if (filePath == null) return false;
    final String ext = filePath.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Refill Wallet',
        onBackTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.appNavigation,
            arguments: {'initialIndex': 2},
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const TitleText(
                          text: 'Refill Your Wallet',
                          textAlign: TextAlign.center,
                        ),
                        const SubText(
                          text:
                              'Add funds to your wallet to make quick and easy payments',
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 32),

                        CustomTextField(
                          label: 'Amount',
                          hint: '\$ Enter amount',
                        ),
                        SizedBox(height: 16),

                        CustomDropdownFormField<String>(
                          label: "Payment Method",
                          value: selectedPaymentMethod,
                          items: paymethodMethodOptiosn,
                          hintText: "Select payment method",
                          onChanged: (val) {
                            setState(() {
                              selectedPaymentMethod = val;
                            });
                          },
                          validator:
                              (val) =>
                                  val == null
                                      ? "Please select a payment method"
                                      : null,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Select a payment method to see account details for your transfer',
                            style: TextStyle(
                              fontSize: FontSizes.sm,
                              color: AppColors.neutral80,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        CustomTextField(
                          label: 'Transaction ID',
                          hint: 'Enter transaction ID',
                        ),

                        const SizedBox(height: 16),

                        Text(
                          'Transaction Screenshot',
                          style: const TextStyle(
                            color: AppColors.neutral100,
                            fontSize: FontSizes.body,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: _pickFile,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.textfieldborder,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                _buildPreview(),
                                if (_pickedFile != null)
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: AppColors.backkeyborder,
                                        ),
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.close),
                                        tooltip: 'Clear selection',
                                        onPressed: _clearFile,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        CustomTextField(
                          label: 'Remark (Optional)',
                          hint: 'Add any additional information',
                          maxLines: 3,
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: CustomPrimaryButton(
                            text: 'Refill Wallet',
                            onPressed: () => (),
                            borderRadius: 8,
                          ),
                        ),

                        const SizedBox(height: 16),
                        const Center(
                          child: Text(
                            'Your refill request will be processed within 24 hours. You will receive a notification once completed.',
                            style: TextStyle(
                              color: AppColors.neutral60,
                              fontSize: FontSizes.sm,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),

                        Center(
                          child: SizedBox(
                            width: 200,
                            child: CustomOutlinedButton(
                              icon: Icons.history,
                              iconColor: AppColors.primary,
                              textColor: AppColors.primary,
                              borderColor: AppColors.primary,
                              borderRadius: 8,
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.transactionhistory,
                                );
                              },
                              text: "Payment History",
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
    );
  }

  Widget _buildPreview() {
    if (_pickedFile == null) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 60,
            color: Colors.grey,
          ),
          SizedBox(height: 8),
          Text(
            'Tap to select an image',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    final String? filePath = _pickedFile!.path;

    if (filePath != null && _isImageFile(filePath)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0 - 1.5),
        child: Image.file(
          File(filePath),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            print("Error loading image preview: $error");
            return const Center(
              child: Text('Error loading preview', textAlign: TextAlign.center),
            );
          },
        ),
      );
    } else {
      // Fallback for non-image files or missing path
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.insert_drive_file, size: 50, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              'File: ${_pickedFile!.name}\n(Cannot preview this file type)',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }
  }
}
