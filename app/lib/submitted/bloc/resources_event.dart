part of 'resources_bloc.dart';

abstract class ResourcesEvent {
  const ResourcesEvent();
}

class ResourcesLoadEvent extends ResourcesEvent {
  const ResourcesLoadEvent();
}

class ResourceVisitedEvent extends ResourcesEvent {
  final String resourceId;
  const ResourceVisitedEvent(this.resourceId);
}

class VisitedResourcesSubmitEvent extends ResourcesEvent {
  const VisitedResourcesSubmitEvent();
}
