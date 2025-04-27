import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/auth/auth_cubit.dart';
import 'package:takeout/cubit/auth/auth_state.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/alertbox_widget.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/outlinebutton_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/render_svg_icon.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().repository.getLoggedInUser()!;

    final title = "title.profileSetting".tr();
    return Scaffold(
      appBar: AppBarWidget(title: title, showBackNavigator: false),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          }
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(height: 32),
              Center(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/person.png'),
                        radius: 48,
                        backgroundColor: AppColors.surface,
                        // child: Text(
                        //   "Z",
                        //   style: TextStyle(
                        //     fontSize: FontSizes.heading1,
                        // fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surface,
                          border: Border.all(
                            color: AppColors.neutral10,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              Center(
                child: Text(
                  user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: FontSizes.body,
                  ),
                ),
              ),
              const SizedBox(height: 4),

              const Center(
                child: Text(
                  "customer001@gmail.com",
                  style: TextStyle(
                    color: AppColors.neutral60,
                    fontSize: FontSizes.body,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.neutral10,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      blurRadius: 29,
                      spreadRadius: 0,
                      offset: Offset(0, 7),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Your balance",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSizes.md,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "\$0.00",
                            style: TextStyle(
                              fontSize: FontSizes.heading2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Available Balance",
                            style: TextStyle(
                              color: AppColors.neutral70,
                              fontSize: FontSizes.body,
                            ),
                          ),
                        ],
                      ),
                    ),

                    CustomPrimaryButton(
                      height: 30,
                      padding: EdgeInsets.only(left: 8, right: 8),
                      text: "Refill",
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.refillwallet);
                      },
                      icon: Icons.arrow_circle_up_rounded,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.background,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      blurRadius: 29,
                      spreadRadius: 0,
                      offset: Offset(0, 7),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "My Orders",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: FontSizes.md,
                          ),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: FontSizes.body,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: RichText(
                            text: TextSpan(
                              text: "Order ID ",
                              style: TextStyle(
                                color: AppColors.neutral70,
                                fontSize: FontSizes.sm,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: '888333777',
                                  style: const TextStyle(
                                    color: AppColors.neutral100,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Badge(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 8,
                          ),
                          label: Text(
                            "In progress",
                            style: TextStyle(fontSize: FontSizes.body),
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    const Divider(thickness: 2, color: AppColors.neutral30),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.asset('assets/images/order_burger.png'),
                      title: Text(
                        "Burger With Meat",
                        style: TextStyle(
                          fontSize: FontSizes.body,
                          fontWeight: FontWeight.w600,
                          color: AppColors.neutral100,
                        ),
                      ),
                      subtitle: Text(
                        "\$ 12,230",
                        style: TextStyle(
                          fontSize: FontSizes.body,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      trailing: Text(
                        "14 items",
                        style: TextStyle(
                          fontSize: FontSizes.sm,
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral100,
                        ),
                      ),
                    ),

                    // const Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 8),
                    //   child: Text(
                    //     "No order found",
                    //     style: TextStyle(
                    //       color: AppColors.neutral70,
                    //       fontSize: FontSizes.body,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              const Divider(thickness: 2, color: AppColors.neutral30),
              SizedBox(height: 12),

              const Text(
                "Profile",
                style: TextStyle(
                  color: AppColors.neutral70,
                  fontSize: FontSizes.sm,
                ),
              ),

              const SizedBox(height: 8),
              _buildMenuItem("assets/icons/user.svg", "Personal Data", () {
                Navigator.pushNamed(context, AppRoutes.personaldata);
              }),
              const SizedBox(height: 8),
              _buildMenuItem("assets/icons/setting.svg", "Settings", () {
                Navigator.pushNamed(context, AppRoutes.settingspage);
              }),

              const SizedBox(height: 16),
              const Text(
                "Support",
                style: TextStyle(
                  color: AppColors.neutral70,
                  fontSize: FontSizes.sm,
                ),
              ),
              const SizedBox(height: 8),
              _buildMenuItem("assets/icons/info.svg", "Help Center", () {
                Navigator.pushNamed(context, AppRoutes.personaldata);
              }),
              const SizedBox(height: 16),

              SizedBox(
                width: 150,
                child: CustomOutlinedButton(
                  onPressed: () {
                    showCustomAlertDialog(
                      context: context,
                      title: 'Sign Out',
                      message: 'Do you want to log out?',
                      confirmText: 'Log Out',
                      cancelText: 'Cancel',
                      onConfirm: () {
                        context.read<AuthCubit>().logout();
                      },
                    );
                  },
                  icon: Icons.logout,
                  text: "Sign Out",
                  iconColor: AppColors.danger,
                  textColor: AppColors.danger,
                  borderColor: AppColors.danger,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String icon, String text, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.all(8),
        child: RenderSvgIcon(
          assetName: icon,
          color: AppColors.textPrimary,
          size: 20,
        ),
      ),
      title: SubText(
        text: text,
        fontSize: FontSizes.md,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      trailing: RenderSvgIcon(
        assetName: "assets/icons/chevron_right.svg",
        color: AppColors.neutral90,
        size: 12,
      ),
      onTap: onTap,
    );
  }
}
