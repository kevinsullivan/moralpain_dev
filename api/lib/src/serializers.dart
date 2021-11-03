//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:moralpainapi/src/date_serializer.dart';
import 'package:moralpainapi/src/model/date.dart';

import 'package:moralpainapi/src/model/submission.dart';
import 'package:moralpainapi/src/model/survey.dart';
import 'package:moralpainapi/src/model/survey_option.dart';
import 'package:moralpainapi/src/model/survey_section.dart';

part 'serializers.g.dart';

@SerializersFor([
  Submission,
  Survey,
  SurveyOption,
  SurveySection,
])
Serializers serializers = (_$serializers.toBuilder()
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();