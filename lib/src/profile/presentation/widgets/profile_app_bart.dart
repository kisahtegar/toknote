import 'package:flutter/material.dart';
import 'package:toknote/src/profile/presentation/widgets/detail_menu_profile_bottom_sheet.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Account',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      actions: const [DetailMenuProfileBottomSheet()],
    );
  }

  /// Returns the preferred size of the `ProfileAppBar`. It specifies that the
  /// preferred size is a Size object with a constant height equal to
  /// `kToolbarHeight`. This is commonly used to ensure that the app bar has the
  /// standard height typically used for app bars.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
