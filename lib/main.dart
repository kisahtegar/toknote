import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:toknote/core/common/app/providers/user_provider.dart';
import 'package:toknote/core/res/colours.dart';
import 'package:toknote/core/res/fonts.dart';
import 'package:toknote/core/services/firebase_options.dart';
import 'package:toknote/core/services/injection_container.dart';
import 'package:toknote/core/services/router.dart';

/// The `main` function initializes the Flutter app and sets up Firebase
/// services and authentication providers.
Future<void> main() async {
  // Ensure that Flutter is fully initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the provided options.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configure authentication providers, including EmailAuthProvider for
  // password reset functionality.
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  // Initialize other app dependencies.
  await init();

  // Remove the native splash screen.
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

/// The `MyApp` widget is the root of the Toknote application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'Toknote',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
          useMaterial3: true,
          fontFamily: Fonts.poppins,
        ),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
