import 'package:flutter/material.dart';
import 'package:takeout/pages/auth/login_page.dart';
import 'package:takeout/pages/profile/personaldata_page.dart';
import 'package:takeout/pages/settings_page.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/appbar_wdget.dart';
import 'package:takeout/widgets/buttons/outlinebutton_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile Settings", showBackNavigator: false),
      body: SafeArea(
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
            const Center(
              child: Text(
                "Customer 001",
                style: TextStyle(
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

                  PrimaryButton(
                    height: 30,
                    padding: EdgeInsets.only(left: 8, right: 8),
                    text: "Top Up",
                    onPressed: () {},
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
            _buildMenuItem(Icons.person, "Personal Data", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PersonalDataPage(),
                ),
              );
            }),
            const SizedBox(height: 8),
            _buildMenuItem(Icons.settings, "Settings", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
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
            _buildMenuItem(Icons.info_outline, "Help Center", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PersonalDataPage(),
                ),
              );
            }),
            const SizedBox(height: 16),

            CustomOutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: Icons.logout,
              text: "Sign Out",
              iconColor: AppColors.danger,
              textColor: AppColors.danger,
              borderColor: AppColors.danger,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: AppColors.neutral100),
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
