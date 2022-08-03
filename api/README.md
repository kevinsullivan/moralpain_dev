# api

This directory contains Dart and Java code for an API client. The classes herein are used to send HTTP requests to and receive HTTP responses from our API on API Gateway. They are also used to represent the different types of output from each API path.

The files here are autogenerated using a program called OpenAPI generator, which references our API template, `infrastructure/sam/api.yaml`, and creates an API client matching the specifications of the template.

## Contents

The `dart` directory contains the code for a Dart package that functions as an API client. For more information about what files are in the `dart` directory and how to use them in your own code, please refer to the `README.md` in that directory.

The `java` directory contains the code for a Java package that functions as an API client. For more information about what files are in this directory and how to use them, please refer to the `README.md` in that directory.

Essentially, the `dart` and `java` directories each contain a separate, auto-generated project, both of which do the same thing. You only need to use one: the Dart package if the code you're writing is in Dart, and the Java package if the code you're writing is in Java.

## Updating the files using OpenAPI Generator

If you modify the OpenAPI template, you will likely need to update the API client files to match the new specifications. To do this, you must run OpenAPI Generator for both the Dart client and the Java client.

### Updating the Dart client

To run OpenAPI Generator for the Dart client, switch to the `dart` directory and use the following commands:

```bash
java -jar ../../openapi-generator-cli.jar generate -i ../../infrastructure/sam/api.yaml --generate-alias-as-model --additional-properties pubName=moralpainapi -g dart-dio
flutter pub run build_runner build
```

## Documentation for API Endpoints

All URIs are relative to *http://localhost*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
[*DefaultApi*](doc/DefaultApi.md) | [**getSurvey**](doc/DefaultApi.md#getsurvey) | **GET** /survey | Fetch moral distress survey
[*DefaultApi*](doc/DefaultApi.md) | [**submitSurvey**](doc/DefaultApi.md#submitsurvey) | **POST** /survey | Submit completed moral distress survey


## Documentation For Models

 - [Submission](doc/Submission.md)
 - [Survey](doc/Survey.md)
 - [SurveyOption](doc/SurveyOption.md)
 - [SurveySection](doc/SurveySection.md)

## Documentation For Authorization

 All endpoints do not require authorization.
## Author