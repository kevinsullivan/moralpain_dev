// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Icon extends Icon {
  @override
  final String? codePoint;
  @override
  final String? fontFamily;
  @override
  final String? fontPackage;

  factory _$Icon([void Function(IconBuilder)? updates]) =>
      (new IconBuilder()..update(updates)).build();

  _$Icon._({this.codePoint, this.fontFamily, this.fontPackage}) : super._();

  @override
  Icon rebuild(void Function(IconBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IconBuilder toBuilder() => new IconBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Icon &&
        codePoint == other.codePoint &&
        fontFamily == other.fontFamily &&
        fontPackage == other.fontPackage;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, codePoint.hashCode), fontFamily.hashCode),
        fontPackage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Icon')
          ..add('codePoint', codePoint)
          ..add('fontFamily', fontFamily)
          ..add('fontPackage', fontPackage))
        .toString();
  }
}

class IconBuilder implements Builder<Icon, IconBuilder> {
  _$Icon? _$v;

  String? _codePoint;
  String? get codePoint => _$this._codePoint;
  set codePoint(String? codePoint) => _$this._codePoint = codePoint;

  String? _fontFamily;
  String? get fontFamily => _$this._fontFamily;
  set fontFamily(String? fontFamily) => _$this._fontFamily = fontFamily;

  String? _fontPackage;
  String? get fontPackage => _$this._fontPackage;
  set fontPackage(String? fontPackage) => _$this._fontPackage = fontPackage;

  IconBuilder() {
    Icon._defaults(this);
  }

  IconBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _codePoint = $v.codePoint;
      _fontFamily = $v.fontFamily;
      _fontPackage = $v.fontPackage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Icon other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Icon;
  }

  @override
  void update(void Function(IconBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Icon build() {
    final _$result = _$v ??
        new _$Icon._(
            codePoint: codePoint,
            fontFamily: fontFamily,
            fontPackage: fontPackage);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
