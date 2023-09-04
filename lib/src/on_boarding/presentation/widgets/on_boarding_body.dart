import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toknote/core/extensions/context_extension.dart';
import 'package:toknote/core/res/colours.dart';
import 'package:toknote/core/res/fonts.dart';
import 'package:toknote/src/on_boarding/domain/entities/page_content.dart';
import 'package:toknote/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({
    required this.pageController,
    required this.index,
    required this.pageContent,
    super.key,
  });

  final PageController pageController;
  final int index;
  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(pageContent.image, height: context.height * .4),
        SizedBox(height: context.height * .03),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                pageContent.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: Fonts.aeonik,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: context.height * .02),
              Text(
                pageContent.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              SizedBox(height: context.height * .05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 17,
                  ),
                  backgroundColor: Colours.primaryColour,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (pageContent.buttonName == 'Next') {
                    // animation
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    return;
                  }
                  context.read<OnBoardingCubit>().cacheFirstTimer();
                },
                child: Text(
                  pageContent.buttonName,
                  style: const TextStyle(
                    fontFamily: Fonts.aeonik,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
