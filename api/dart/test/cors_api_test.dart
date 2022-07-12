import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';


/// tests for CORSApi
void main() {
  final instance = Moralpainapi().getCORSApi();

  group(CORSApi, () {
    // CORS admin submissions support
    //
    // Enable CORS by returning correct headers 
    //
    //Future optionsAdminSubmissions() async
    test('test optionsAdminSubmissions', () async {
      // TODO
    });

    // CORS survey support
    //
    // Enable CORS by returning correct headers 
    //
    //Future optionsSurvey() async
    test('test optionsSurvey', () async {
      // TODO
    });

    // CORS resiliency resources support
    //
    // Enable CORS by returning correct headers 
    //
    //Future optionsVisitedResiliencyResources() async
    test('test optionsVisitedResiliencyResources', () async {
      // TODO
    });

  });
}
