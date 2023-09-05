// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toknote/core/common/app/providers/user_provider.dart';
import 'package:toknote/core/res/colours.dart';
import 'package:toknote/src/auth/data/models/user_model.dart';
import 'package:toknote/src/dashboard/presentation/providers/dashboard_controllet.dart';
import 'package:toknote/src/dashboard/presentation/utils/dashboard_utils.dart';

/// The `Dashboard` widget is responsible for displaying the main user interface of
/// the app's dashboard. It listens to changes in user data using a `StreamBuilder`,
/// controls the active screen with an `IndexedStack`, and provides navigation
/// using a `BottomNavigationBar`. It also updates the user data in the `UserProvider`
/// when new data is available.
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  /// The route name used to navigate to the dashboard screen.
  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    // Set the preferred screen orientations to portrait-up and portrait-down.
    // This means that the app will only allow portrait orientations, preventing
    // the screen from rotating to landscape mode.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DashboardUtils.userDataStream,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data is LocalUserModel) {
          // Update the user data in the [UserProvider] using
          context.read<UserProvider>().user = snapshot.data;
        }
        return Consumer<DashboardController>(
          // Listens for changes in the DashboardController. When the controller's
          // state changes, it rebuilds its child widget with the updated data.
          builder: (_, controller, __) {
            return Scaffold(
              body: IndexedStack(
                // This widget is used to manage multiple screens or pages that
                // can be displayed in the dashboard. The [IndexedStack] widget
                // shows only one child at a time based on the [controller.currentIndex].
                // The [controller.screens] list contains the screens to be displayed.
                index: controller.currentIndex,
                children: controller.screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                // Displays tabs at the bottom of the screen and allows users to
                // switch between different sections.
                currentIndex: controller.currentIndex,
                // showSelectedLabels: false,
                backgroundColor: Colors.white,
                elevation: 8,
                type: BottomNavigationBarType.fixed,
                onTap: controller.changeIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 0
                          ? Icons.house
                          : Icons.house_outlined,
                      color: controller.currentIndex == 0
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'Home',
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 1
                          ? Icons.store
                          : Icons.store_outlined,
                      color: controller.currentIndex == 1
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'Store',
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 2
                          ? Icons.document_scanner
                          : Icons.document_scanner_outlined,
                      color: controller.currentIndex == 2
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'Document',
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 3
                          ? Icons.person_2
                          : Icons.person_2_outlined,
                      color: controller.currentIndex == 3
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'User',
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
