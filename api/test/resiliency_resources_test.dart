import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';

// tests for ResiliencyResources
void main() {
  final json = '''
    {
      "version": "0.1", 
      "resources": [
        { 
          "resourceId": "Bush",
          "title": "Machinehead",
          "description": "Breathe In, Breathe Out",
          "url": "https://www.youtube.com/watch?v=5WPbqYoz9HA",
          "icon": { 
            "codePoint": "U+0420",
            "fontFamily": "Papyrus",
            "fontPackage": "foo" 
          } 
        } 
      ]
    }
  ''';
  final instance =
      standardSerializers.fromJson(ResiliencyResources.serializer, json)!;

  group(ResiliencyResources, () {
    // String version
    test('to test the property `version`', () async {
      expect("0.1", instance.version);
    });

    // BuiltList<ResiliencyResource> resources
    test('to test the property `resources`', () async {
      expect(1, instance.resources!.length);
    });
  });
}
