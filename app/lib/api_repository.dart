import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:moralpain/assets/constants.dart' as Constants;
import 'package:moralpainapi/moralpainapi.dart';
import 'package:moralpainapi/src/model/survey.dart';

class ApiRepository {
  final log = Logger('SurveyRepository');

  final mapi = Moralpainapi(
      basePathOverride:
          'https://umd7orqgt1.execute-api.us-east-1.amazonaws.com/v1');

  ApiRepository() {
    mapi.dio.options.connectTimeout = 30 * 1000;
    mapi.dio.options.receiveTimeout = 30 * 1000;
    mapi.dio.options.sendTimeout = 30 * 1000;
  }

  /**
   * Fetch the latest version of the moral distress survey from the API.
   * Fall back to a local copy on error.
   */
  Future<Survey> fetchSurvey() async {
    final dapi = mapi.getDefaultApi();

    try {
      return (await dapi.getSurvey()).data!;
    } catch (err) {
      log.warning('Error fetching survey. Falling back to local file.', err);
    }

    return fetchSurveyAt(Constants.SURVEY_QUESTIONNAIRE_PATH);
  }

  /**
   * Fetch a locally stored version of the survey.
   */
  Future<Survey> fetchSurveyAt(String path) async {
    try {
      final json = await rootBundle.loadString(path);
      return standardSerializers.fromJson(Survey.serializer, json)!;
    } catch (err) {
      log.shout('Error fetching local survey. Loading empty survey.', err);
    }

    return Survey();
  }

  /**
   * Post a user completed survey to the api.
   */
  Future<bool> submitSurvey(Submission submission) async {
    final dapi = mapi.getDefaultApi();

    try {
      final res = await dapi.submitSurvey(submission: submission);
      return res.statusCode == 200;
    } catch (err) {
      log.shout('Error submitting survey', err);
    }

    return false;
  }

  /**
   * Fetch the latest version of the moral distress survey from the API.
   * Fall back to a local copy on error.
   */
  Future<ResiliencyResources> fetchResiliencyResources() async {
    final dapi = mapi.getDefaultApi();

    try {
      return (await dapi.getResiliencyResources()).data!;
    } catch (err) {
      log.warning('Error fetching resiliency.', err);
    }

    return ResiliencyResources();
  }

  /**
   * Post the visited resources.
   */
  Future<bool> submitVisitedResources(
      VisitedResiliencyResources resources) async {
    final dapi = mapi.getDefaultApi();

    try {
      final res = await dapi.submitVisitedResiliencyResources(
          visitedResiliencyResources: resources);
      return res.statusCode == 200;
    } catch (err) {
      log.warning('Error submitting resources.', err);
    }

    return false;
  }
}
