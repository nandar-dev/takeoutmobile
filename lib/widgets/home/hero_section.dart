import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takeout/cubit/auth/auth_cubit.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/buttons/iconbutton_one_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    this.screenHeight,
    this.bgImg,
    this.bgColor,
    required this.chevronDownIcon,
    required this.locationIcon,
    required this.searchIcon,
    required this.notiIcon,
    this.textColor,
    this.iconColor,
    this.sectionHeight,
  });

  final double? screenHeight;
  final String? bgImg;
  final Color? bgColor;
  final String chevronDownIcon;
  final String locationIcon;
  final String searchIcon;
  final String notiIcon;
  final Color? textColor;
  final Color? iconColor;
  final double? sectionHeight;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().repository.getLoggedInUser()!;
    final String locTitle = "home.location_label".tr();
    final Color resolvedTextColor = textColor ?? AppColors.textLight;
    final Color resolvedIconColor = iconColor ?? AppColors.textLight;

    return Container(
      height: sectionHeight ?? (screenHeight != null ? screenHeight! * 0.2 : 80),
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.background,
        image: bgImg != null
            ? DecorationImage(
                image: AssetImage(bgImg!),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SubText(text: locTitle, color: resolvedTextColor),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      chevronDownIcon,
                      height: 8,
                      width: 8,
                      colorFilter: ColorFilter.mode(
                        resolvedIconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SvgPicture.asset(
                      locationIcon,
                      height: 18,
                      width: 18,
                      colorFilter: ColorFilter.mode(
                        resolvedIconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SubText(text: "Yangon", color: resolvedTextColor),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                if (user.role != "merchant") ...[
                  IconButtonOneWidget(
                    icon: searchIcon,
                    iconColor: resolvedIconColor,
                    onTap: () {
                      debugPrint("search button clicked");
                    },
                  ),
                ],
                const SizedBox(width: 15),
                IconButtonOneWidget(
                  icon: notiIcon,
                  iconColor: resolvedIconColor,
                  onTap: () {
                    debugPrint("noti button clicked");
                  },
                ),
                if (user.role == "merchant")...[
                  const SizedBox(width: 15),
                  CircleAvatar(
                    backgroundColor: AppColors.neutral30,
                    child: SubText(text: "S", color: AppColors.textPrimary),
                  )
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
