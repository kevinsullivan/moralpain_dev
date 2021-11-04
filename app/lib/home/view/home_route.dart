import 'package:flutter/material.dart';

import 'package:moralpain/assets/constants.dart' as Constants;
import '../../thermometer/thermometer.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.APPBAR_TEXT)),
      body: Center(
          child: ElevatedButton(
        child: const Text(Constants.HOME_BUTTON_TEXT),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ThermometerRoute()),
          );
        },
      )),
    );
  }
}
