import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toknote/core/common/app/providers/user_provider.dart';
import 'package:toknote/core/common/widgets/icon_menu.dart';
import 'package:toknote/core/res/colours.dart';
import 'package:toknote/core/res/media_res.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, userProvider, __) {
        final user = userProvider.user;
        final image = user?.profilePic == null || user!.profilePic!.isEmpty
            ? null
            : user.profilePic;

        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: image != null
                  ? NetworkImage(image)
                  : const AssetImage(MediaRes.user) as ImageProvider,
            ),
            const SizedBox(height: 16),
            Text(
              user?.fullName ?? 'No User',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                color: Colours.primaryColour,
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Color(0xffcddc39), Color(0xff009688)],
                  stops: [0, 1],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(3, 6),
                    color: Colours.shadowColour,
                  ),
                ],
              ),
              child: Center(
                child: Wrap(
                  spacing: 70,
                  children: [
                    IconMenu(
                      image: MediaRes.role,
                      imageSize: 35,
                      title: 'Role',
                      description: user?.role ?? '',
                    ),
                    IconMenu(
                      image: MediaRes.store,
                      imageSize: 35,
                      title: 'Store',
                      description: user?.enrolledStoreIds.isEmpty ?? true
                          ? 'Empty'
                          : (user?.enrolledStoreIds.length ?? 0).toString(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
