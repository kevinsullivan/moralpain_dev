// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resiliency_resources.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResiliencyResources extends ResiliencyResources {
  @override
  final String? version;
  @override
  final BuiltList<ResiliencyResource>? resources;

  factory _$ResiliencyResources(
          [void Function(ResiliencyResourcesBuilder)? updates]) =>
      (new ResiliencyResourcesBuilder()..update(updates)).build();

  _$ResiliencyResources._({this.version, this.resources}) : super._();

  @override
  ResiliencyResources rebuild(
          void Function(ResiliencyResourcesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResiliencyResourcesBuilder toBuilder() =>
      new ResiliencyResourcesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResiliencyResources &&
        version == other.version &&
        resources == other.resources;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, version.hashCode), resources.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ResiliencyResources')
          ..add('version', version)
          ..add('resources', resources))
        .toString();
  }
}

class ResiliencyResourcesBuilder
    implements Builder<ResiliencyResources, ResiliencyResourcesBuilder> {
  _$ResiliencyResources? _$v;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  ListBuilder<ResiliencyResource>? _resources;
  ListBuilder<ResiliencyResource> get resources =>
      _$this._resources ??= new ListBuilder<ResiliencyResource>();
  set resources(ListBuilder<ResiliencyResource>? resources) =>
      _$this._resources = resources;

  ResiliencyResourcesBuilder() {
    ResiliencyResources._defaults(this);
  }

  ResiliencyResourcesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _resources = $v.resources?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResiliencyResources other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ResiliencyResources;
  }

  @override
  void update(void Function(ResiliencyResourcesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ResiliencyResources build() {
    _$ResiliencyResources _$result;
    try {
      _$result = _$v ??
          new _$ResiliencyResources._(
              version: version, resources: _resources?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'resources';
        _resources?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ResiliencyResources', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
