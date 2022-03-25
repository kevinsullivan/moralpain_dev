// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resiliency_resource.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResiliencyResource extends ResiliencyResource {
  @override
  final String? resourceId;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? url;
  @override
  final Icon? icon;

  factory _$ResiliencyResource(
          [void Function(ResiliencyResourceBuilder)? updates]) =>
      (new ResiliencyResourceBuilder()..update(updates)).build();

  _$ResiliencyResource._(
      {this.resourceId, this.title, this.description, this.url, this.icon})
      : super._();

  @override
  ResiliencyResource rebuild(
          void Function(ResiliencyResourceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResiliencyResourceBuilder toBuilder() =>
      new ResiliencyResourceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResiliencyResource &&
        resourceId == other.resourceId &&
        title == other.title &&
        description == other.description &&
        url == other.url &&
        icon == other.icon;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, resourceId.hashCode), title.hashCode),
                description.hashCode),
            url.hashCode),
        icon.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ResiliencyResource')
          ..add('resourceId', resourceId)
          ..add('title', title)
          ..add('description', description)
          ..add('url', url)
          ..add('icon', icon))
        .toString();
  }
}

class ResiliencyResourceBuilder
    implements Builder<ResiliencyResource, ResiliencyResourceBuilder> {
  _$ResiliencyResource? _$v;

  String? _resourceId;
  String? get resourceId => _$this._resourceId;
  set resourceId(String? resourceId) => _$this._resourceId = resourceId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  IconBuilder? _icon;
  IconBuilder get icon => _$this._icon ??= new IconBuilder();
  set icon(IconBuilder? icon) => _$this._icon = icon;

  ResiliencyResourceBuilder() {
    ResiliencyResource._defaults(this);
  }

  ResiliencyResourceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _resourceId = $v.resourceId;
      _title = $v.title;
      _description = $v.description;
      _url = $v.url;
      _icon = $v.icon?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResiliencyResource other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ResiliencyResource;
  }

  @override
  void update(void Function(ResiliencyResourceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ResiliencyResource build() {
    _$ResiliencyResource _$result;
    try {
      _$result = _$v ??
          new _$ResiliencyResource._(
              resourceId: resourceId,
              title: title,
              description: description,
              url: url,
              icon: _icon?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'icon';
        _icon?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ResiliencyResource', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
