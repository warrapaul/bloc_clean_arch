import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/core/constants/app_media.dart';
import 'package:bloc_clean_arch/features/on_boarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bloc_clean_arch/features/on_boarding/presentation/cubit/onboarding_state.dart';
import 'package:bloc_clean_arch/features/on_boarding/presentation/pages/onboarding_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<OnboardingSlide> pages = [
    const OnboardingSlide(
      title: 'Welcome to Our App',
      description: 'Discover amazing features that will help you achieve more.',
      imagePath: AppMedia.onBoardingWelcome,
    ),
    const OnboardingSlide(
      title: 'Easy to Use',
      description: 'Our intuitive interface makes it simple to get started.',
      imagePath: AppMedia.onBoardingEasyToUse,
    ),
    const OnboardingSlide(
      title: 'Get Started Now',
      description: 'Join thousands of users and start your journey today.',
      imagePath: AppMedia.onBoardingGettingStarted,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onNextPressed() {
    if (_currentPage < pages.length - 1) {
      _navigateToPage(_currentPage + 1);
    } else {
      _onFinishPressed();
    }
  }

  void _onBackPressed() {
    if (_currentPage > 0) {
      _navigateToPage(_currentPage - 1);
    }
  }

  void _onSkipPressed() {
    _onFinishPressed();
  }

  void _onFinishPressed() async {
    await context.read<OnboardingCubit>().complete();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          // Let the router handle navigation
          context.go(AppRoutePaths.login); 
        } else if (state is OnboardingError) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _currentPage < pages.length - 1
                        ? TextButton(
                            onPressed: _onSkipPressed,
                            child: const Text('Skip'),
                          )
                        : const SizedBox(width: 80),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: pages
                      .map((page) => OnboardingSlide(
                            title: page.title,
                            description: page.description,
                            imagePath: page.imagePath,
                          ))
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: pages.length,
                      effect: WormEffect(
                        activeDotColor: Theme.of(context).primaryColor,
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 8,
                        type: WormType.thin,
                      ),
                      onDotClicked: _navigateToPage,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _currentPage > 0
                            ? TextButton.icon(
                                onPressed: _onBackPressed,
                                icon: const Icon(Icons.arrow_back),
                                label: const Text('Back'),
                              )
                            : const SizedBox(width: 80),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: _onNextPressed,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              _currentPage == pages.length - 1
                                  ? 'Get Started'
                                  : 'Next',
                            ),
                          ),
                        ),
                      ],
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
}
