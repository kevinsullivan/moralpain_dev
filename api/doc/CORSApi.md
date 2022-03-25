# moralpainapi.api.CORSApi

## Load the API package
```dart
import 'package:moralpainapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**resiliencyOptions**](CORSApi.md#resiliencyoptions) | **OPTIONS** /resiliency | CORS support
[**surveyOptions**](CORSApi.md#surveyoptions) | **OPTIONS** /survey | CORS support


# **resiliencyOptions**
> resiliencyOptions()

CORS support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getCORSApi();

try {
    api.resiliencyOptions();
} catch on DioError (e) {
    print('Exception when calling CORSApi->resiliencyOptions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **surveyOptions**
> surveyOptions()

CORS support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getCORSApi();

try {
    api.surveyOptions();
} catch on DioError (e) {
    print('Exception when calling CORSApi->surveyOptions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

