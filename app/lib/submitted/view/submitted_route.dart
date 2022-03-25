import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpain/api_repository.dart';

import '../submitted.dart';
import 'submitted_view.dart';

class SubmittedRoute extends StatelessWidget {
  final ApiRepository repository;

  const SubmittedRoute({Key? key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: repository,
        child: BlocProvider(
          create: (_) =>
              ResourcesBloc(repository: repository)..add(ResourcesLoadEvent()),
          child: SubmittedView(),
        ));
  }
}
