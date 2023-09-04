import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toknote/core/common/views/page_under_construction.dart';
import 'package:toknote/core/extensions/context_extension.dart';
import 'package:toknote/core/services/injection_container.dart';
import 'package:toknote/src/auth/data/models/user_model.dart';
import 'package:toknote/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:toknote/src/auth/presentation/views/sign_in_screen.dart';
import 'package:toknote/src/auth/presentation/views/sign_up_screen.dart';
import 'package:toknote/src/dashboard/presentation/views/dashboard.dart';
import 'package:toknote/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:toknote/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:toknote/src/on_boarding/presentation/views/on_boarding_screen.dart';

/// This code defines the route generation function `generateRoute` responsible
/// for handling different routes within your Flutter application. It constructs
/// the appropriate screens based on the route name and provides necessary
/// dependencies using BlocProvider when required. The `_pageBuilder` function
/// is used to create the page transition with a fade effect.
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (prefs.getBool(kFirstTimerKey) ?? true) {
            // User is opening the application for the first time.
            return BlocProvider(
              create: (_) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            // User is already logged in.
            final user = sl<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              role: '',
              fullName: user.displayName ?? '',
            );
            context.userProvider.initUser(localUser);
            return const Dashboard();
          }
          // User is not opening the app for the first time and needs to log in.
          return BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SignInScreen(),
          );
        },
        settings: settings,
      );
    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );
    case Dashboard.routeName:
      return _pageBuilder(
        (_) => const Dashboard(),
        settings: settings,
      );
    case '/forgot-password':
      return _pageBuilder(
        (_) => const fui.ForgotPasswordScreen(),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

/// This private function is used to construct a `PageRouteBuilder`. It takes a
/// Widget-building function (`page`) and route settings as parameters. It
/// returns a `PageRouteBuilder` with a fade transition animation when
/// navigating between screens.
PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
