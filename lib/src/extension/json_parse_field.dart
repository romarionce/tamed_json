// Need to prevent analyser warning
// ignore_for_file: library_private_types_in_public_api

import 'package:tamed_json/src/exception/json_parse_field_exception.dart';
import 'package:tamed_json/src/model/json_unknown_type.dart';
import 'package:tamed_json/src/types/json.dart';

// Override double type in file
// use json.double()
typedef _Double = double;

extension JsonParseField on JsonMap {
  dynamic _get(String? key) => key == null ? this : this[key];

  JsonParseFieldException _parseError(String type, String? key) =>
      JsonParseFieldException(type: type, json: this, key: key);

  T _parseGeneric<T>(String? key, T? or, {bool isNullable = false}) {
    var data = _get(key);

    try {
      dynamic tryResult = JsonUnknownType();
      if (T == String || T == bool || data == null) {
        tryResult = data;
      } else if (T == int) {
        tryResult = (data as num).toInt();
      } else if (T == _Double) {
        tryResult = (data as num).toDouble();
      }

      if (tryResult != null && tryResult is! JsonUnknownType) {
        return tryResult as T;
      }

      if (isNullable && tryResult == null) {
        return tryResult as T;
      }

      throw tryResult;
    } catch (e) {
      if (or != null) return or;
      final isNullableStr = isNullable ? '?' : '';
      throw _parseError('$T$isNullableStr', key);
    }
  }

  /// Read int value from [key] with default [or] value
  int integer(String? key, {int? or}) => _parseGeneric<int>(key, or);

  /// Read int? value from [key] with default [or] value
  int? integerNull([String? key, int? or]) =>
      _parseGeneric<int>(key, or, isNullable: true);

  /// Read double value from [key] with default [or] value
  _Double double([String? key, _Double? or]) => _parseGeneric<_Double>(key, or);

  /// Read double? value from [key] with default [or] value
  _Double doubleNull([String? key, _Double? or]) =>
      _parseGeneric<_Double>(key, or, isNullable: true);

  /// Read String value from [key] with default [or] value
  String string([String? key, String? or]) => _parseGeneric<String>(key, or);

  /// Read String? value from [key] with default [or] value
  String? stringNull([String? key, String? or]) =>
      _parseGeneric<String>(key, or, isNullable: true);

  /// Read bool value from [key] with default [or] value
  bool boolean([String? key, bool? or]) => _parseGeneric<bool>(key, or);

  /// Read bool? value from [key] with default [or] value
  bool booleanNull([String? key, bool? or]) =>
      _parseGeneric<bool>(key, or, isNullable: true);
}
