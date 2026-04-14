import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:aws_signature_v4_interceptor/aws_signature_v4_interceptor.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:aws_signature_v4/aws_signature_v4.dart';

class ApiRepository {
  Logger log = Logger('SurveyRepository');

  Moralpainapi mapi = Moralpainapi(
      basePathOverride:
          'https://lxt0kermp2.execute-api.us-east-1.amazonaws.com/v1');

  ApiRepository() {
    mapi.dio.options.connectTimeout = 30 * 1000;
    mapi.dio.options.receiveTimeout = 30 * 1000;
    mapi.dio.options.sendTimeout = 30 * 1000;
  }

  Future<void> credentialRefresh(AWSCredentials credentials) async {
    var provider = StaticCredentialsProvider(credentials);

    try {
      final interceptor =
          mapi.dio.interceptors.whereType<AWSSignatureInterceptor>().first;
      interceptor.credentialsProvider = provider;
    } on StateError {
      const region = 'us-east-1';
      final scope =
          AWSCredentialScope.raw(region: region, service: 'execute-api');
      mapi.dio.interceptors.add(AWSSignatureInterceptor(provider, scope));
    }
  }

  Future<bool> isSigning() async {
    try {
      return mapi.dio.interceptors
          .whereType<AWSSignatureInterceptor>()
          .isNotEmpty;
    } on StateError {
      return false;
    }
  }

  /**
   * Fetch the latest version of the moral distress survey from the API.
   * Fall back to a local copy on error.
   */
  Future<Survey> fetchSurvey() async {
    final uapi = mapi.getUserApi();

    try {
      return (await uapi.getSurvey()).data!;
    } catch (err) {
      log.warning('Error fetching survey. Falling back to local file.', err);
    }

    //return fetchSurveyAt(Constants.SURVEY_QUESTIONNAIRE_PATH);
    return fetchSurveyAt("");
  }

  /**
   * Fetch a locally stored version of the survey.
   */
  Future<Survey> fetchSurveyAt(String path) async {
    try {
      final json = await rootBundle.loadString(path);
      return Survey.fromJson(jsonDecode(json));
    } catch (err) {
      log.shout('Error fetching local survey. Loading empty survey.', err);
    }

    return Survey();
  }

  /**
   * Post a user completed survey to the api.
   */
  Future<bool> submitSurvey(Submission submission) async {
    final uapi = mapi.getUserApi();
    //serializers.serializeWith(Submission.serializer, submission)
    //serializers.toJson(Submission.serializer, submission)

    try {
      final res = await uapi.submitSurvey(submission: submission);
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
    final uapi = mapi.getUserApi();

    try {
      return (await uapi.getResiliencyResources()).data!;
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
    final uapi = mapi.getUserApi();

    try {
      final res = await uapi.submitVisitedResiliencyResources(
          visitedResiliencyResources: resources);
      return res.statusCode == 200;
    } catch (err) {
      log.warning('Error submitting resources.', err);
    }

    return false;
  }
}
