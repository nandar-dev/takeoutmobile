import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:takeout/cubit/user/user_cubit.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/utils/get_location.dart';
import 'package:takeout/widgets/buttons/iconbutton_one_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class HeroSection extends StatefulWidget {
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
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  String locationName = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationName = "Location services disabled";
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        locationName = "Location permission denied";
      });
      return;
    }

    final location = await LocationHelper.getCityAndCountry();
    debugPrint("Location: $location");

    if (location != null) {
      setState(() {
        locationName = location;
      });
    } else {
      setState(() {
        locationName = "Unable to fetch location";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chevronDownIcon = 'assets/icons/chevron_down.svg';
    final locationIcon = 'assets/icons/location.svg';
    final notiIcon = 'assets/icons/noti.svg';
    final searchIcon = 'assets/icons/search.svg';

    final userRole =
        context.read<UserCubit>().repository.getLoggedInUser() ?? 'user';
    final String locTitle = "home.location_label".tr();

    final Color resolvedTextColor = widget.textColor ?? AppColors.textLight;
    final Color resolvedIconColor = widget.iconColor ?? AppColors.textLight;

    final double resolvedHeight =
        widget.sectionHeight ??
        (widget.screenHeight != null ? widget.screenHeight! * 0.2 : 80);

    return Stack(
      children: [
        // Background Container
        Container(
          height: resolvedHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.bgColor ?? AppColors.background,
            image:
                widget.bgImg != null
                    ? DecorationImage(
                      image: AssetImage(widget.bgImg!),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )
                    : null,
          ),
        ),

        // Centered Title Text
        if (widget.title != null)
          Positioned.fill(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 80),
                child: Text(
                  widget.title!,
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
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 50,
              bottom: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location Info
                Flexible(
                  child: Column(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Flexible(
                            child: SubText(
                              text: locationName,
                              color: resolvedTextColor,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action Icons
                Row(
                  children: [
                    if (userRole != "merchant") ...[
                      IconButtonOneWidget(
                        icon: searchIcon,
                        iconColor: resolvedIconColor,
                        borderColor: widget.bgColor,
                        onTap: () {
                          debugPrint("search button clicked");
                        },
                      ),
                      const SizedBox(width: 15),
                    ],
                    IconButtonOneWidget(
                      icon: notiIcon,
                      iconColor: resolvedIconColor,
                      borderColor: widget.bgColor,
                      onTap: () {
                        debugPrint("noti button clicked");
                      },
                    ),
                    if (userRole == "merchant") ...[
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
