part of 'resources_bloc.dart';

abstract class ResourcesState {
  final Set<String> optionsSelected;

  ResourcesState() : optionsSelected = Set();
}

class ResourcesLoading extends ResourcesState {}

class ResourcesLoaded extends ResourcesState {
  final ResiliencyResources resources;

  ResourcesLoaded(this.resources);
}

class VisitedResourcesSubmitting extends ResourcesState {
  VisitedResourcesSubmitting();
}

class VisitedResourcesSubmitted extends ResourcesState {
  bool success;
  VisitedResourcesSubmitted(this.success);
}
