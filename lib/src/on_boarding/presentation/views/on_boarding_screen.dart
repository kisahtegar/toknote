// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toknote/core/common/views/loading_view.dart';
import 'package:toknote/core/common/widgets/gradient_background_image.dart';
import 'package:toknote/core/res/colours.dart';
import 'package:toknote/core/res/media_res.dart';
import 'package:toknote/src/on_boarding/domain/entities/page_content.dart';
import 'package:toknote/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:toknote/src/on_boarding/presentation/widgets/on_boarding_body.dart';

/// The `OnBoardingScreen` widget displays onboarding content to new users.
///
/// This widget is the entry point for onboarding new users to the app. It
/// includes multiple pages with information and a navigation indicator.
///
/// - [pageController]: A [PageController] for navigating between onboarding pages.
/// - [currentIndex]: The current index of the active onboarding page.
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  /// The route name for this screen.
  static const routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  int currentIndex = 2;

  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackgroundImage(
        image: MediaRes.onBoardingBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingStatus && !state.isFirstTimer) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is UserCached) {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          builder: (context, state) {
            if (state is CheckingIfUserIsFirstTimer ||
                state is CachingFirstTimer) {
              return const LoadingView();
            }
            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    currentIndex = index;
                  },
                  children: [
                    OnBoardingBody(
                      pageController: pageController,
                      index: 1,
                      pageContent: const PageContent.first(),
                    ),
                    OnBoardingBody(
                      pageController: pageController,
                      index: 2,
                      pageContent: const PageContent.second(),
                    ),
                    OnBoardingBody(
                      pageController: pageController,
                      index: 3,
                      pageContent: const PageContent.third(),
                    ),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, .04),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 40,
                      activeDotColor: Colours.primaryColour,
                      dotColor: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
