import 'package:easy_localization/easy_localization.dart';
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
    final title = "title.refill".tr();
    final paymentHistoryLabel = "button.payment_history".tr();
    final refillDes = "refill.description".tr();
    final amtLabel = "refill.amount_label".tr();
    final amtPlaceholder = "refill.amount_placeholder".tr();
    final paymentLabel = "refill.payment_label".tr();
    final paymentPlaceholder = "refill.payment_placeholder".tr();
    final paymentDes = "refill.payment_description".tr();
    final transactionLabel = "refill.transaction_label".tr();
    final transactionPlaceholder = "refill.transaction_placeholder".tr();
    final ssLabel = "refill.ss_label".tr();
    final ssDes = "refill.ss_description".tr();
    final note = "refill.note".tr();
    final remarkLabel = "refill.remark_label".tr();
    final remarkPlaceholder = "refill.remark_placeholder".tr();
    
    Future<bool> onWillPop() async {
      // Navigator.pushNamed(
      //   context,
      //   AppRoutes.appNavigation,
      //   arguments: {'initialIndex': 2},
      // );
      Navigator.pushNamed(context, AppRoutes.selectPayment);
      return false;
    }


    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          onWillPop();
        }
      },
      child: Scaffold(
        appBar: AppBarWidget(title: title, onBackTap: onWillPop),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubText(text: refillDes, fontSize: FontSizes.sm),
                          const SizedBox(height: 16),
                          CustomTextField(
                            prefixIcon: Icon(Icons.attach_money_outlined),
                            label: amtLabel,
                            hint: amtPlaceholder,
                          ),
                          SizedBox(height: 16),

                          CustomDropdownFormField<String>(
                            label: paymentLabel,
                            value: selectedPaymentMethod,
                            items: paymethodMethodOptiosn,
                            hintText: paymentPlaceholder,
                            onChanged: (val) {
                              setState(() {
                                selectedPaymentMethod = val;
                              });
                            },
                            validator:
                                (val) =>
                                    val == null ? paymentPlaceholder : null,
                          ),
                          SizedBox(height: 8),
                          SubText(text: paymentDes, fontSize: FontSizes.sm),
                          SizedBox(height: 16),

                          CustomTextField(
                            label: transactionLabel,
                            hint: transactionPlaceholder,
                          ),

                          const SizedBox(height: 16),

                          SubText(
                            text: ssLabel,
                            fontSize: FontSizes.md,
                            color: AppColors.textPrimary,
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
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: AppColors.danger,
                                          borderRadius: BorderRadius.circular(
                                            40,
                                          ),
                                        ),
                                        child: IconButton(
                                          color: AppColors.neutral10,
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
                          SizedBox(height: 8),
                          SubText(text: ssDes, fontSize: FontSizes.sm),

                          const SizedBox(height: 16),

                          CustomTextField(
                            label: remarkLabel,
                            hint: remarkPlaceholder,
                            maxLines: 3,
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            child: CustomPrimaryButton(
                              text: title,
                              onPressed: () => (),
                              borderRadius: 8,
                            ),
                          ),

                          const SizedBox(height: 16),
                          SubText(
                            text: note,
                            fontSize: FontSizes.sm,
                            textAlign: TextAlign.center,
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
                                text: paymentHistoryLabel,
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
  }

  Widget _buildPreview() {
    final ssPlaceholder = "refill.ss_placeholder".tr();
    if (_pickedFile == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 60,
            color: Colors.grey,
          ),
          SizedBox(height: 8),
          SubText(
            textAlign: TextAlign.center,
            text: ssPlaceholder,
            fontSize: FontSizes.sm,
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
