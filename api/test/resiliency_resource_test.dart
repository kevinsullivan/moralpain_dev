import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';

// tests for ResiliencyResource
void main() {
  final json = '''
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
  ''';
  final instance =
      standardSerializers.fromJson(ResiliencyResource.serializer, json)!;

  group(ResiliencyResource, () {
    // String resourceId
    test('to test the property `resourceId`', () async {
      expect("Bush", instance.resourceId);
    });

    // String title
    test('to test the property `title`', () async {
      expect("Machinehead", instance.title);
    });

    // String description
    test('to test the property `description`', () async {
      expect("Breathe In, Breathe Out", instance.description);
    });

    // String url
    test('to test the property `url`', () async {
      expect("https://www.youtube.com/watch?v=5WPbqYoz9HA", instance.url);
    });

    // Icon icon
    test('to test the property `icon`', () async {
      expect("U+0420", instance.icon!.codePoint);
    });
  });
}
