//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:moralpainapi/src/model/icon.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'resiliency_resource.g.dart';

/// ResiliencyResource
///
/// Properties:
/// * [resourceId] 
/// * [title] 
/// * [description] 
/// * [url] 
/// * [icon] 
abstract class ResiliencyResource implements Built<ResiliencyResource, ResiliencyResourceBuilder> {
    @BuiltValueField(wireName: r'resourceId')
    String? get resourceId;

    @BuiltValueField(wireName: r'title')
    String? get title;

    @BuiltValueField(wireName: r'description')
    String? get description;

    @BuiltValueField(wireName: r'url')
    String? get url;

    @BuiltValueField(wireName: r'icon')
    Icon? get icon;

    ResiliencyResource._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(ResiliencyResourceBuilder b) => b;

    factory ResiliencyResource([void updates(ResiliencyResourceBuilder b)]) = _$ResiliencyResource;

    @BuiltValueSerializer(custom: true)
    static Serializer<ResiliencyResource> get serializer => _$ResiliencyResourceSerializer();
}

class _$ResiliencyResourceSerializer implements StructuredSerializer<ResiliencyResource> {
    @override
    final Iterable<Type> types = const [ResiliencyResource, _$ResiliencyResource];

    @override
    final String wireName = r'ResiliencyResource';

    @override
    Iterable<Object?> serialize(Serializers serializers, ResiliencyResource object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.resourceId != null) {
            result
                ..add(r'resourceId')
                ..add(serializers.serialize(object.resourceId,
                    specifiedType: const FullType(String)));
        }
        if (object.title != null) {
            result
                ..add(r'title')
                ..add(serializers.serialize(object.title,
                    specifiedType: const FullType(String)));
        }
        if (object.description != null) {
            result
                ..add(r'description')
                ..add(serializers.serialize(object.description,
                    specifiedType: const FullType(String)));
        }
        if (object.url != null) {
            result
                ..add(r'url')
                ..add(serializers.serialize(object.url,
                    specifiedType: const FullType(String)));
        }
        if (object.icon != null) {
            result
                ..add(r'icon')
                ..add(serializers.serialize(object.icon,
                    specifiedType: const FullType(Icon)));
        }
        return result;
    }

    @override
    ResiliencyResource deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = ResiliencyResourceBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'resourceId':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.resourceId = valueDes;
                    break;
                case r'title':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.title = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.description = valueDes;
                    break;
                case r'url':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.url = valueDes;
                    break;
                case r'icon':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(Icon)) as Icon;
                    result.icon.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

