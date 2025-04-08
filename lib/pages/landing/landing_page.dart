import 'package:flutter/material.dart';
import 'package:takeout/pages/home/home_page.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _titles = [
    "We serve incomparable delicacies",
    "We serve incomparable delicacies",
    "We serve incomparable delicacies",
  ];

  final List<String> _descriptions = [
    "All the best restaurants with their top menu waiting for you, they cant’t wait for your order!!",
    "All the best restaurants with their top menu waiting for you, they cant’t wait for your order!!",
    "All the best restaurants with their top menu waiting for you, they cant’t wait for your order!!",
  ];

  void _toHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _nextPage() {
    if (_currentPage < _titles.length - 1) {
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
      children: List.generate(_titles.length, (index) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: AppColors.neutral100.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(24),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _titles.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (_, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _titles[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.neutral10,
                                fontSize: FontSizes.heading1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Flexible(
                              child: Text(
                                _descriptions[index],
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
                        style: TextButton.styleFrom(
                          overlayColor: Colors.transparent,
                        ),
                        onPressed: _skip,
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            color: AppColors.neutral10,
                            fontSize: FontSizes.body,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          overlayColor: Colors.transparent,
                        ),
                        onPressed: _nextPage,
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: AppColors.neutral10,
                        ),
                        iconAlignment: IconAlignment.end,
                        label: Text(
                          "Next",
                          style: TextStyle(
                            color: AppColors.neutral10,
                            fontSize: FontSizes.body,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
