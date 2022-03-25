//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'visited_resiliency_resources.g.dart';

/// VisitedResiliencyResources
///
/// Properties:
/// * [selections] 
/// * [timestamp] 
abstract class VisitedResiliencyResources implements Built<VisitedResiliencyResources, VisitedResiliencyResourcesBuilder> {
    @BuiltValueField(wireName: r'selections')
    BuiltList<String>? get selections;

    @BuiltValueField(wireName: r'timestamp')
    int? get timestamp;

    VisitedResiliencyResources._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(VisitedResiliencyResourcesBuilder b) => b;

    factory VisitedResiliencyResources([void updates(VisitedResiliencyResourcesBuilder b)]) = _$VisitedResiliencyResources;

    @BuiltValueSerializer(custom: true)
    static Serializer<VisitedResiliencyResources> get serializer => _$VisitedResiliencyResourcesSerializer();
}

class _$VisitedResiliencyResourcesSerializer implements StructuredSerializer<VisitedResiliencyResources> {
    @override
    final Iterable<Type> types = const [VisitedResiliencyResources, _$VisitedResiliencyResources];

    @override
    final String wireName = r'VisitedResiliencyResources';

    @override
    Iterable<Object?> serialize(Serializers serializers, VisitedResiliencyResources object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.selections != null) {
            result
                ..add(r'selections')
                ..add(serializers.serialize(object.selections,
                    specifiedType: const FullType(BuiltList, [FullType(String)])));
        }
        if (object.timestamp != null) {
            result
                ..add(r'timestamp')
                ..add(serializers.serialize(object.timestamp,
                    specifiedType: const FullType(int)));
        }
        return result;
    }

    @override
    VisitedResiliencyResources deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = VisitedResiliencyResourcesBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'selections':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(String)])) as BuiltList<String>;
                    result.selections.replace(valueDes);
                    break;
                case r'timestamp':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.timestamp = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

