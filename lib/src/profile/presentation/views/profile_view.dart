import 'package:flutter/material.dart';
import 'package:toknote/src/profile/presentation/refactors/profile_header.dart';
import 'package:toknote/src/profile/presentation/widgets/profile_app_bart.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ProfileAppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            ProfileHeader(),
            // ProfileBody(),
          ],
        ),
      ),
    );
  }
}
