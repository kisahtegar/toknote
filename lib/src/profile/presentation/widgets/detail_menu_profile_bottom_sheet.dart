import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toknote/core/common/widgets/list_tile_button.dart';
import 'package:toknote/core/extensions/context_extension.dart';
import 'package:toknote/core/services/injection_container.dart';
import 'package:toknote/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:toknote/src/profile/presentation/views/edit_profile_view.dart';

class DetailMenuProfileBottomSheet extends StatelessWidget {
  const DetailMenuProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      iconSize: 32,
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.only(left: 7, right: 7, bottom: 10),
              child: Wrap(
                children: [
                  // Drag trigger decoration bottomsheet
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),

                  // Edit Profile
                  ListTileButton(
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(
                        BlocProvider(
                          create: (_) => sl<AuthBloc>(),
                          child: const EditProfileView(),
                        ),
                      );
                    },
                  ),

                  // Help
                  const ListTileButton(
                    icon: Icons.help_outline,
                    title: 'Help',
                  ),

                  // Divider
                  Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                    endIndent: 16,
                    indent: 16,
                  ),

                  // Logout Account
                  ListTileButton(
                    icon: Icons.logout,
                    iconColor: Colors.red,
                    title: 'Logout Account',
                    titleColor: Colors.red,
                    onTap: () async {
                      final navigator = Navigator.of(context);
                      await FirebaseAuth.instance.signOut();
                      unawaited(
                        navigator.pushNamedAndRemoveUntil(
                          '/',
                          (route) => false,
                        ),
                      );
                    },
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
