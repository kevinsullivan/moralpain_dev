import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';

// tests for Icon
void main() {
  final json = '''
    { 
      "codePoint": "U+0420",
      "fontFamily": "Papyrus",
      "fontPackage": "foo" 
    } 
  ''';
  final instance = standardSerializers.fromJson(Icon.serializer, json)!;

  group(Icon, () {
    // String codePoint
    test('to test the property `codePoint`', () async {
      expect("U+0420", instance.codePoint);
    });

    // String fontFamily
    test('to test the property `fontFamily`', () async {
      expect("Papyrus", instance.fontFamily);
    });

    // String fontPackage
    test('to test the property `fontPackage`', () async {
      expect("foo", instance.fontPackage);
    });
  });
}
