import 'package:flutter/material.dart';

const primaryColour = Color.fromARGB(255, 255, 0, 100);

const BorderRadius radius = BorderRadius.only(
    topLeft: Radius.circular(40), topRight: Radius.circular(40));

class Settings {
  static final _SettingsColours colours = _SettingsColours();
  static final _SettingsSlidingUpPanel panel = _SettingsSlidingUpPanel();

  static const double radius = 35;
  static const BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(radius), topRight: Radius.circular(radius));
}

class _SettingsColours {
  final Color primary;
  final Color secondary;
  final Color tertiary;

  _SettingsColours(
      {this.primary = const Color.fromARGB(255, 48, 50, 61),
      this.secondary = const Color.fromARGB(255, 66, 191, 221),
      this.tertiary = const Color.fromARGB(255, 220, 86, 86)});
}

class _SettingsSlidingUpPanel {
  final double maxHeight = 300;
  final double minHeight = 30;
}
