import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/user/user_cubit.dart';
import 'package:takeout/cubit/user/user_state.dart';
import 'package:takeout/data/models/test_order_model.dart';
import 'package:takeout/data/models/user_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/alertbox_widget.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/custom_text_button.dart';
import 'package:takeout/widgets/buttons/outlinebutton_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/cards/no_data.dart';
import 'package:takeout/widgets/cards/order_card.dart';
import 'package:takeout/widgets/render_custom_image.dart';
import 'package:takeout/widgets/render_svg_icon.dart';
import 'package:takeout/widgets/toast_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  PlatformFile? _pickedFile;
  List<OrderModel> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final orders = await loadOrdersFromJson();
    setState(() {
      _orders = orders;
    });
  }

  Future<List<OrderModel>> loadOrdersFromJson() async {
    final String response = await rootBundle.loadString('assets/data/orders.json');
    final data = json.decode(response) as List;
    return data.map((e) => OrderModel.fromJson(e)).toList();
  }


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
        context.read<UserCubit>().updateProfileImage(_pickedFile!);
      }
    } catch (e) {
      if (mounted) {
        showToast(message: 'Error picking file: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = "title.profileSetting".tr();
    final balance = "profile.balance".tr();
    final available = "profile.available".tr();
    final orders = "profile.orders".tr();
    final profile = "profile.profile".tr();
    final personal = "profile.personal".tr();
    final setting = "profile.setting".tr();
    final support = "profile.support".tr();
    final help = "profile.help".tr();
    final noDataTitle = "message.no_order_title".tr();
    final noDataDes = "message.no_order_des".tr();

    user = context.read<UserCubit>().repository.getLoggedInUser();

    if (user == null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: CustomPrimaryButton(
                text: 'Login',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                },
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBarWidget(title: title, showBackNavigator: false),
      body: BlocListener<UserCubit, UserState>(
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              const SizedBox(height: 32),

              GestureDetector(onTap: _pickFile, child: _buildPreview()),

              const SizedBox(height: 12),

              Center(
                child: SubText(
                  text: user!.name!,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizes.body,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: SubText(
                  text: user!.email ?? '',
                  color: AppColors.neutral60,
                  fontSize: FontSizes.body,
                ),
              ),
              const SizedBox(height: 24),

              Card(
                elevation: 0.5,
                color: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SubText(
                              text: balance,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSizes.md,
                              color: AppColors.textPrimary,
                            ),
                            SizedBox(height: 4),
                            TitleText(
                              text: "\$${user!.walletAmount ?? '0'}",
                              fontSize: FontSizes.heading2,
                              fontWeight: FontWeight.w600,
                            ),
                            SubText(
                              text: available,
                              color: AppColors.neutral70,
                              fontSize: FontSizes.body,
                            ),
                          ],
                        ),
                      ),
                      CustomPrimaryButton(
                        height: 30,
                        padding: EdgeInsets.only(left: 8, right: 8),
                        text: "button.refill".tr(),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.refillwallet);
                        },
                        icon: Icons.arrow_circle_up_rounded,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Card(
                elevation: 0.5,
                color: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubText(
                            text: orders,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            fontSize: FontSizes.md,
                          ),
                          CustomTextButton(
                            btnLabel: "button.view_all".tr(),
                            onTapCallback: ()=> Navigator.pushNamed(context, AppRoutes.ordersList),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // showing latest order
                      _orders.isEmpty
                        ? NoData(
                            noData: noDataTitle,
                            noDataDes: noDataDes,
                            icon: "assets/icons/order_icon.svg",
                          )
                        : Column(
                            children: _orders.take(1).map((order) {
                              return OrderCard(order: order);
                            }).toList(),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Divider(color: AppColors.neutral30),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubText(
                      text: profile,
                      color: AppColors.neutral70,
                      fontSize: FontSizes.sm,
                    ),
                    const SizedBox(height: 8),
                    _buildMenuItem("assets/icons/user.svg", personal, () {
                      Navigator.pushNamed(context, AppRoutes.personaldata);
                    }),
                    const SizedBox(height: 8),
                    _buildMenuItem("assets/icons/setting.svg", setting, () {
                      Navigator.pushNamed(context, AppRoutes.settingspage);
                    }),

                    const SizedBox(height: 16),
                    SubText(
                      text: support,
                      color: AppColors.neutral70,
                      fontSize: FontSizes.sm,
                    ),
                    const SizedBox(height: 8),
                    _buildMenuItem("assets/icons/info.svg", help, () {
                      Navigator.pushNamed(context, AppRoutes.personaldata);
                    }),

                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: CustomOutlinedButton(
                        onPressed: () {
                          showCustomAlertDialog(
                            context: context,
                            title: 'button.signout'.tr(),
                            message: "message.logout_warning".tr(),
                            confirmText: "button.signout".tr(),
                            cancelText: "button.cancel".tr(),
                            onConfirm: () {
                              context.read<UserCubit>().logout();
                            },
                          );
                        },
                        icon: Icons.logout,
                        text: "button.signout".tr(),
                        iconColor: AppColors.danger,
                        textColor: AppColors.danger,
                        borderColor: AppColors.danger,
                      ),
                    ),
                  ],
                ),
              ),
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
          borderRadius: const BorderRadius.all(Radius.circular(8)),
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

  Widget _buildPreview() {
    if (_pickedFile != null) {
      final String? filePath = _pickedFile!.path;
      return Center(
        child: Stack(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: Image.file(
                  File(filePath!),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Error loading preview',
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),
            _buildCameraIcon(),
          ],
        ),
      );
    } else if (user?.image?.isNotEmpty == true) {
      return _buildImagePreview(user!.image!);
    } else {
      return _buildInitialAvatar(user!.name ?? '');
    }
  }

  Widget _buildImagePreview(String image) => Center(
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(48),
          child: RenderCustomImage(
            imageUrl: image,
            width: 100,
            height: 100,
            rounded: 0,
          ),
        ),
        _buildCameraIcon(),
      ],
    ),
  );

  Widget _buildInitialAvatar(String name) => Center(
    child: Stack(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: AppColors.surface,
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : '',
            style: const TextStyle(
              fontSize: FontSizes.heading1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _buildCameraIcon(),
      ],
    ),
  );

  Widget _buildCameraIcon() => Positioned(
    bottom: 0,
    right: 0,
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surface,
        border: Border.all(color: AppColors.neutral10, width: 2),
      ),
      child: const Icon(Icons.camera_alt, color: AppColors.primary, size: 20),
    ),
  );
}
