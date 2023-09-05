import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:toknote/core/res/fonts.dart';

import 'package:toknote/core/res/media_res.dart';

/// The `PageUnderConstruction` widget is used to display a "Page Under
/// Construction" screen in your app. This screen is typically shown to inform
/// users that a particular page or feature is not yet available or is currently
/// in development.
class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MediaRes.onBoardingBackground),
            // Ensure the background image covers the entire screen.
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                // Use Lottie animation to display the construction animation.
                MediaRes.pageUnderConstruction,
              ),
              Text(
                title != null
                    ? '$title is under maintenance'
                    : 'This page is under maintenance',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontFamily: Fonts.aeonik,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
