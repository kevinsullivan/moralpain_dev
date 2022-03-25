// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visited_resiliency_resources.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VisitedResiliencyResources extends VisitedResiliencyResources {
  @override
  final BuiltList<String>? selections;
  @override
  final int? timestamp;

  factory _$VisitedResiliencyResources(
          [void Function(VisitedResiliencyResourcesBuilder)? updates]) =>
      (new VisitedResiliencyResourcesBuilder()..update(updates)).build();

  _$VisitedResiliencyResources._({this.selections, this.timestamp}) : super._();

  @override
  VisitedResiliencyResources rebuild(
          void Function(VisitedResiliencyResourcesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VisitedResiliencyResourcesBuilder toBuilder() =>
      new VisitedResiliencyResourcesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VisitedResiliencyResources &&
        selections == other.selections &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, selections.hashCode), timestamp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VisitedResiliencyResources')
          ..add('selections', selections)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class VisitedResiliencyResourcesBuilder
    implements
        Builder<VisitedResiliencyResources, VisitedResiliencyResourcesBuilder> {
  _$VisitedResiliencyResources? _$v;

  ListBuilder<String>? _selections;
  ListBuilder<String> get selections =>
      _$this._selections ??= new ListBuilder<String>();
  set selections(ListBuilder<String>? selections) =>
      _$this._selections = selections;

  int? _timestamp;
  int? get timestamp => _$this._timestamp;
  set timestamp(int? timestamp) => _$this._timestamp = timestamp;

  VisitedResiliencyResourcesBuilder() {
    VisitedResiliencyResources._defaults(this);
  }

  VisitedResiliencyResourcesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _selections = $v.selections?.toBuilder();
      _timestamp = $v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VisitedResiliencyResources other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VisitedResiliencyResources;
  }

  @override
  void update(void Function(VisitedResiliencyResourcesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$VisitedResiliencyResources build() {
    _$VisitedResiliencyResources _$result;
    try {
      _$result = _$v ??
          new _$VisitedResiliencyResources._(
              selections: _selections?.build(), timestamp: timestamp);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'selections';
        _selections?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'VisitedResiliencyResources', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
