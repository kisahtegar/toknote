// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

/// A customizable button-like widget that resembles a [ListTile].
///
/// The `ListTileButton` allows you to create a button-like interface with an
/// icon and text, making it suitable for various UI scenarios such as menus,
/// settings, or navigation. It wraps a [ListTile] with customizable properties
/// for the icon, title, colors, and an optional `onTap` callback.
///
/// By default, it provides sensible styling with black icons and text on a white
/// background. You can customize the appearance by specifying the [iconColor],
/// [titleColor], and [visualDensity].
///
/// Example:
/// ```dart
/// ListTileButton(
///   icon: Icons.settings,
///   title: 'Settings',
///   onTap: () {
///     // Handle button tap
///   },
///   iconColor: Colors.blue,
///   titleColor: Colors.blue,
/// )
/// ```
class ListTileButton extends StatelessWidget {
  /// Creates a [ListTileButton] widget.
  ///
  /// The [icon] and [title] are required properties, and you can customize
  /// the appearance using optional parameters such as [iconColor], [titleColor],
  /// [visualDensity], and [onTap].
  const ListTileButton({
    required this.icon,
    required this.title,
    this.iconColor = Colors.black,
    this.titleColor = Colors.black,
    this.onTap,
    this.visualDensity = const VisualDensity(vertical: -4),
    super.key,
  });

  /// The icon to display on the left side of the button.
  final IconData icon;

  /// The title text to display on the right side of the button.
  final String title;

  /// The color of the icon. Defaults to [Colors.black].
  final Color? iconColor;

  /// The color of the title text. Defaults to [Colors.black].
  final Color? titleColor;

  /// A callback function that is called when the button is tapped.
  final VoidCallback? onTap;

  /// The visual density of the button, which affects its overall size and padding.
  /// Defaults to [VisualDensity(vertical: -4)].
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
      onTap: onTap,
      visualDensity: visualDensity,
    );
  }
}
