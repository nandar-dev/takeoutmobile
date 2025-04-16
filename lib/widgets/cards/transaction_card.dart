import 'package:flutter/material.dart';
import 'package:takeout/models/transaction_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final statusBgColors =
        transaction.status == "completed"
            ? AppColors.green50
            : AppColors.yello50;
    final statusTextColor =
        transaction.status == "completed"
            ? AppColors.success
            : AppColors.yello700;
    final statusBorderColor =
        transaction.status == "completed"
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
            SizedBox(
              height: 50,
              width: 50,
              child: const CircleAvatar(
                backgroundColor: AppColors.green50,
                child: Icon(
                  size: 35,
                  Icons.arrow_circle_down,
                  color: AppColors.success,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(fontSize: FontSizes.md),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        size: 15,
                        Icons.access_time,
                        color: AppColors.neutral60,
                      ),
                      SizedBox(width: 1),
                      Text(
                        transaction.dateTime,
                        style: TextStyle(
                          color: AppColors.neutral60,
                          fontSize: FontSizes.sm,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Account: ${transaction.account}\nID: ${transaction.id}",
                    style: TextStyle(
                      color: AppColors.neutral60,
                      fontSize: FontSizes.sm,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "+ \$${transaction.amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: FontSizes.md,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
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
                    transaction.status,
                    style: TextStyle(
                      color: statusTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
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
