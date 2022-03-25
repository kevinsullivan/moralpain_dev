import 'package:flutter/material.dart';

import 'home/home.dart';
import 'package:moraldistress/assets/colors.dart' as uvacolors;

/// {@template counter_app}
/// A [MaterialApp] which sets the `home` to [CounterPage].
/// {@endtemplate}
class MoralDistressApp extends MaterialApp {
  @override
  ThemeData? get theme => ThemeData(
        fontFamily: 'LibreFranklin',
        primarySwatch: uvacolors.UVABlue,
      );

  const MoralDistressApp({Key? key}) : super(key: key, home: const HomeRoute());
}
