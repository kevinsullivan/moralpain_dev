import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';

// tests for VisitedResiliencyResources
void main() {
  final json = '''
    {
      "timestamp": 0, 
      "selections": [
        "a",
        "b"
      ]
    }
  ''';
  final instance = standardSerializers.fromJson(
      VisitedResiliencyResources.serializer, json)!;

  group(VisitedResiliencyResources, () {
    // BuiltList<String> selections
    test('to test the property `selections`', () async {
      expect(2, instance.selections!.length);
    });

    // int timestamp
    test('to test the property `timestamp`', () async {
      expect(0, instance.timestamp);
    });
  });
}
