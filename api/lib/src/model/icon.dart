//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'icon.g.dart';

/// Icon
///
/// Properties:
/// * [codePoint] 
/// * [fontFamily] 
/// * [fontPackage] 
abstract class Icon implements Built<Icon, IconBuilder> {
    @BuiltValueField(wireName: r'codePoint')
    String? get codePoint;

    @BuiltValueField(wireName: r'fontFamily')
    String? get fontFamily;

    @BuiltValueField(wireName: r'fontPackage')
    String? get fontPackage;

    Icon._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(IconBuilder b) => b;

    factory Icon([void updates(IconBuilder b)]) = _$Icon;

    @BuiltValueSerializer(custom: true)
    static Serializer<Icon> get serializer => _$IconSerializer();
}

class _$IconSerializer implements StructuredSerializer<Icon> {
    @override
    final Iterable<Type> types = const [Icon, _$Icon];

    @override
    final String wireName = r'Icon';

    @override
    Iterable<Object?> serialize(Serializers serializers, Icon object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.codePoint != null) {
            result
                ..add(r'codePoint')
                ..add(serializers.serialize(object.codePoint,
                    specifiedType: const FullType(String)));
        }
        if (object.fontFamily != null) {
            result
                ..add(r'fontFamily')
                ..add(serializers.serialize(object.fontFamily,
                    specifiedType: const FullType(String)));
        }
        if (object.fontPackage != null) {
            result
                ..add(r'fontPackage')
                ..add(serializers.serialize(object.fontPackage,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    Icon deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = IconBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'codePoint':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.codePoint = valueDes;
                    break;
                case r'fontFamily':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.fontFamily = valueDes;
                    break;
                case r'fontPackage':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.fontPackage = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

