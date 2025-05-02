import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/outlinebutton_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/formfields/custom_radio_input.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';
import 'package:takeout/widgets/formfields/date_picker.dart';

class AddDiscountPage extends StatefulWidget {
  final int productId;
  final String name;
  final double price;

  const AddDiscountPage({
    super.key,
    required this.productId,
    required this.name,
    required this.price,
  });

  @override
  State<AddDiscountPage> createState() => _AddDiscountPageState();
}

class _AddDiscountPageState extends State<AddDiscountPage> {
  String? selectedStatus;
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final product = "discount.product".tr();
    final price = "discount.price".tr();
    final title = "discount.title".tr();
    final type = "discount.discount_type".tr();
    final description = "Create a discount for ${widget.name}";
    final percentVal = "discount.percent_val".tr();
    final startDateLabel = "discount.s_date".tr();
    final endDateLabel = "discount.e_date".tr();
    final btn1 = "button.cancel".tr();

    final List<String> statusOptions = ["percent", "fix"];

    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubText(text: description),
              const SizedBox(height: 32),
              CustomTextField(
                label: product,
                hint: widget.name,
                readOnly: true,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: price,
                hint: widget.price.toString(),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              SubText(
                text: type,
                color: AppColors.neutral100,
                fontSize: FontSizes.body,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomRadioInput<String>(
                      label: "discount.percent".tr(),
                      value: statusOptions[0],
                      groupValue: selectedStatus,
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                      activeColor: AppColors.primary,
                      showBorder: true,
                      dense: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomRadioInput<String>(
                      label: "discount.fix".tr(),
                      value: statusOptions[1],
                      groupValue: selectedStatus,
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                      activeColor: AppColors.primary,
                      showBorder: true,
                      dense: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(label: percentVal, hint: "10"),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DatePicker(
                      label: startDateLabel,
                      selectedDate: startDate,
                      onDateSelected: (pickedDate) {
                        setState(() {
                          startDate = pickedDate;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: DatePicker(
                      label: endDateLabel,
                      selectedDate: endDate,
                      onDateSelected: (pickedDate) {
                        setState(() {
                          endDate = pickedDate;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ), // Give space above the fixed bottom buttons
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
        child: Row(
          children: [
            Expanded(
              child: CustomOutlinedButton(
                onPressed: () {},
                text: btn1,
                borderRadius: 8,
                borderColor: AppColors.neutral40,
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              height: 40,
              child: CustomPrimaryButton(
                  svgAssetPath: "assets/icons/discount.svg",
                  text: title,
                  onPressed: () {},
                  borderRadius: 8,
                ),
            )
          ],
        ),
      ),
    );
  }
}
