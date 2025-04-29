import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takeout/cubit/auth/auth_cubit.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/iconbutton_one_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    this.screenHeight,
    this.bgImg,
    this.bgColor,
    this.textColor,
    this.iconColor,
    this.sectionHeight,
    this.title,
  });

  final double? screenHeight;
  final String? bgImg;
  final Color? bgColor;
  final Color? textColor;
  final Color? iconColor;
  final double? sectionHeight;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final chevronDownIcon = 'assets/icons/chevron_down.svg';
    final locationIcon = 'assets/icons/location.svg';
    final notiIcon = 'assets/icons/noti.svg';
    final searchIcon = 'assets/icons/search.svg';

    final user = context.read<AuthCubit>().repository.getLoggedInUser()!;
    final String locTitle = "home.location_label".tr();

    final Color resolvedTextColor = textColor ?? AppColors.textLight;
    final Color resolvedIconColor = iconColor ?? AppColors.textLight;

    final double resolvedHeight =
        sectionHeight ?? (screenHeight != null ? screenHeight! * 0.2 : 80);

    return Stack(
      children: [
        // Background Container
        Container(
          height: resolvedHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: bgColor ?? AppColors.background,
            image:
                bgImg != null
                    ? DecorationImage(
                      image: AssetImage(bgImg!),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )
                    : null,
          ),
        ),

        // Centered Title Text
        if (title != null)
          Positioned.fill(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 50),
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: FontSizes.heading2,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: resolvedTextColor,
                  ),
                ),
              ),
            ),
          ),

        // Top Content (Location + Icons)
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location Info
                Column(
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
                    const SizedBox(height: 3),
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
                        const SizedBox(width: 8),
                        SubText(text: "Yangon", color: resolvedTextColor),
                      ],
                    ),
                  ],
                ),

                // Action Icons
                Row(
                  children: [
                    if (user.role != "merchant") ...[
                      IconButtonOneWidget(
                        icon: searchIcon,
                        iconColor: resolvedIconColor,
                        borderColor: bgColor,
                        onTap: () {
                          debugPrint("search button clicked");
                        },
                      ),
                      const SizedBox(width: 15),
                    ],
                    IconButtonOneWidget(
                      icon: notiIcon,
                      iconColor: resolvedIconColor,
                      borderColor: bgColor,
                      onTap: () {
                        debugPrint("noti button clicked");
                      },
                    ),
                    if (user.role == "merchant") ...[
                      const SizedBox(width: 15),
                      CircleAvatar(
                        backgroundColor: AppColors.neutral30,
                        child: SubText(text: "S", color: AppColors.textPrimary),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
