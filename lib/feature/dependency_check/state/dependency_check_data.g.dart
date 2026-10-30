// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependency_check_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DependencyCheckDataCWProxy {
  DependencyCheckData cjxlAvailable(bool cjxlAvailable);

  DependencyCheckData cwebpAvailable(bool cwebpAvailable);

  DependencyCheckData exiftoolAvailable(bool exiftoolAvailable);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `DependencyCheckData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DependencyCheckData(...).copyWith(id: 12, name: "My name")
  /// ```
  DependencyCheckData call({
    bool cjxlAvailable,
    bool cwebpAvailable,
    bool exiftoolAvailable,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDependencyCheckData.copyWith(...)` or call `instanceOfDependencyCheckData.copyWith.fieldName(value)` for a single field.
class _$DependencyCheckDataCWProxyImpl implements _$DependencyCheckDataCWProxy {
  const _$DependencyCheckDataCWProxyImpl(this._value);

  final DependencyCheckData _value;

  @override
  DependencyCheckData cjxlAvailable(bool cjxlAvailable) =>
      call(cjxlAvailable: cjxlAvailable);

  @override
  DependencyCheckData cwebpAvailable(bool cwebpAvailable) =>
      call(cwebpAvailable: cwebpAvailable);

  @override
  DependencyCheckData exiftoolAvailable(bool exiftoolAvailable) =>
      call(exiftoolAvailable: exiftoolAvailable);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `DependencyCheckData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DependencyCheckData(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  DependencyCheckData call({
    Object? cjxlAvailable = const $CopyWithPlaceholder(),
    Object? cwebpAvailable = const $CopyWithPlaceholder(),
    Object? exiftoolAvailable = const $CopyWithPlaceholder(),
  }) {
    return DependencyCheckData(
      cjxlAvailable:
          cjxlAvailable == const $CopyWithPlaceholder() || cjxlAvailable == null
          ? _value.cjxlAvailable
          // ignore: cast_nullable_to_non_nullable
          : cjxlAvailable as bool,
      cwebpAvailable:
          cwebpAvailable == const $CopyWithPlaceholder() ||
              cwebpAvailable == null
          ? _value.cwebpAvailable
          // ignore: cast_nullable_to_non_nullable
          : cwebpAvailable as bool,
      exiftoolAvailable:
          exiftoolAvailable == const $CopyWithPlaceholder() ||
              exiftoolAvailable == null
          ? _value.exiftoolAvailable
          // ignore: cast_nullable_to_non_nullable
          : exiftoolAvailable as bool,
    );
  }
}

extension $DependencyCheckDataCopyWith on DependencyCheckData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDependencyCheckData.copyWith(...)` or `instanceOfDependencyCheckData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DependencyCheckDataCWProxy get copyWith =>
      _$DependencyCheckDataCWProxyImpl(this);
}
