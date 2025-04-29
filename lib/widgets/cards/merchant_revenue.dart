import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/cards/no_data.dart';
import 'package:takeout/widgets/formfields/customdropdownfield_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class MerchantRevenue extends StatefulWidget {
  const MerchantRevenue({super.key});

  @override
  State<MerchantRevenue> createState() => _MerchantRevenueState();
}

class _MerchantRevenueState extends State<MerchantRevenue> {
  String _selectedRange = 'weekly';
  late String _dateRangeText;

  @override
  void initState() {
    super.initState();
    _updateDateRange();
  }

  void _updateDateRange() {
    final now = DateTime.now();
    final dateFormatSameYear = DateFormat('MMM d');
    final dateFormatFull = DateFormat('MMM d, yyyy');

    if (_selectedRange == 'weekly') {
      final startDate = now.subtract(const Duration(days: 6));

      if (startDate.year == now.year) {
        _dateRangeText =
            "${dateFormatSameYear.format(startDate)} - ${dateFormatFull.format(now)}";
      } else {
        _dateRangeText =
            "${dateFormatFull.format(startDate)} - ${dateFormatFull.format(now)}";
      }
    } else if (_selectedRange == 'monthly') {
      final startDate = DateTime(now.year, now.month, 1);

      if (startDate.year == now.year) {
        _dateRangeText =
            "${dateFormatSameYear.format(startDate)} - ${dateFormatFull.format(now)}";
      } else {
        _dateRangeText =
            "${dateFormatFull.format(startDate)} - ${dateFormatFull.format(now)}";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = "merchant_home.revenue_title".tr();
    final noRevenue = "merchant_home.no_revenue".tr();
    final noRevenueDes = "merchant_home.no_revenue_des".tr();

    return Card(
      elevation: 1,
      color: AppColors.neutral10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: AppColors.neutral30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: title,
                color: AppColors.neutral80,
                fontSize: FontSizes.heading3,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.neutral30,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 10,
                      ),
                      child: SubText(
                        textAlign: TextAlign.center,
                        text: _dateRangeText,
                        fontSize: FontSizes.sm,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  SizedBox(
                    width: 165,
                    child: CustomDropdownFormField<String>(
                      label: '',
                      value: _selectedRange,
                      items: const ['weekly', 'monthly'],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedRange = value;
                            _updateDateRange();
                          });
                        }
                      },
                      itemToString: (value) => value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // No revenue container with dashed border
              NoData(noData: noRevenue, noDataDes: noRevenueDes),
            ],
          ),
        ),
      ),
    );
  }
}