import 'package:bloc/bloc.dart';

/// {@template counter_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class ThermometerCubit extends Cubit<double> {
  /// {@macro counter_cubit}
  ThermometerCubit() : super(0);

  void set(double val) => emit(val);
}
