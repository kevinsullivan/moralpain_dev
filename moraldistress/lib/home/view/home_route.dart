import 'dart:math';

import 'package:flutter/material.dart';

import 'package:moraldistress/assets/constants.dart' as Constants;
import 'package:moraldistress/assets/colors.dart' as uvacolors;
import '../../thermometer/thermometer.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.APPBAR_TEXT)),
      body: CustomPaint(
          painter: HomePainter(),
          child: Center(
              child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(4),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)))),
            child: const Text(Constants.HOME_BUTTON_TEXT),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ThermometerRoute()),
              );
            },
          ))),
    );
  }
}

class HomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (isPortrait(size)) {
      paintPortrait(canvas, size);
    } else {
      paintLandscape(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  bool isPortrait(Size size) {
    return size.height > size.width;
  }

  void paintPortrait(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint uvaBlue = Paint();
    uvaBlue..color = uvacolors.UVABlue.withAlpha(200);
    Paint uvaOrange = Paint();
    uvaOrange..color = uvacolors.UVAOrange.shade100;

    final largeCirleOffset = Offset(width * .52, height * .92);
    final largeCircleRadius = width * .40;
    canvas.drawCircle(largeCirleOffset, largeCircleRadius, uvaBlue);

    final mediumCirlceOffset = Offset(width * .8, height * .96);
    final mediumCircleRadius = width * .25;
    canvas.drawCircle(mediumCirlceOffset, mediumCircleRadius, uvaBlue);

    final smallCirlceOffset = Offset(width * .2, height * .55);
    final smallCircleRadius = width * .15;
    canvas.drawCircle(smallCirlceOffset, smallCircleRadius, uvaBlue);

    final tinyCirlceOffset = Offset(width * .85, height * .12);
    final tinyCircleRadius = width * .04;
    canvas.drawCircle(tinyCirlceOffset, tinyCircleRadius, uvaOrange);
  }

  void paintLandscape(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint uvaBlue = Paint();
    uvaBlue..color = uvacolors.UVABlue.withAlpha(200);
    Paint uvaOrange = Paint();
    uvaOrange..color = uvacolors.UVAOrange.shade100;

    final largeCirleOffset = Offset(width * .05, height * .5);
    final largeCircleRadius = width * .18;
    canvas.drawCircle(largeCirleOffset, largeCircleRadius, uvaBlue);

    final mediumCirlceOffset = Offset(width * .5, height * .9);
    final mediumCircleRadius = width * .13;
    canvas.drawCircle(mediumCirlceOffset, mediumCircleRadius, uvaBlue);

    final smallCirlceOffset = Offset(width * .3, height * .25);
    final smallCircleRadius = width * .02;
    canvas.drawCircle(smallCirlceOffset, smallCircleRadius, uvaOrange);
  }
}
