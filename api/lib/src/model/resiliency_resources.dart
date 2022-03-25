//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:moralpainapi/src/model/resiliency_resource.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'resiliency_resources.g.dart';

/// ResiliencyResources
///
/// Properties:
/// * [version] 
/// * [resources] 
abstract class ResiliencyResources implements Built<ResiliencyResources, ResiliencyResourcesBuilder> {
    @BuiltValueField(wireName: r'version')
    String? get version;

    @BuiltValueField(wireName: r'resources')
    BuiltList<ResiliencyResource>? get resources;

    ResiliencyResources._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(ResiliencyResourcesBuilder b) => b;

    factory ResiliencyResources([void updates(ResiliencyResourcesBuilder b)]) = _$ResiliencyResources;

    @BuiltValueSerializer(custom: true)
    static Serializer<ResiliencyResources> get serializer => _$ResiliencyResourcesSerializer();
}

class _$ResiliencyResourcesSerializer implements StructuredSerializer<ResiliencyResources> {
    @override
    final Iterable<Type> types = const [ResiliencyResources, _$ResiliencyResources];

    @override
    final String wireName = r'ResiliencyResources';

    @override
    Iterable<Object?> serialize(Serializers serializers, ResiliencyResources object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.version != null) {
            result
                ..add(r'version')
                ..add(serializers.serialize(object.version,
                    specifiedType: const FullType(String)));
        }
        if (object.resources != null) {
            result
                ..add(r'resources')
                ..add(serializers.serialize(object.resources,
                    specifiedType: const FullType(BuiltList, [FullType(ResiliencyResource)])));
        }
        return result;
    }

    @override
    ResiliencyResources deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = ResiliencyResourcesBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'version':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.version = valueDes;
                    break;
                case r'resources':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(ResiliencyResource)])) as BuiltList<ResiliencyResource>;
                    result.resources.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

