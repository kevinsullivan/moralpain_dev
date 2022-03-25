import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';

import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'dart:convert';

/// tests for DefaultApi
void main() {
  final api = Moralpainapi();
  final defaultApi = api.getDefaultApi();
  final dioInterceptor = DioInterceptor(dio: api.dio);
  final submissionExample = '''
    {
      "score": 9,
      "selections": [
        "001",
        "002"
      ],
      "timestamp": 0,
      "id": "foo"
    }
  ''';
  final visitedResiliencyResourcesExample = '''
    {
      "timestamp": 0, 
      "selections": [
        "a",
        "b"
      ]
    }
  ''';
  dioInterceptor.onGet('/survey', (server) => server.reply(200, jsonDecode('''
    {
      "version": "0.0.1",
      "sections": [
        {
          "sectionId": "001",
          "title": "Patient",
          "subtitle": "",
          "options": [
            {
              "id": "01",
              "description": "Feeling pressured to give unnecessary/inappropriate tests and/or treatments"
            }
          ]
        }
      ]
    }
    ''')));
  dioInterceptor.onPost('/survey', (server) => server.reply(200, ""),
      data: jsonDecode(submissionExample));
  dioInterceptor.onGet(
      '/resiliency', (server) => server.reply(200, jsonDecode('''
      {
        "version": "0.0.1", 
        "resources": [
          { 
            "resourceId": "42",
            "title": "cats",
            "description": "",
            "url": "",
            "icon": { 
              "codePoint": "",
              "fontFamily": "",
              "fontPackage": "" 
            } 
          } 
        ]
      }
    ''')));
  dioInterceptor.onPost('/resiliency', (server) => server.reply(200, ""),
      data: jsonDecode(visitedResiliencyResourcesExample));

  group(DefaultApi, () {
    // Fetch moral distress survey
    //
    //Future<Survey> getSurvey() async
    test('test getSurvey', () async {
      final survey = (await defaultApi.getSurvey()).data!;
      expect("0.0.1", survey.version);
      expect(1, survey.sections!.length);
    });

    // Submit completed moral distress survey
    //
    //Future<String> submitSurvey({ Submission submission }) async
    test('test submitSurvey', () async {
      Submission submission = standardSerializers.fromJson(
          Submission.serializer, submissionExample)!;
      final resp = await defaultApi.submitSurvey(submission: submission);
      expect(200, resp.statusCode);
    });

    test('test getResiliencyResources', () async {
      final resources = (await defaultApi.getResiliencyResources()).data!;
      expect("0.0.1", resources.version);
      expect(1, resources.resources!.length);
    });

    test('test submitSurvey', () async {
      VisitedResiliencyResources visitedResiliencyResources =
          standardSerializers.fromJson(VisitedResiliencyResources.serializer,
              visitedResiliencyResourcesExample)!;
      final resp = await defaultApi.submitVisitedResiliencyResources(
          visitedResiliencyResources: visitedResiliencyResources);
      expect(200, resp.statusCode);
    });
  });
}
