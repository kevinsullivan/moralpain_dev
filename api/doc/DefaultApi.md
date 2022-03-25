# moralpainapi.api.DefaultApi

## Load the API package
```dart
import 'package:moralpainapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getResiliencyResources**](DefaultApi.md#getresiliencyresources) | **GET** /resiliency | Fetch resiliency resource list
[**getSurvey**](DefaultApi.md#getsurvey) | **GET** /survey | Fetch moral distress survey
[**submitSurvey**](DefaultApi.md#submitsurvey) | **POST** /survey | Submit completed moral distress survey
[**submitVisitedResiliencyResources**](DefaultApi.md#submitvisitedresiliencyresources) | **POST** /resiliency | Submit visited resiliency resources


# **getResiliencyResources**
> ResiliencyResources getResiliencyResources()

Fetch resiliency resource list

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getDefaultApi();

try {
    final response = api.getResiliencyResources();
    print(response);
} catch on DioError (e) {
    print('Exception when calling DefaultApi->getResiliencyResources: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ResiliencyResources**](ResiliencyResources.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSurvey**
> Survey getSurvey()

Fetch moral distress survey

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getDefaultApi();

try {
    final response = api.getSurvey();
    print(response);
} catch on DioError (e) {
    print('Exception when calling DefaultApi->getSurvey: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Survey**](Survey.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitSurvey**
> String submitSurvey(submission)

Submit completed moral distress survey

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getDefaultApi();
final Submission submission = ; // Submission | 

try {
    final response = api.submitSurvey(submission);
    print(response);
} catch on DioError (e) {
    print('Exception when calling DefaultApi->submitSurvey: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **submission** | [**Submission**](Submission.md)|  | [optional] 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitVisitedResiliencyResources**
> String submitVisitedResiliencyResources(visitedResiliencyResources)

Submit visited resiliency resources

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getDefaultApi();
final VisitedResiliencyResources visitedResiliencyResources = ; // VisitedResiliencyResources | 

try {
    final response = api.submitVisitedResiliencyResources(visitedResiliencyResources);
    print(response);
} catch on DioError (e) {
    print('Exception when calling DefaultApi->submitVisitedResiliencyResources: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **visitedResiliencyResources** | [**VisitedResiliencyResources**](VisitedResiliencyResources.md)|  | [optional] 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

