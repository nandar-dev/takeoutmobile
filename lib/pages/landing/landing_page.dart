import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:takeout/pages/post.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/pages/routing/routes.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> titles = [
    'landing.title1'.tr(),
    'landing.title2'.tr(),
    'landing.title3'.tr(),
  ];

  List<String> descriptions = [
    'landing.desc1'.tr(),
    'landing.desc2'.tr(),
    'landing.desc3'.tr(),
  ];

  void _toHomePage() {
    // Navigator.pushNamed(context, AppRoutes.appNavigation);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostPage()),
    );
  }

  void _nextPage() {
    if (_currentPage < titles.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _toHomePage();
    }
  }

  void _skip() {
    _toHomePage();
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(titles.length, (index) {
        bool isActive = index == _currentPage;
        return GestureDetector(
          onTap: () {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 6),
            height: 6,
            width: 28,
            decoration: BoxDecoration(
              color: isActive ? AppColors.neutral10 : Colors.white54,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _onWillPop(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/landing_bg.webp',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.neutral100.withAlpha(128),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: titles.length,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                        itemBuilder: (_, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                titles[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.neutral10,
                                  fontSize: FontSizes.heading1,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Flexible(
                                child: Text(
                                  descriptions[index],
                                  style: const TextStyle(
                                    color: AppColors.neutral10,
                                    fontSize: FontSizes.body,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDotsIndicator(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _skip,
                          child:
                              const Text(
                                "landing.skip",
                                style: TextStyle(
                                  color: AppColors.neutral10,
                                  fontSize: FontSizes.body,
                                ),
                              ).tr(),
                        ),
                        TextButton.icon(
                          onPressed: _nextPage,
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: AppColors.neutral10,
                            size: 20,
                          ),
                          label:
                              const Text(
                                "landing.next",
                                style: TextStyle(
                                  color: AppColors.neutral10,
                                  fontSize: FontSizes.body,
                                ),
                              ).tr(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
