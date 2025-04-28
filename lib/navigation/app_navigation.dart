import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeout/pages/user/my_cart.dart';
import 'package:takeout/pages/user/home_page.dart';
import 'package:takeout/pages/merchant/merchant_home_page.dart';
import 'package:takeout/pages/merchant/merchant_payment.dart';
import 'package:takeout/pages/profile/profile_page.dart';
import 'package:takeout/pages/merchant/merchant_shop.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/toast_widget.dart';
import 'package:takeout/utils/get_user_type.dart';

class AppNavigation extends StatefulWidget {
  final int initialIndex;

  const AppNavigation({super.key, this.initialIndex = 0});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  late int _selectedIndex;
  bool isMerchant = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _loadUserType();
  }

  Future<void> _loadUserType() async {
    try {
      final status = await GetUserType.isMerchantUser(context);
      setState(() {
        isMerchant = status;
      });
    } catch (e) {
      debugPrint("Error loading user type: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  DateTime? _lastPressed;

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastPressed == null ||
        now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      showToast(message: 'Press again to exit');
      return false;
    }
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> bottomNavItems =
        isMerchant
            ? [
              {
                "icon": Icons.home_outlined,
                "activeIcon": Icons.home,
                "label": "Home",
              },
              {
                "icon": Icons.credit_card_outlined,
                "activeIcon": Icons.credit_card,
                "label": "Payment",
              },
              {
                "icon": Icons.store_outlined,
                "activeIcon": Icons.store,
                "label": "Shop",
              },
              {
                "icon": Icons.person_outline,
                "activeIcon": Icons.person,
                "label": "Profile",
              },
            ]
            : [
              {
                "icon": Icons.home_outlined,
                "activeIcon": Icons.home,
                "label": "Home",
              },
              {
                "icon": Icons.shopping_bag_outlined,
                "activeIcon": Icons.shopping_bag,
                "label": "Cart",
              },
              {
                "icon": Icons.person_outline,
                "activeIcon": Icons.person,
                "label": "Profile",
              },
            ];

    final List<Widget> pages =
        isMerchant
            ? [
              const MerchantHomePage(),
              const MerchantPayment(),
              const Merchantshop(),
              const ProfilePage(),
            ]
            : [const HomePage(), const MyCart(), const ProfilePage()];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onWillPop();
        }
      },
      child: Scaffold(
        body: IndexedStack(index: _selectedIndex, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          backgroundColor: AppColors.neutral10,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.neutral50,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: FontSizes.sm,
          ),
          items:
              bottomNavItems.map((item) {
                return BottomNavigationBarItem(
                  icon: Icon(item['icon'] as IconData),
                  activeIcon: Icon(item['activeIcon'] as IconData),
                  label: item['label'] as String,
                );
              }).toList(),
        ),
      ),
    );
  }
}
