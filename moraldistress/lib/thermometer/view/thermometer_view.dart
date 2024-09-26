import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uva_themed_widgets/src/colors.dart' as uvacolors;
import 'package:moraldistress/assets/constants.dart' as constants;
import 'package:moraldistress/assets/thermometer_constants.dart'
    as thermometerconstants;
import 'package:moraldistress/survey/view/survey_route.dart';
import '../thermometer.dart';
import 'themometer_slider.dart';
import '../../string_casing_extension.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}
class ThermometerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(uvacolors.COLORS_UVA_BLUE),
        title: const Text(constants.APPBAR_TEXT),
      ),
      body: Padding(
          padding: EdgeInsets.all(constants.PADDING),
          child: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return _potraitMode();
            } else {
              return _landscapeMode();
            }
          })),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => SurveyRoute(
                      score: context.read<ThermometerCubit>().state.toInt())),
            );
          },
          child: const Icon(Icons.navigate_next),
          backgroundColor: const Color(uvacolors.COLORS_UVA_BLUE)),
    );
  }

  Widget _landscapeMode() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  thermometerLandscapeText(),
                  _thermometerLabel()
                ])),
            Expanded(
                child:
                    RotatedBox(quarterTurns: -1, child: ThermometerWidget())),
          ]);

  Widget thermometerLandscapeText() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(thermometerconstants.THERMOMETER_TITLE,
            style: TextStyle(
                fontSize: thermometerconstants.THERMOMETER_TITLE_FONT_SIZE)),
        SizedBox(height: 10),
        Text(
          thermometerconstants.THERMOMETER_INSTRUCTIONS,
        ),
      ]);

  Widget _potraitMode() => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(thermometerconstants.THERMOMETER_TITLE,
                style: TextStyle(
                    fontSize:
                        thermometerconstants.THERMOMETER_TITLE_FONT_SIZE)),
            SizedBox(height: 10),
            Text(
              thermometerconstants.THERMOMETER_INSTRUCTIONS,
            ),
            SizedBox(height: 10),
            Expanded(
                child:
                    RotatedBox(quarterTurns: -1, child: ThermometerWidget())),
            _thermometerLabel()
          ]);

  Widget _thermometerLabel() =>
      BlocBuilder<ThermometerCubit, double>(builder: (context, state) {
        return Center(
            child: Text(
          _scoreToText(state),
          style: TextStyle(
              fontSize: thermometerconstants.THERMOMETER_LABEL_FONT_SIZE),
        ));
      });

  String _scoreToText(score) {
    final rounded = score.round();
    final label = thermometerconstants.THERMOMETER_LABELS[rounded] ?? "";
    return label.toTitleCase();
  }
}
