part of 'survey_bloc.dart';

abstract class SurveyEvent {
  const SurveyEvent();
}

class SurveyLoadEvent extends SurveyEvent {
  const SurveyLoadEvent();
}

class SurveyUpdateEvent extends SurveyEvent {
  final String optionId;
  final bool value;
  const SurveyUpdateEvent(this.optionId, this.value);
}

class SurveySubmitEvent extends SurveyEvent {
  const SurveySubmitEvent();
}
