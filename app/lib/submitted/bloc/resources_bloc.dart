import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:moralpain/api_repository.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:moralpainapi/src/model/survey.dart';
import 'package:uuid/uuid.dart';

part 'resources_state.dart';
part 'resources_event.dart';

class ResourcesBloc extends Bloc<ResourcesEvent, ResourcesState> {
  final log = Logger('ResourcesBloc');
  final uuid = Uuid();

  final ApiRepository repository;

  final options = Set<String>();

  ResourcesBloc({required this.repository}) : super(ResourcesLoading()) {
    on<ResourcesLoadEvent>(_onLoad);
    on<VisitedResourcesSubmitEvent>(_onSubmit);
    on<ResourceVisitedEvent>(_onUpdate);
  }

  void _onLoad(ResourcesLoadEvent event, Emitter<ResourcesState> emit) async {
    emit(ResourcesLoading());

    final data = await repository.fetchResiliencyResources();
    emit(ResourcesLoaded(data));
  }

  void _onSubmit(
      VisitedResourcesSubmitEvent event, Emitter<ResourcesState> emit) async {
    final builder = VisitedResiliencyResourcesBuilder();
    builder.selections.addAll(options);
    builder.timestamp = _secondsSinceEpoch();

    final success = await repository.submitVisitedResources(builder.build());
    emit(VisitedResourcesSubmitted(success));
  }

  void _onUpdate(ResourceVisitedEvent event, Emitter<ResourcesState> emit) {
    options.add(event.resourceId);
  }

  /**
   * UTC Seconds since epoch.
   */
  int _secondsSinceEpoch() {
    final utcNow = DateTime.now().toUtc();
    return utcNow.millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
  }
}
