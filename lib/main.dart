import 'package:flutter/material.dart';

import 'package:toknote/core/res/colours.dart';
import 'package:toknote/core/res/fonts.dart';
import 'package:toknote/core/services/injection_container.dart';
import 'package:toknote/core/services/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toknote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
        useMaterial3: true,
        fontFamily: Fonts.poppins,
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
