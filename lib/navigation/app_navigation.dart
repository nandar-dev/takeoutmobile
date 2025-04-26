import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeout/pages/cart/my_cart.dart';
import 'package:takeout/pages/home/home_page.dart';
import 'package:takeout/pages/profile/profile_page.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:takeout/widgets/toast_widget.dart';

class AppNavigation extends StatefulWidget {
  final int initialIndex;

  const AppNavigation({super.key, this.initialIndex = 0});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  late int _selectedIndex;

  static const List<BottomNavigationBarItem> _navBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined),
      activeIcon: Icon(Icons.shopping_bag),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  final List<Widget> _pages = const [HomePage(), MyCart(), ProfilePage()];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
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
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _pages[_selectedIndex],
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
          items: _navBarItems,
        ),
      ),
    );
  }
}
