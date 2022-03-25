import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpain/api_repository.dart';

import '../survey.dart';
import 'survey_view.dart';

/// {@template counter_page}
/// A [StatelessWidget] which is responsible for providing a
/// [CounterCubit] instance to the [CounterView].
/// {@endtemplate}
class SurveyRoute extends StatelessWidget {
  final ApiRepository repository;
  final int score;

  const SurveyRoute({Key? key, required this.repository, required this.score});

  // Make the cubit available to the children.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: repository,
        child: BlocProvider(
          create: (_) => SurveyBloc(repository: repository, score: score)
            ..add(SurveyLoadEvent()),
          child: SurveyView(),
        ));
  }
}
