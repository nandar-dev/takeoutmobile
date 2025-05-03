import 'package:flutter/material.dart';
import 'package:takeout/navigation/app_navigation.dart';
import 'package:takeout/pages/auth/forgotpass_page.dart';
import 'package:takeout/pages/auth/login_page.dart';
import 'package:takeout/pages/auth/otp_page.dart';
import 'package:takeout/pages/auth/resetpass_page.dart';
import 'package:takeout/pages/auth/signup_page.dart';
import 'package:takeout/pages/merchant/add_discount_page.dart';
import 'package:takeout/pages/merchant/add_shop_page.dart';
import 'package:takeout/pages/merchant/merchant_product_list.dart';
import 'package:takeout/pages/merchant/merchant_withdrawl.dart';
import 'package:takeout/pages/user/categories_list.dart';
import 'package:takeout/pages/user/home_page.dart';
import 'package:takeout/pages/landing/landing_page.dart';
import 'package:takeout/pages/user/product/products_by_shop.dart';
import 'package:takeout/pages/user/select_payment.dart';
import 'package:takeout/pages/user/product/product_detail.dart';
import 'package:takeout/pages/user/product/product_list.dart';
import 'package:takeout/pages/profile/personaldata_page.dart';
import 'package:takeout/pages/profile/profile_page.dart';
import 'package:takeout/pages/profile/refillwallet_page.dart';
import 'package:takeout/pages/profile/settings_page.dart';
import 'package:takeout/pages/profile/transaction_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String otp = '/otp';
  static const String forgotpass = '/forgotpass';
  static const String resetpass = '/resetpass';
  static const String landing = '/';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String categories = '/categories-list';
  static const String products = '/products-list';
  static const String productsListByMerchant = '/products-by-merchant';
  static const String product = '/product';
  static const String appNavigation = '/navigation';
  static const String personaldata = '/personaldata';
  static const String settingspage = '/settings';
  static const String refillwallet = '/refillwallet';
  static const String transactionhistory = '/transactionhistory';
  static const String selectPayment = '/select-payment';
  static const String merchantWithdrawlHistory = '/merchant-withdrawl-history';
  static const String merchantProductList = '/merchant-products-list';
  static const String addDiscount = '/merchant-add-discount';
  static const String addShop = '/merchant-add-shop';

  static Route<dynamic> _buildRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _buildRoute(const LoginPage());
      case signup:
        return _buildRoute(const SignupPage());
      case otp:
        return _buildRoute(const OtpPage());
      case forgotpass:
        return _buildRoute(const ForgotPassPage());
      case resetpass:
        return _buildRoute(const ResetpassPage());
      case landing:
        return _buildRoute(const LandingPage());
      case home:
        return _buildRoute(const HomePage());
      case profile:
        return _buildRoute(const ProfilePage());
      case categories:
        return _buildRoute(const CategoriesList());
      case merchantWithdrawlHistory:
        return _buildRoute(const MerchantWithdrawl());
      case addShop:
        return _buildRoute(const AddShopPage());
      case products:
        final args = settings.arguments as Map<String, dynamic>;
        final categoryId = args['categoryId'];
        return _buildRoute(ProductList(categoryId: categoryId));
      case productsListByMerchant:
        final args = settings.arguments as Map<String, dynamic>;
        final merchantId = args['merchantId'];
        return _buildRoute(ProductsByShop(merchantId: merchantId));
      case product:
        final args = settings.arguments as Map<String, dynamic>;
        final product = args['product'];
        return _buildRoute(ProductDetail(product: product));
      case appNavigation:
        final args =
            settings.arguments == null
                ? {'initialIndex': 0}
                : settings.arguments as Map<String, dynamic>;
        final index = args['initialIndex'];
        return _buildRoute(AppNavigation(initialIndex: index));
      case personaldata:
        return _buildRoute(const PersonalDataPage());
      case settingspage:
        return _buildRoute(const SettingsPage());
      case refillwallet:
        return _buildRoute(const RefillWalletPage());
      case transactionhistory:
        return _buildRoute(const TransactionHistoryPage());
      case merchantProductList:
        return _buildRoute(const MerchantProductList());
      case selectPayment:
        return _buildRoute(const Selectpayment());
      case addDiscount:
        final args = settings.arguments as Map<String, dynamic>;
        final productId = args['productId'] as int;
        final name = args['name'] as String;
        final price = args['price'] as double;

        return _buildRoute(AddDiscountPage(
          productId: productId,
          name: name,
          price: price,
        ));
      default:
        return _buildRoute(
          const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
