import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/models/transaction_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final statusBgColors = transaction.status == "completed"
        ? AppColors.green50
        : AppColors.yello50;
    final statusTextColor = transaction.status == "completed"
        ? AppColors.success
        : AppColors.yello700;
    final statusBorderColor = transaction.status == "completed"
        ? AppColors.green200
        : AppColors.yello200;

    return Card(
      color: AppColors.neutral10,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar icon
            const SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundColor: AppColors.green50,
                child: Icon(
                  size: 35,
                  Icons.arrow_circle_down,
                  color: AppColors.success,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Main content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    "refill.${transaction.title}".tr(),
                    style: const TextStyle(fontSize: FontSizes.md),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  // Time and ID info
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 15,
                        color: AppColors.neutral60,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          transaction.dateTime,
                          style: const TextStyle(
                            color: AppColors.neutral60,
                            fontSize: FontSizes.sm,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Account: ${transaction.account}",
                    style: const TextStyle(
                      color: AppColors.neutral60,
                      fontSize: FontSizes.sm,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "ID: ${transaction.id}",
                    style: const TextStyle(
                      color: AppColors.neutral60,
                      fontSize: FontSizes.sm,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Amount and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "+ \$${transaction.amount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: FontSizes.md,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: statusBorderColor, width: 1),
                    color: statusBgColors,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "status.${transaction.status}".tr(),
                    style: TextStyle(
                      color: statusTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
