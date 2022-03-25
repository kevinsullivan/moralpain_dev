import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../thermometer.dart';
import 'thermometer_view.dart';

/// {@template counter_page}
/// A [StatelessWidget] which is responsible for providing a
/// [CounterCubit] instance to the [CounterView].
/// {@endtemplate}
class ThermometerRoute extends StatelessWidget {
  /// {@macro counter_page}
  const ThermometerRoute({Key? key}) : super(key: key);

  // Make the cubit available to the children.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThermometerCubit(),
      child: ThermometerView(),
    );
  }
}
